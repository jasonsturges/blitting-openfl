/*
     |      | _)  |    |   _)
     __ \   |  |  __|  __|  |  __ \    _` |
     |   |  |  |  |    |    |  |   |  (   |
    _.__/  _| _| \__| \__| _| _|  _| \__, |
                                     |___/
    Blitting, http://blitting.com
    Copyright (c) 2014 Jason Sturges, http://jasonsturges.com
*/
package blitting.model;

import blitting.constant.ColorPalette;
import blitting.lifecycle.IInitializable;

/**
 * Color structure.
 */
class Color implements IInitializable {
    public var rgb(get, never):Int;
    public var argb(get, never):Int;
    public var rgba(get, never):Int;
    public var red(get, never):Int;
    public var green(get, never):Int;
    public var blue(get, never):Int;
    public var alpha(get, never):Int;


    //------------------------------
    //  model
    //------------------------------

    /**
     * 32-bit ARGB color
     *
     * 8-bit alpha  (0x0 - 0xff)
     * 8-bit red    (0x0 - 0xff)
     * 8-bit green  (0x0 - 0xff)
     * 8-bit blue   (0x0 - 0xff)
     */
    private var color:Int;

    /**
     * Get 24-bit unsigned int of 8-bit red, green, and blue
     *
     * @return 24-bit unsigned int of 8-bit red, green, and blue.
     */
    private function get_rgb():Int {
        return 0xffffff & color;
    }

    /**
     * Get 32-bit unsigned int of 8-bit alpha, red, green, blue.
     *
     * @return 32-bit unsigned int of 8-bit alpha, red, green, blue.
     */
    private function get_argb():Int {
        return color;
    }

    /**
     * Get 32-bit unsigned int of 8-bit red, green, blue, alpha.
     *
     * @return 32-bit unsigned int of 8-bit red, green, blue, alpha.
     */
    private function get_rgba():Int {
        return color << 8 | color >>> 24;
    }

    /**
     * Get unsigned int of 8-bit red.
     *
     * @return Unsigned int of 8-bit red.
     */
    private function get_red():Int {
        return color >>> 16 & 0xff;
    }

    /**
     * Get unsigned int of 8-bit green.
     * @return Unsigned int of 8-bit green.
     */
    private function get_green():Int {
        return color >>> 8 & 0xff;
    }

    /**
     * Get unsigned int of 8-bit blue.
     *
     * @return Unsigned int of 8-bit blue.
     */
    private function get_blue():Int {
        return color & 0xff;
    }

    /**
     * Get unsigned int of 8-bit alpha.
     *
     * @return Unsigned int of 8-bit alpha.
     */
    private function get_alpha():Int {
        return color >>> 24 & 0xff;
    }


    //------------------------------
    //  lifecycle
    //------------------------------

    /**
     * Constructor, initializing color to black with full alpha.
     *
     * @param red    8-bit red.
     * @param green  8-bit green.
     * @param blue   8-bit blue.
     * @param alpha  8-bit alpha.
     *
     */
    public function new(red:Int = 0x0, green:Int = 0x0, blue:Int = 0x0, alpha:Int = 0xff) {
        color = alpha << 24 | red << 16 | green << 8 | blue;
    }

    /**
     * IInitialize initialization.
     *
     */
    public function initialize():Void {
        color = 0x0;
    }

    /**
     * Get ARGB values from 32-bit integer.
     *
     * @param color  32-bit ARGB color as unsigned integer.
     * @return       Color instance of 8-bit alpha, red, green, blue.
     */
    public static function fromARGB(color:Int):Color {
        return new Color(color >>> 16 & 0xff, // red
        color >>> 8 & 0xff, // green
        color & 0xff, // blue
        color >>> 24 // alpha
        );
    }

    /**
     * Get RGBA values from 32-bit integer.
     *
     * In ActionScript, ARGB is typically used.
     * Use getARGB for ARGB value.
     *
     * This function is provided for compatibility.
     *
     * @param color  32-bit ARGB color as unsigned integer.
     * @return       Color instance of 8-bit red, green, blue, alpha.
     */
    public static function fromRGBA(color:Int):Color {
        return new Color(color >>> 24, // red
        color >>> 16 & 0xff, // green
        color >>> 8 & 0xf, // blue
        color & 0xff // alpha
        );
    }

    /**
     * Get RGB values from 24-bit integer.
     *
     * @param color  24-bit RGB color as unsigned integer.
     * @return       Color instance of 8-bit red, green, blue.
     */
    public static function fromRGB(color:Int):Color {
        return new Color(color >> 16 & 0xff, // red
        color >> 8 & 0xff, // green
        color & 0xff // blue
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
    public static function fromName(name:String):Color {
        return Color.fromRGB(ColorPalette.fromName(name));
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
    public static function getARGB(alpha:Int, red:Int, green:Int, blue:Int):Int {
        return alpha << 24 | red << 16 | green << 8 | blue;
    }

    /**
     * Get 32-bit ARGB by combining 8-bit Alpha with 24-bit RGB.
     *
     * @param alpha  8-bit Alpha.
     * @param rgb    24-bit RGB.
     * @return       32-bit ARGB unsigned integer.
     */
    public static function getARGBFromAlphaAndRGB(rgb:Int, alpha:Int = 0xff):Int {
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
    public static function getRGBA(red:Int, green:Int, blue:Int, alpha:Int):Int {
        return red << 24 | green << 16 | blue << 8 | alpha;
    }

    /**
     * Get 32-bit RGBA from ARGB unsigned int.
     *
     * @param color 32-bit ARGB unsigned int.
     * @return 32-bit RGBA unsigned int.
     */
    public static function getRGBAFromARGB(color:Int):Int {
        return color << 8 | color >>> 24;
    }

    /**
     * Get 32-bit ARGB from RGBA unsigned int.
     *
     * @param color 32-bit RGBA unsigned int.
     * @return 32-bit ARGB unsigned int.
     */
    public static function getARGBFromRGBA(color:Int):Int {
        return color >>> 8 | color << 24;
    }

    /**
     * Get 24-bit RGB color as integer.
     *
     * @param red    8-bit Red.
     * @param green  8-bit Green.
     * @param blue   8-bit Blue.
     * @return       32-bit RGB unsigned integer.
     */
    public static function getRGB(red:Int, green:Int, blue:Int):Int {
        return red << 16 | green << 8 | blue;
    }

    /**
     * Get Alpha from a 32-bit ARGB unsigned integer.
     *
     * @param color  32-bit ARGB color as unsigned integer.
     * @return       8-bit alpha.
     */
    public static function getAlpha(color:Int):Int {
        return color >>> 24;
    }

    /**
     * Get Red from an unsigned integer.
     *
     * @param color  24-bit RGB color as unsigned integer.
     * @return       8-bit red.
     */
    public static function getRed(color:Int):Int {
        return color >>> 16 & 0xFF;
    }

    /**
     * Get Green from an unsigned integer.
     *
     * @param color  24-bit RGB color as unsigned integer.
     * @return       8-bit green.
     */
    public static function getGreen(color:Int):Int {
        return color >>> 8 & 0xFF;
    }

    /**
     * Get Blue from an unsigned integer.
     *
     * @param color  24-bit RGB color as unsigned integer.
     * @return       8-bit blue.
     */
    public static function getBlue(color:Int):Int {
        return color & 0xFF;
    }

}

