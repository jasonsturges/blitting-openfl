/*
     |      | _)  |    |   _)
     __ \   |  |  __|  __|  |  __ \    _` |
     |   |  |  |  |    |    |  |   |  (   |
    _.__/  _| _| \__| \__| _| _|  _| \__, |
                                     |___/
    Blitting, http://blitting.com
    Copyright (c) 2014 Jason Sturges, http://jasonsturges.com
*/
package blitting.util;

class DateUtil {

    /**
     *  Whether the current time is Ante meridiem (AM) or
     *  Post meridiem (PM), for 12-hour clock.
     *  @param date
     *  @return String
     */
    public static function meridiem(date:Date):String {
        return (date.getHours() > 11) ? "pm" : "am";
    }

    /**
     *  Whether the specified year is leap year.
     *  @param year
     *  @return Bool
     */
    public static function isLeapYear(year:Int):Bool {
        return daysInMonth(year, 1) == 29;
    }

    /**
     *  Number of days in the specified month.
     *  @param year   Full year as Int (ex: 2000).
     *  @param month  Month as Int, zero-based (ex: 0=January, 11=December). 
     *  @return Int
     */
    public static function daysInMonth(year:Int, month:Int):Int {
        return (new Date(year, ++month, 0, 0, 0, 0).getDate());
    }

    /**
     *  Get today's date at start of day - zero-hour, at midnight.
     *  @param date   Optional date.
     *  @return Date
     */
    public static function today(date:Date = null):Date {
        if (date == null)
            date = Date.now();

        return new Date(date.getFullYear(), date.getMonth(), date.getDate(), 0, 0, 0);
    }

}


