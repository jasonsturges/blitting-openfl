/*
     |      | _)  |    |   _)
     __ \   |  |  __|  __|  |  __ \    _` |
     |   |  |  |  |    |    |  |   |  (   |
    _.__/  _| _| \__| \__| _| _|  _| \__, |
                                     |___/
    Blitting, http://blitting.com
    Copyright (c) 2014 Jason Sturges, http://jasonsturges.com
*/
package blitting.display;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.PixelSnapping;
import openfl.events.Event;
import openfl.geom.Matrix;
import openfl.geom.Rectangle;
import blitting.display.ResizableViewport;

class BufferedViewport extends ResizableViewport {

    //------------------------------
    //  model
    //------------------------------

    private var bitmap:Bitmap;
    private var bitmapData:BitmapData;
    private var fillColor:UInt;
    private var pixelSnapping:PixelSnapping;
    private var scaleOnResize:Bool;
    private var smoothing:Bool;
    private var transparent:Bool;


    //------------------------------
    //  lifecycle
    //------------------------------

    public function new(transparent:Bool = true,
                        fillColor:UInt = 0xff00ff,
                        smoothing:Bool = true) {
        super();

        bitmap = new Bitmap();

        this.transparent = transparent;
        this.fillColor = fillColor;
        this.smoothing = smoothing;
    }

    override public function initialize():Void {
        super.initialize();

        fillColor = 0xff00ff;
        pixelSnapping = PixelSnapping.AUTO;
    }

    override private function addedToStageHandler(event:Event):Void {
        super.addedToStageHandler(event);

        addChild(bitmap);
    }

    override public function validate():Void {
        super.validate();

        bitmap.pixelSnapping = pixelSnapping;
        bitmap.smoothing = smoothing;
    }

    override public function resize(width:Float, height:Float):Void {
        super.resize(Math.ceil(width), Math.ceil(height));
    }

    override public function layout():Void {
        super.layout();

        // if same size, do not resize bitmap
        if ((bitmapData != null) &&
            (bitmapData.rect.width == bounds.width) &&
            (bitmapData.rect.height == bounds.height))
            return;

        // if invalid size, return
        if (bounds.width < 1 || bounds.height < 1)
            return;

        // cached bitmap data
        var cachedBitmapData:BitmapData = bitmapData;

        bitmapData = null;
        bitmap.bitmapData = null;

        // instantiate at new bounds
        bitmapData = new BitmapData(Math.ceil(bounds.width), Math.ceil(bounds.height), transparent, fillColor);
        bitmap.bitmapData = bitmapData;
        bitmap.pixelSnapping = pixelSnapping;
        bitmap.smoothing = smoothing;

        if(cachedBitmapData == null)
            return;

        if (scaleOnResize) {
            var matrix:Matrix = new Matrix();
            matrix.scale(bounds.width / cachedBitmapData.width, bounds.height / cachedBitmapData.height);
            bitmapData.draw(cachedBitmapData, matrix);
        }

        cachedBitmapData.dispose();
        cachedBitmapData = null;
    }

    public function clear():Void {
        bitmapData.fillRect(bitmapData.rect, fillColor);
    }

    override public function prerender():Void {
        super.prerender();

        if (bitmapData == null)
            return;

        bitmapData.lock();
    }

    override public function render():Void {
        super.render();
    }

    override public function postrender(changeRect:Rectangle = null):Void {
        super.postrender(changeRect);

        if (bitmapData == null)
            return;

        bitmapData.unlock(changeRect);
    }

    override public function dispose():Void {
        super.dispose();

        bitmap = null;

        if (bitmapData != null) {
            bitmapData.dispose();
            bitmapData = null;
        }
    }

}
