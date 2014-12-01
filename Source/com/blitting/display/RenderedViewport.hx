package com.blitting.display;

import flash.Lib;
import openfl.geom.Rectangle;
import com.blitting.lifecycle.IRenderable;

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
    public var renderType:String;

    /**
     * Total time elapsed of viewport, in milliseconds.
     */
    private var _runtime:Int;

    public var runtime (default, null):Int;

    public function get_runtime():Int {
        return Lib.getTimer() - _runtime;
    }

    /**
     * Total time elapsed of viewport, in milliseconds.
     */
    private var _deltaTime:Int;

    public var deltaTime (default, null):Int;

    public function get_deltaTime():Int {
        return Lib.getTimer() - _deltaTime;
    }


    //------------------------------
    //  lifecycle
    //------------------------------

    public function new() {
        super();
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
