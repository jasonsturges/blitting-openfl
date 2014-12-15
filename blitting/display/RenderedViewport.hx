package

import flash.Lib;
import openfl.events.Event;
import openfl.geom.Rectangle;
import blitting.core.Blitting;
import blitting.core.RenderType;
import blitting.lifecycle.IRenderable;

/**
 * Extends Viewport to include BlittingEngine
 * and IRenderable lifecycle.
 *
 * <ul>
 *    <li>pre-render</li>
 *    <li>render</li>
 *    <li>post-render</li>
 * </ul>
 */
class RenderedViewport extends Viewport implements IRenderable {

    //------------------------------
    //  model
    //------------------------------

    /**
     * Current (total) frame number.
     */
    private var _frameNumber:UInt;

    public var frameNumber (default, null):UInt;

    public function get_frameNumber():UInt {
        return _frameNumber;
    }

    /**
     * Frame rate of rendering.
     */
    private var _frameRate:Float;

    public var frameRate(get, set):Float;

    public function get_frameRate():Float {
        return _frameRate;
    }

    public function set_frameRate(value:Float):Float {
        if (_frameRate == value)
            return _frameRate;

        invalidate();
        return _frameRate = value;
    }

    /**
     * Render type / mode of rending.
     */
    public var renderType:RenderType;

    /**
        Total time elapsed of viewport, in milliseconds.
    **/
    private var _runtime:Int;

    public var runtime (default, null):Int;

    public function get_runtime():Int {
        return Lib.getTimer() - _runtime;
    }

    /**
        Time since last frame render
    **/
    private var _deltaTime:Int;

    public var deltaTime (default, null):Int;

    public function get_deltaTime():Int {
        return Lib.getTimer() - _deltaTime;
    }


    //------------------------------
    //  lifecycle
    //------------------------------

    public function new(frameRate:Float = 60) {
        super();

        this.frameRate = frameRate;
    }

    override public function initialize():Void {
        super.initialize();

        renderType = RenderType.OnInvalidation;
        _frameNumber = 0;
        _frameRate = 60;
        _runtime = _deltaTime = Lib.getTimer();
    }

    override private function addedToStageHandler(event:Event):Void {
        super.addedToStageHandler(event);

        if (renderType == RenderType.Continuous)
            Blitting.getInstance().addRenderer(this, RenderType.Continuous);

        invalidate();
    }

    /**
     * pre-render
     */
    public function prerender():Void {
        ++_frameNumber;

        // Update time elapsed since last frame render.
        _deltaTime = Lib.getTimer();
    }

    /**
     * render
     */
    public function render():Void {
    }

    /**
     * post-render
     */
    public function postrender(changeRect:Rectangle = null):Void {
    }

}
