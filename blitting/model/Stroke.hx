/*
     |      | _)  |    |   _)
     __ \   |  |  __|  __|  |  __ \    _` |
     |   |  |  |  |    |    |  |   |  (   |
    _.__/  _| _| \__| \__| _| _|  _| \__, |
                                     |___/
    Blitting, http://blitting.com
    Copyright (c) 2017 Jason Sturges, http://jasonsturges.com

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

import blitting.math.Geometry;
import openfl.display.CapsStyle;
import openfl.display.GradientType;
import openfl.display.Graphics;
import openfl.display.InterpolationMethod;
import openfl.display.JointStyle;
import openfl.display.LineScaleMode;
import openfl.display.SpreadMethod;
import openfl.geom.Matrix;


class Stroke {

    public static function clear(graphics:Graphics):Void {
        graphics.lineStyle(null);
    }

    public static function linearGradient(graphics:Graphics,
                                          width:Float,
                                          height:Float,
                                          weight:Float,
                                          color:Array<UInt>,
                                          alpha:Array<Float>,
                                          ratio:Array<Int>,
                                          rotation:Float = 0.0,
                                          ?spreadMethod:SpreadMethod,
                                          ?interpolationMethod:InterpolationMethod,
                                          ?focalPointRatio:Float):Void {
        var matrix:Matrix = new Matrix();
        matrix.createGradientBox(width, height, Geometry.deg2rad(90));

        graphics.lineStyle(weight, 0x0, 1, true, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.MITER);
        graphics.lineGradientStyle(GradientType.LINEAR, color, alpha, ratio, matrix, SpreadMethod.PAD, InterpolationMethod.LINEAR_RGB);
    }

}
