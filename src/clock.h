#ifndef CLOCK_H
#define CLOCK_H

#include <chrono>

using Clock = std::chrono::steady_clock;
using Seconds = std::chrono::duration<long double>;
using duration = Clock::duration;
using time_point = Clock::time_point;
using std::chrono::duration_cast;

#endif
