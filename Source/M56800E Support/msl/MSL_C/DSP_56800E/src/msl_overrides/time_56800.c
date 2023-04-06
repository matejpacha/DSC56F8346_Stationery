/* MSL
 * Copyright © 1995-2007 Freescale Corporation.  All rights reserved.
 *
 * $Date: 2006/01/31 21:06:36 $
 * $Revision: 1.4 $
 */

#include <ansi_parms.h>
#include <time.h>
#include <stdlib.h>
#include <limits.h>
#include <arith.h>

#define seconds_per_minute	(60L)
#define seconds_per_hour		(60L * seconds_per_minute)
#define seconds_per_day			(24L * seconds_per_hour)
#define seconds_1900_to_1970   (((365 * 70UL) + 17) * 24 * 60 * 60)

const short __msl_month_to_days[2][13] =
	{
	{0,31,59,90, 120, 151, 181, 212, 243, 273, 304,334, 365 },
	{0,31,60,91, 121, 152, 182, 213, 244, 274, 305,335, 366 }
	};


int __msl_leap_year(int year)
{
	return(__msl_mod(year, 4) == 0 && (__msl_mod(year, 100) != 0 || __msl_mod(year, 400) == 100));
}

static int leap_days(int year, int mon)
{
	int		n;
	div_t	q;

	q = div(year, 4);
	/* 1 leap day every four years */

	n = q.quot;

	q = div(year, 100);						/* except at the turn of the century */

	n -= q.quot;

	if (year < 100)
	/* not counting the turn of the millenium */
	{
		q = __msl_div(year+899, 1000);		/*- cc 010510 -*/
		n += q.quot;
	}
	else
	{
		q = __msl_div(year-100, 1000);	/*- cc 010510 -*/
		n += q.quot + 1;
	}

	if (__msl_leap_year(year))
		if (year < 0)
		{
			if (mon > 1)
				++n;
		}
		else
			if (mon <= 1)
				--n;

	return(n);
}

/*
 *	adjust - force x to be a modulo y number, add overflow to z
 */

static int adjust(int * x, int y, int * z)
{
	div_t q;
	q = __msl_div(*x, y); /*- cc 010510 -*/
	*x = q.rem;

	return(__msl_add(z, q.quot));	/*- cc 010510 -*/
}

/*
 *	__msl_time2tm - convert seconds since midnight, 1/1/1900 (or 1970 on Win32),
 *	to broken-down time
 */

void __msl_time2tm(time_t inTime, struct tm *tm)
{
	unsigned long	years, months, days, seconds;
	int				is_leap_year;

		/* Since time_t is relative to 1970 rather than 1900,
		 * This must be of type unsigned long rather than a signed
		 * time_t to prevent overflow */
	unsigned long time = inTime + seconds_1900_to_1970;

	if (!tm)
		return;
#if _MSL_OS_TIME_SUPPORT	
	tm->tm_isdst = __isdst();
#endif /* _MSL_OS_TIME_SUPPORT*/
	
	days    = time / seconds_per_day;
	seconds = time % seconds_per_day;

	tm->tm_wday = (days + 1) % 7;
			/* January 1, 1900 was a Monday */

	years = 0;

	for (;;)
	{
		unsigned long days_this_year = __msl_leap_year(years) ? 366 : 365;

		if (days < days_this_year)
			break;

		days  -= days_this_year;
		years += 1;
	}

	tm->tm_year = years;
	tm->tm_yday = days;

	months = 0;

	is_leap_year = __msl_leap_year(years);

	for (;;)
	{
		unsigned long days_thru_this_month = __msl_month_to_days[is_leap_year][months+1];

		if (days < days_thru_this_month)
		{
			days -= __msl_month_to_days[is_leap_year][months];
			break;
		}

		++months;
	}

	tm->tm_mon  = months;
	tm->tm_mday = days + 1;

	tm->tm_hour = seconds / seconds_per_hour;

	seconds %= seconds_per_hour;

	tm->tm_min = seconds / seconds_per_minute;
	tm->tm_sec = seconds % seconds_per_minute;
}

