/*
     |      | _)  |    |   _)
     __ \   |  |  __|  __|  |  __ \    _` |
     |   |  |  |  |    |    |  |   |  (   |
    _.__/  _| _| \__| \__| _| _|  _| \__, |
                                     |___/
    Blitting, http://blitting.com
    Copyright (c) 2014 Jason Sturges, http://jasonsturges.com

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
package blitting.model;

import blitting.math.Numeric;
import blitting.constant.ColorPalette;


class Color {

    /**
     *  Darken a color by an amount between 0 and 1, where
     *  lower values are darker.
     *  @param color  Color to be darkened
     *  @param value  Amount between 0 and 1, where lower is darker
     *  @return UInt  Darkened color
     */
    public static function darken(color:UInt, value:Float):UInt {
        value = Numeric.clamp(value, 0, 1);

        return fromARGB(getAlpha(color),
                        Math.floor(getRed(color) * value),
                        Math.floor(getGreen(color) * value),
                        Math.floor(getBlue(color) * value)
                        );
    }

    /**
     *  Lighten a color by an amount between 0 and 1, where
     *  higher values are lighter.
     *  @param color  Color to be darkened
     *  @param value  Amount between 0 and 1, where higher is lighter
     *  @return UInt  Lightened color
     */
    public static function lighten(color:UInt, value:Float):UInt {
        value = Numeric.clamp(value, 0, 1);

        return fromARGB(getAlpha(color),
                        Math.ceil((getRed(color) + 0xff) * value),
                        Math.ceil((getGreen(color) + 0xff) * value),
                        Math.ceil((getBlue(color) + 0xff) * value)
                        );
    }

    /**
     * Get named color from color palette.
     *
     * @param name Name of color from color palette class.
     * @return 24-bit RGB unsigned integer of color.
     * @see ColorPalette
     *
     */
    public static function fromName(name:String):UInt {
        return ColorPalette.fromName(name);
    }

    /**
     * Get 32-bit ARGB color as integer.
     *
     * @param alpha  8-bit Alpha.
     * @param red    8-bit Red.
     * @param green  8-bit Green.
     * @param blue   8-bit Blue.
     * @return       32-bit ARGB unsigned integer.
     */
    public static function fromARGB(alpha:UInt, red:UInt, green:UInt, blue:UInt):UInt {
        return alpha << 24 | red << 16 | green << 8 | blue;
    }

    /**
     * Get 32-bit ARGB by combining 8-bit Alpha with 24-bit RGB.
     *
     * @param alpha  8-bit Alpha.
     * @param rgb    24-bit RGB.
     * @return       32-bit ARGB unsigned integer.
     */
    public static function fromRGBWithAlpha(rgb:UInt, alpha:UInt = 0xff):UInt {
        return (alpha << 24) + rgb;
    }

    /**
     * Get 32-bit RGBA color as integer.
     *
     * In ActionScript, ARGB is typically used.
     * Use getColor32 for ARGB value.
     *
     * This function is provided for compatibility
     *
     * @param red    8-bit Red.
     * @param green  8-bit Green.
     * @param blue   8-bit Blue.
     * @param alpha  8-bit Alpha.
     * @return       32-bit RGBA unsigned integer.
     */
    public static function fromRGBA(red:UInt, green:UInt, blue:UInt, alpha:UInt):UInt {
        return red << 24 | green << 16 | blue << 8 | alpha;
    }

    /**
     * Get 32-bit RGBA from ARGB unsigned int.
     *
     * @param color 32-bit ARGB unsigned int.
     * @return 32-bit RGBA unsigned int.
     */
    public static function getRGBAFromARGB(color:UInt):UInt {
        return color << 8 | color >>> 24;
    }

    /**
     * Get 24-bit RGB color as integer.
     *
     * @param red    8-bit Red.
     * @param green  8-bit Green.
     * @param blue   8-bit Blue.
     * @return       32-bit RGB unsigned integer.
     */
    public static function fromRGB(red:UInt, green:UInt, blue:UInt):UInt {
        return red << 16 | green << 8 | blue;
    }

    /**
     * Get 32-bit ARGB from RGBA unsigned int.
     *
     * @param color 32-bit RGBA unsigned int.
     * @return 32-bit ARGB unsigned int.
     */
    public static function getARGBFromRGBA(color:UInt):UInt {
        return color >>> 8 | color << 24;
    }

    /**
     * Get alpha from a 32-bit ARGB unsigned integer.
     *
     * @param color  32-bit ARGB color as unsigned integer.
     * @return       8-bit alpha.
     */
    public static function getAlpha(color:UInt):UInt {
        return color >>> 24;
    }

    /**
     *  Get alpha floating point value from a 32-bit ARGB unsigned integer.
     *  @param color    32-bit ARGB unsigned integer
     *  @return Float   Alpha value between 0 and 1.
     */
    public static function getAlphaFloat(color:UInt):Float {
        return (color >>> 24) / 0xff;
    }

    /**
     * Get red from an unsigned integer.
     *
     * @param color  24-bit RGB color as unsigned integer.
     * @return       8-bit red.
     */
    public static function getRed(color:UInt):UInt {
        return color >>> 16 & 0xFF;
    }

    /**
     *  Get red floating point value from a 32-bit ARGB unsigned integer.
     *  @param color    32-bit ARGB unsigned integer
     *  @return Float   Red value between 0 and 1.
     */
    public static function getRedFloat(color:UInt):Float {
        return (color >>> 16 & 0xFF) / 0xff;
    }

    /**
     * Get green from an unsigned integer.
     *
     * @param color  24-bit RGB color as unsigned integer.
     * @return       8-bit green.
     */
    public static function getGreen(color:UInt):UInt {
        return color >>> 8 & 0xFF;
    }

    /**
     *  Get green floating point value from a 32-bit ARGB unsigned integer.
     *  @param color    32-bit ARGB unsigned integer
     *  @return Float   Green value between 0 and 1.
     */
    public static function getGreenFloat(color:UInt):Float {
        return (color >>> 8 & 0xFF) / 0xff;
    }

    /**
     * Get Blue from an unsigned integer.
     *
     * @param color  24-bit RGB color as unsigned integer.
     * @return       8-bit blue.
     */
    public static function getBlue(color:UInt):UInt {
        return color & 0xFF;
    }

    /**
     *  Get blue floating point value from a 32-bit ARGB unsigned integer.
     *  @param color    32-bit ARGB unsigned integer
     *  @return Float   Blue value between 0 and 1.
     */
    public static function getBlueFloat(color:UInt):Float {
        return (color & 0xFF) / 0xff;
    }

}

