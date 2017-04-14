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

    private var _bitmap:Bitmap;
    private var _bitmapData:BitmapData;
    private var _fillColor:UInt;
    private var _pixelSnapping:PixelSnapping;
    private var _scaleOnResize:Bool;
    private var _smoothing:Bool;
    private var _transparent:Bool;


    /**
     *  Fill color
     */
    public var fillColor(get, set):UInt;

    public function get_fillColor():UInt {
        return _fillColor;
    }

    public function set_fillColor(value:UInt):UInt {
        return _fillColor = value;
    }

    /**
     *  Pixel snapping
     */
    public var pixelSnapping(get, set):PixelSnapping;

    public function get_pixelSnapping():PixelSnapping {
        return _pixelSnapping;
    }

    public function set_pixelSnapping(value:PixelSnapping):PixelSnapping {
        if (_pixelSnapping != value)
            invalidate();

        return _pixelSnapping = value;
    }

    /**
     *  Scale on resize
     */
    public var scaleOnResize(get, set):Bool;

    public function get_scaleOnResize():Bool {
        return _scaleOnResize;
    }

    public function set_scaleOnResize(value:Bool):Bool {
        return _scaleOnResize = value;
    }

    /**
     *  Smoothing
     */
    public var smoothing(get, set):Bool;

    public function get_smoothing():Bool {
        return _smoothing;
    }

    public function set_smoothing(value:Bool):Bool {
        if (_smoothing != value)
            invalidate();

        return _smoothing = value;
    }

    /**
     *  Transparent
     */
    public var transparent(get, set):Bool;

    public function get_transparent():Bool {
        return _transparent;
    }

    public function set_transparent(value:Bool):Bool {
        return _transparent = value;
    }


    //------------------------------
    //  lifecycle
    //------------------------------

    /**
     *  Constructor
     *  @param transparent - 
     *  @param fillColor - 
     *  @param smoothing - 
     */
    public function new(transparent:Bool = true,
                        fillColor:UInt = 0xff00ff,
                        smoothing:Bool = true) {
        super();

        bitmap = new Bitmap();

        this.transparent = transparent;
        this.fillColor = fillColor;
        this.smoothing = smoothing;
    }

    /**
     *  Initialize (IInitializable)
     */
    override public function initialize():Void {
        super.initialize();

        fillColor = 0xff00ff;
        pixelSnapping = PixelSnapping.AUTO;
    }

    /**
     *  Added to stage handler
     *  @param event - 
     */
    override private function addedToStageHandler(event:Event):Void {
        super.addedToStageHandler(event);

        addChild(bitmap);
    }

    /**
     *  Validate (IValidatable)
     */
    override public function validate():Void {
        super.validate();

        bitmap.pixelSnapping = pixelSnapping;
        bitmap.smoothing = smoothing;
    }

    /**
     *  Resize (IResizable)
     *  @param width - 
     *  @param height - 
     */
    override public function resize(width:Float, height:Float):Void {
        super.resize(Math.ceil(width), Math.ceil(height));
    }

    /**
     *  Layout (IResizable)
     */
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

        if (cachedBitmapData == null)
            return;

        if (scaleOnResize) {
            var matrix:Matrix = new Matrix();
            matrix.scale(bounds.width / cachedBitmapData.width, bounds.height / cachedBitmapData.height);
            bitmapData.draw(cachedBitmapData, matrix);
        }

        cachedBitmapData.dispose();
        cachedBitmapData = null;
    }

    /**
     *  Clear
     */
    public function clear():Void {
        bitmapData.fillRect(bitmapData.rect, fillColor);
    }

    /**
     *  Pre-render (IRenderable)
     */
    override public function prerender():Void {
        super.prerender();

        if (bitmapData == null)
            return;

        bitmapData.lock();
    }

    /**
     *  Render (IRenderable)
     */
    override public function render():Void {
        super.render();
    }

    /**
     *  Post-render (IRenderable)
     *  @param changeRect - 
     */
    override public function postrender(changeRect:Rectangle = null):Void {
        super.postrender(changeRect);

        if (bitmapData == null)
            return;

        bitmapData.unlock(changeRect);
    }

    /**
     *  Removed from stage handler
     *  @param event - 
     */
    override private function removedFromStageHandler(event:Event):Void {
        super.removedFromStageHandler(event);

        removeChild(bitmap);
    }

    /**
     *  Dispose (IDisposable)
     */
    override public function dispose():Void {
        super.dispose();

        bitmap = null;

        if (bitmapData != null) {
            bitmapData.dispose();
            bitmapData = null;
        }
    }

}
