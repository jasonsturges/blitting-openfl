package
class DateUtil {

    /**
        Whether the current time is Ante meridiem (AM) or
        Post meridiem (PM), for 12-hour clock.
    **/
    public static function meridiem(d:Date):String {
        return (d.getHours() > 11) ? "pm" : "am";
    }

    /**
        Whether daylight savings time is currently observed.
        TODO: Not implemented, pending resolution of consistent
              timezone offset.
    **/
    //public static function isDaylightSavings(d:Date):Bool {
    //}

    /**
	    Whether the specified year is leap year.
    **/
    public static function isLeapYear(year:Int):Bool {
        return daysInMonth(year, 1) == 29;
    }

    /**
        Number of days in the specified month.

        @param year   Full year as Int (ex: 2000).
        @param month  Month as Int, zero-based (ex: 0=January, 11=December).
    **/
    public static function daysInMonth(year:Int, month:Int):Int {
        return (new Date(year, ++month, 0, 0, 0, 0).getDate());
    }

    /**
        Get today's date at start of day.
        (zero-hour, at midnight).
    **/
    public static function today(date:Date = null):Date {
        if (date == null)
            date = Date.now();

        return new Date(date.getFullYear(), date.getMonth(), date.getDate(), 0, 0, 0);
    }

}


