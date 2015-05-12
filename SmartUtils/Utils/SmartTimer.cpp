/*
 * CSmartTimers.cpp
 *
 *  Created on: Apr 1, 2015
 *      Author: rock
 */

#include "SmartTimer.h"

#include <utility>
#include <sys/timerfd.h>
#include <cassert>
#include <sys/epoll.h>
#include <unistd.h>
#include <iostream>

namespace NSSmartUtils
{

const int64_t NANOS_OF_ONE_SECONDS = (1000 * 1000 * 1000);

ITimer::~ITimer()
{
	if (-1 == FileDescriptor_)
	{
		close(FileDescriptor_);
	}
}

int32_t ITimer::Create()
{
	SU_ASSERT(
			InitExpireNanos_ < NANOS_OF_ONE_SECONDS
					&& IntervalNanos_ < NANOS_OF_ONE_SECONDS);

	if (ETT_REALTIME != TimerType_ && ETT_MONOTONIC != TimerType_)
	{
		return EEC_ERR;
	}

	int32_t timer_type =
			ETT_REALTIME == TimerType_ ? CLOCK_REALTIME : CLOCK_MONOTONIC;

	struct timespec now =
	{ 0 };
	int32_t flags = 0;
#if (__ABS_TIME__)
	if (clock_gettime(timer_type, &now) == -1)
	{
		return EEC_ERR;
	}
	flags = TFD_TIMER_ABSTIME;
#endif

	struct itimerspec new_value =
	{ 0 };
	new_value.it_value.tv_sec = now.tv_sec + InitExpireSeconds_
			+ (now.tv_nsec + InitExpireNanos_) / NANOS_OF_ONE_SECONDS;
	new_value.it_value.tv_nsec = (now.tv_nsec + InitExpireNanos_)
			% NANOS_OF_ONE_SECONDS;
	new_value.it_interval.tv_sec = IntervalSeconds_
			+ IntervalNanos_ / NANOS_OF_ONE_SECONDS;
	new_value.it_interval.tv_nsec = IntervalNanos_ % NANOS_OF_ONE_SECONDS;

	FileDescriptor_ = timerfd_create(timer_type, 0);
	if (FileDescriptor_ == -1)
	{
		return EEC_ERR;
	}

	if (timerfd_settime(FileDescriptor_, flags, &new_value, NULL) == -1)
	{
		return EEC_ERR;
	}

	return EEC_SUC;
}

CSmartTimers::CSmartTimers() :
		StopFlag_(false), pThread_(nullptr), EpollFD_(-1)
{
	// TODO Auto-generated constructor stub
}

CSmartTimers::~CSmartTimers()
{
	// TODO Auto-generated destructor stub
}

int32_t CSmartTimers::Start()
{
	std::lock_guard < std::mutex > lock(StateLock_);

	if (pThread_ != nullptr)
	{
		SU_ASSERT(false);
		return EEC_ERR;
	}

	/*
	 * In the initial epoll_create() implementation, the size argument informed the kernel of the number  of  file  descriptors  that  the  caller
	 expected  to add to the epoll instance.  The kernel used this information as a hint for the amount of space to initially allocate in inter‐
	 nal data structures describing events.  (If necessary, the kernel would allocate more space if the caller's usage exceeded the  hint  given
	 in  size.)  Nowadays, this hint is no longer required (the kernel dynamically sizes the required data structures without needing the hint),
	 but size must still be greater than zero, in order to ensure backward compatibility when new epoll applications are run on older kernels.
	 * */
	EpollFD_ = epoll_create(MAX_TIMERS);
	if (EpollFD_ == -1)
	{
		SU_ASSERT(false);
		return EEC_ERR;
	}

	pThread_ = std::make_shared < std::thread > ([this]
	{	HandleTimers();});

	return EEC_SUC;
}

int32_t CSmartTimers::Stop()
{
	std::lock_guard < std::mutex > lock(StateLock_);

	if (pThread_ == nullptr)
	{
		SU_ASSERT(false);
		return EEC_ERR;
	}
	StopFlag_ = true;
	pThread_->join();
	pThread_ = nullptr;

	Timers_.clear();

	close(EpollFD_);
	EpollFD_ = -1;

	return EEC_SUC;
}

int32_t CSmartTimers::RegisterTimer(TimerPtr_t &ptimer)
{
	std::lock_guard < std::mutex > lock(TimersLock_);

	std::pair<TimersSet_t::iterator, bool> ret = Timers_.insert(ptimer);
	if (!ret.second)
	{
		return EEC_ERR;
	}

	if (ptimer->Create() == EEC_ERR)
	{
		Timers_.erase(ret.first);
		return EEC_ERR;
	}

	return EEC_SUC;
}

void CSmartTimers::HandleTimers()
{
	for (;;)
	{
		if (StopFlag_)
		{
			break;
		}

		//std::cout<<"run: "<<std::endl;

		{
			std::lock_guard < std::mutex > lock(TimersLock_); ///TheRock_Lhy: not suggest to register timer at runtime..
			///modify epoll set
			for (TimersSet_t::iterator itor = Timers_.begin();
					itor != Timers_.end();)
			{
				//std::cout << "count: " << (*itor).use_count() << std::endl;

				if ((*itor).unique())
				{
					//TheRock_Lhy: i confirm not to assign it to others:).
					///unregister it now.
					if (epoll_ctl(EpollFD_, EPOLL_CTL_DEL, (*itor)->GetFD(),
							NULL) == -1)
					{
						SU_ASSERT(false);
					}

					Timers_.erase(itor++);

				}
				else if (!(*itor)->IsRegistered())
				{
					///register it
					struct epoll_event ev =
					{ 0 };
					ev.events = EPOLLIN;
					ev.data.ptr = (*itor).get();
					if (epoll_ctl(EpollFD_, EPOLL_CTL_ADD, (*itor)->GetFD(),
							&ev) == -1)
					{
						SU_ASSERT(false);
					}

					(*itor)->Registered();
					itor++;
				}
				else
				{
					itor++;
				}
			}
		}

		struct epoll_event events[MAX_TIMERS] =
		{ 0 };
		int32_t nfds = 0, n = 0;
		const int32_t timeout = 1;
		uint64_t times = 0;
		ssize_t s = 0;
		for (;;)
		{
			nfds = epoll_wait(EpollFD_, events, MAX_TIMERS, timeout);
			if (nfds == -1)
			{
				SU_ASSERT(false);
				break;
			}

			for (n = 0; n < nfds; ++n)
			{
				ITimer *ptimer = static_cast<ITimer*>(events[n].data.ptr);
				s = read(ptimer->GetFD(), &times, sizeof(uint64_t));
				if (s != sizeof(uint64_t))
				{
					SU_ASSERT(false);
					return;
				}
				ptimer->HandleTimerEvent(times);
			}

			break;
		}
	}

}

} /* namespace ns_utils */
