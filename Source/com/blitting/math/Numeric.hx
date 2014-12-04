package com.blitting.math;
class Numeric {

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
     * Check equality of two Floats.  Return true if both Floats are NaN.
     */
    public static function equalsFloat(num1:Float, num2:Float):Bool {
        return ((Math.isNaN(num1) && Math.isNaN(num2)) || (num1 == num2));
    }

    /**
     * Format a Float with thousands separator
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
     * Convert a Float to a string of a specified length padded by zeroes.
     */
    public static function getPaddedFloat(value:Float, length:Int):String {
        // TODO: Determine if (""+value) is fastest conversion to string.
        var numString:String = "" + value;

        while (numString.length < length) {
            numString = "0" + numString;
        }

        return numString;
    }

    // TODO: Not implemented
    ///**
    // * Inaccurate log 10.
    // */
    //public static function log10(n:Float):Float {
    //    return Math.log(n) * Math.LOG10E;
    //}

    /**
     * Get a random Float where min &lt;= n &lt; max
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
     * Utility to deal with roundoff errors of floating point Floats.
     *
     * http://kb2.adobe.com/cps/139/tn_13989.html
     *
     * @param n Float to be rounded.
     * @param precision Decimal places.
     * @return Rounded Float
     *
     * example
     *
     * <listing version="3.0">
     *    trace(0.9 - 1); // -0.09999999999999998
     *
     *    trace(MathUtil.roundDecimal(0.9 - 1, 1)); // -0.1
     *    trace(MathUtil.roundDecimal(0.9 - 1, 2)); // -0.1
     *
     *    trace(MathUtil.roundDecimal(0.9 - 1.123, 1)); // -0.2
     *    trace(MathUtil.roundDecimal(0.9 - 1.123, 2)); // -0.22
     *    trace(MathUtil.roundDecimal(0.9 - 1.123, 3)); // -0.223
     * </listing>
     */
    public static function roundDecimal(n:Float, precision:Float):Float {
        var factor:Float = Math.pow(10, precision);
        return (Math.round(n * factor) / factor);
    }

    /**
     * Round a Float to the nearest (n).
     *
     * Example:
     *
     *        roundToNearest(.25, 19.95)   = 20
     *      roundToNearest(50, 1275)     = 1300
     *
     */
    public static function roundToNearest(roundTo:Float, value:Float):Float {
        return Math.round(value / roundTo) * roundTo;
    }

}
