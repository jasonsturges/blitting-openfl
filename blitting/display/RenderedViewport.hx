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

import openfl.events.Event;
import openfl.geom.Rectangle;
import openfl.Lib;

import blitting.core.Blitting;
import blitting.core.RenderType;
import blitting.core.ValidationType;
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
class RenderedViewport extends Viewport
    implements IRenderable {

    //------------------------------
    //  model
    //------------------------------

    /**
     * Rendering engine.
     */
    public static var blitting(get, null):Blitting;

    private static function get_blitting():Blitting {
        return Blitting.instance;
    }

    /**
     * Current (total) frame number.
     */
    private var _frameNumber:UInt;

    public var frameNumber (get, null):UInt;

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

    public var runtime (get, null):Int;

    public function get_runtime():Int {
        return Lib.getTimer() - _runtime;
    }

    /**
        Time since last frame render
    **/
    private var _deltaTime:Int;

    public var deltaTime (get, null):Int;

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
        _runtime = _deltaTime = Lib.getTimer();
    }

    override private function addedToStageHandler(event:Event):Void {
        super.addedToStageHandler(event);

        if (renderType == RenderType.Continuous)
            blitting.addRenderer(this, renderType);

        invalidate();
    }

    public function changeRenderType(renderType:RenderType):Void {
        blitting.changeRenderer(this, renderType);
    }

    override public function invalidate():Void {
        super.invalidate();

        blitting.addInvalidation(this, ValidationType.Self);

        if (renderType == RenderType.OnInvalidation)
            blitting.addRenderer(this, RenderType.Once);
    }

    override public function validate():Void {
        super.validate();

        if (stage != null)
            stage.frameRate = frameRate;
    }

    /**
     * pre-render
     */
    public function prerender():Void {
        ++_frameNumber;
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
        // Update time elapsed since last frame render
        _deltaTime = Lib.getTimer();
    }

    override private function removedFromStageHandler(event:Event):Void {
        super.removedFromStageHandler(event);

        blitting.removeRenderer(this);
    }

    override public function dispose():Void {
        super.dispose();

        blitting.removeRenderer(this);
    }

}
