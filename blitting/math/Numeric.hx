/*
     |      | _)  |    |   _)
     __ \   |  |  __|  __|  |  __ \    _` |
     |   |  |  |  |    |    |  |   |  (   |
    _.__/  _| _| \__| \__| _| _|  _| \__, |
                                     |___/
    Blitting, http://blitting.com
    Copyright (c) 2014-2017 Jason Sturges, http://jasonsturges.com

    Permission is hereby granted, free of charge, to any person obtaining a copy of
    this software and associated documentation files (the "Software"), to deal in
    the Software without restriction, including without limitation the rights to use,
    copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
    Software, and to permit persons to whom the Software is furnished to do so,
    subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
    FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
    COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
    AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
    THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
package blitting.math;

class Numeric {

    /**
     *  Constrain value within a minimum and maximum range.
     *  @param value  Value to clamp within range
     *  @param low    Minimum value
     *  @param high   Maximum value
     *  @return       Value within range
     */
    public static function clamp<T>(value:T, low:T, high:T):T {
        if (Reflect.compare(value, low) < 0)
            return low;
        if (Reflect.compare(value, high) > 0)
            return high;

        return value;
    }

    /**
     * Convert a ratio to a value, using the min and max values
     */
    public static function convertRatioToValue(value:Float, minValue:Float, maxValue:Float):Float {
        return (value * (maxValue - minValue)) + minValue;
    }

    /**
     * Convert a value to a ratio, using the min and max values
     */
    public static function convertValueToRatio(value:Float, minValue:Float, maxValue:Float):Float {
        var ratio:Float = 0.0;

        if (minValue != maxValue)
            ratio = (value - minValue) / (maxValue - minValue);

        return ratio;
    }

    /**
     * Check equality of two `Floats`.  Return true if both Floats are NaN.
     */
    public static function equalsFloat(num1:Float, num2:Float):Bool {
        return ((Math.isNaN(num1) && Math.isNaN(num2)) || (num1 == num2));
    }

    /**
     * Whether a number is odd value.
     *
     * Example:
     *
     *     Numeric.isOdd(1); // true
     *     Numeric.isOdd(2); // false
     */
    public static function isOdd(n:Int):Bool {
        return ((n & 1) == 1);
    }

    /**
     * Whether a number is even value.
     *
     * Example:
     *
     *     Numeric.isEven(1); // false
     *     Numeric.isEven(2); // true
     */
    public static function isEven(n:Int):Bool {
        return ((n & 1) == 0);
    }

    /**
     * Format a `Float` with thousands separator
     *
     * Formats the characteristic, leaving the mantissa.
     */
    public static function formatThousandsSeparator(value:String):String {
        var d:Int = value.indexOf('.');
        if (d < 0)
            d = value.length;
        var s:String = value.substr(0, d);
        var regex = ~/(\d)(?=(\d\d\d)+$)/g;
        s = regex.replace(s, "$1,");
        s += value.substr(d, (value.length - d));
        return (s);
    }

    /**
     * Convert a `Float` to a `String` of a specified length padded by zeroes.
     */
    public static function getPaddedFloat(value:Float, length:Int):String {
        // TODO: Determine if (""+value) is fastest conversion to string.
        var numString:String = "" + value;

        while (numString.length < length) {
            numString = "0" + numString;
        }

        return numString;
    }

    /**
     * Get a random `Float` where min &lt;= n &lt; max
     */
    public static function randomFloat(min:Float = 0, max:Float = 1, precision:Int = -1):Float {
        min = (!Math.isNaN(min)) ? (min) : (0);
        max = (!Math.isNaN(max)) ? (max) : (1);

        var num:Float = min + Math.random() * (max - min);

        if (precision > -1) {
            num = roundDecimal(num, precision);
        }

        return num;
    }

    /**
     * Utility to manage roundoff errors of floating point numbers.
     *
     * http://kb2.adobe.com/cps/139/tn_13989.html
     *
     * Examples:
     *
     *    trace(0.9 - 1); // -0.09999999999999998
     *
     *    trace(Numeric.roundDecimal(0.9 - 1, 1)); // -0.1
     *    trace(Numeric.roundDecimal(0.9 - 1, 2)); // -0.1
     *
     *    trace(Numeric.roundDecimal(0.9 - 1.123, 1)); // -0.2
     *    trace(Numeric.roundDecimal(0.9 - 1.123, 2)); // -0.22
     *    trace(Numeric.roundDecimal(0.9 - 1.123, 3)); // -0.223
     *
     *
     * @param n Float to be rounded.
     * @param precision Decimal places.
     * @return Rounded Float
     */
    public static function roundDecimal(n:Float, precision:Float):Float {
        var factor:Float = Math.pow(10, precision);
        return (Math.round(n * factor) / factor);
    }

    /**
     * Round a `Float` to the nearest (n).
     *
     * Example:
     *
     *    roundToNearest(.25, 19.95)   = 20
     *    roundToNearest(50, 1275)     = 1300
     *
     */
    public static function roundToNearest(roundTo:Float, value:Float):Float {
        return Math.round(value / roundTo) * roundTo;
    }

    /**
     * Round an integer to an even number.
     *
     * Example:
     *
     *     Numeric.roundEven(1); // 0
     *     Numeric.roundEven(2); // 2
     *     Numeric.roundEven(3); // 2
     *     Numeric.roundEven(4); // 4
     */
    public static function roundEven(n:Int):Int {
        return n & 0xfffe;
    }

}