static int __tm2time(struct tm * tm, time_t * time)
{
	long		days;
	time_t	seconds, day_secs;

	if (!tm || !time)
		return(0);

	/* I don't know why it isn't     */
	--tm->tm_mday;
	/* zero-based in the first place */

	if (!adjust(&tm->tm_sec,  60, &tm->tm_min))	goto no_exit;
			/* put sec  in range 0-59 */
	if (!adjust(&tm->tm_min,  60, &tm->tm_hour))	goto no_exit;
		/* put min  in range 0-59 */
	if (!adjust(&tm->tm_hour, 24, &tm->tm_mday))	goto no_exit;
		/* put hour in range 0-23 */

	if (!adjust(&tm->tm_mon,  12, &tm->tm_year))	goto no_exit;
		/* put mon  in range 0-11 */

	days = tm->tm_year;

	if (!__msl_lmul(&days, 365))									/*- cc 010510 -*/

		goto no_exit;		/* convert year to days */
	if (!__msl_ladd(&days, leap_days(tm->tm_year, tm->tm_mon)))		/*- cc 010510 -*/
		goto no_exit;		/* add leap days */
	if (!__msl_ladd(&days, __msl_month_to_days[0][tm->tm_mon]))		/*- cc 010510 -*/
		goto no_exit;		/* add days to month */
	if (!__msl_ladd(&days, tm->tm_mday))							/*- cc 010510 -*/
		goto no_exit;		/* add days in month */
	if (days < 0 || days > (ULONG_MAX / seconds_per_day))
				/* make sure we're in range */
		goto no_exit;

	day_secs = days * seconds_per_day;

		/* convert days to seconds */

	seconds = (tm->tm_hour * seconds_per_hour) 	 +
							/* convert HMS to seconds */
						(tm->tm_min  * seconds_per_minute) + tm->tm_sec;

	if (seconds > ULONG_MAX - day_secs)

		/* make sure there's room */
		goto no_exit;

	seconds += day_secs;

		/* Make this number relative to 1970 rather than 1900 */		/*- mm 000127 -*/
	seconds -= seconds_1900_to_1970;									/*- mm 000127 -*/

	*time = seconds;

	__msl_time2tm(seconds, tm);

	return(1);

no_exit:

	return(0);
}


void __msl_clear_tm(struct tm *tm)
{
	tm->tm_sec   =  0;
	tm->tm_min   =  0;
	tm->tm_hour  =  0;
	tm->tm_mday  =  1;
	tm->tm_mon   =  0;
	tm->tm_year  =  0;
	tm->tm_wday  =  1;
	tm->tm_yday  =  0;
	tm->tm_isdst = -1;
}

time_t _MSL_CDECL mktime(struct tm * timeptr)
{
	struct tm	tm = *timeptr;
	time_t 		time;
	
	if (!__tm2time(&tm, &time))
		return((time_t) -1);
	
	*timeptr = tm;
	
#if !_MSL_TIME_T_IS_LOCALTIME
	if (!__to_gm_time(&time))
		return((time_t) -1);
#endif /* !_MSL_TIME_T_IS_LOCALTIME */
	
	return(time);
}


struct tm * _MSL_CDECL localtime(const time_t * timer)
{
	time_t time;
	
#if !_MSL_THREADSAFE || !_MSL_LOCALDATA_AVAILABLE
	static struct tm localtime_tm;
#endif
	
	if (!timer)
	{
		__msl_clear_tm(&_MSL_LOCALDATA(localtime_tm));
		#if _MSL_OS_TIME_SUPPORT
			_MSL_LOCALDATA(localtime_tm).tm_isdst = __isdst();
		#endif /* _MSL_OS_TIME_SUPPORT */
		return(&_MSL_LOCALDATA(localtime_tm));
	}
	
	time = *timer;
	
#if !_MSL_TIME_T_IS_LOCALTIME
	if (!__to_local_time(&time))
		return(NULL);
#endif /* !_MSL_TIME_T_IS_LOCALTIME */
	
	__msl_time2tm(time, &_MSL_LOCALDATA(localtime_tm));
#if _MSL_OS_TIME_SUPPORT
	_MSL_LOCALDATA(localtime_tm).tm_isdst = __isdst();
#endif	/* _MSL_OS_TIME_SUPPORT */
	return(&_MSL_LOCALDATA(localtime_tm));
}


/* Change record:
 * cc  041012 Added time support for DSP SDK
 */