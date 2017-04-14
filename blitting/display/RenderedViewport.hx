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
 * Extends Viewport to include Blitting core rendering engine
 * and IRenderable lifecycle:
 *   - pre-render
 *   - render
 *   - post-render
 */
class RenderedViewport extends Viewport
implements IRenderable {

    //------------------------------
    //  model
    //------------------------------

    private var _deltaTime:Int;
    private var _frameNumber:UInt;
    private var _frameRate:Float;
    private var _runtime:Int;


    /**
     * Rendering engine.
     */
    private var blitting(default, never):Blitting = Blitting.instance;

    /**
     * Current (total) frame number.
     */
    public var frameNumber (get, null):UInt;

    public function get_frameNumber():UInt {
        return _frameNumber;
    }

    /**
     * Frame rate of rendering.
     */
    public var frameRate(get, set):Float;

    public function get_frameRate():Float {
        return _frameRate;
    }

    public function set_frameRate(value:Float):Float {
        if (_frameRate = !value)
            invalidate();

        return _frameRate = value;
    }

    /**
     * Render type / mode of rending.
     */
    public var renderType:RenderType;

    /**
     *  Total time elapsed of viewport, in milliseconds.
     */
    public var runtime (get, null):Int;

    public function get_runtime():Int {
        return Lib.getTimer() - _runtime;
    }

    /**
     *  Time since last frame render, in milliseconds.
     */
    public var deltaTime (get, null):Int;

    public function get_deltaTime():Int {
        return Lib.getTimer() - _deltaTime;
    }


    //------------------------------
    //  lifecycle
    //------------------------------

    /**
     *  Constructor
     *  @param frameRate - 
     */
    public function new(frameRate:Float = 60) {
        super();

        this.frameRate = frameRate;
    }

    /**
     * initialize (IInitializable)
     */
    override public function initialize():Void {
        super.initialize();

        renderType = RenderType.OnInvalidation;
        _frameNumber = 0;
        _runtime = _deltaTime = Lib.getTimer();
    }

    /**
     *  Added to stage handler
     *  @param event - 
     */
    override private function addedToStageHandler(event:Event):Void {
        super.addedToStageHandler(event);

        if (renderType == RenderType.Continuous)
            blitting.addRenderer(this, renderType);

        invalidate();
    }

    /**
     *  Change render type
     *  @param renderType - 
     */
    public function changeRenderType(renderType:RenderType):Void {
        blitting.changeRenderer(this, renderType);
    }

    /**
     *  Invalidate (IValidatable)
     */
    override public function invalidate():Void {
        super.invalidate();

        blitting.addInvalidation(this, ValidationType.Self);

        if (renderType == RenderType.OnInvalidation)
            blitting.addRenderer(this, RenderType.Once);
    }

    /**
     *  Validate (IValidatable)
     */
    override public function validate():Void {
        super.validate();

        if (stage != null)
            stage.frameRate = frameRate;
    }

    /**
     * Pre-render (IRenderable)
     */
    public function prerender():Void {
        ++_frameNumber;
    }

    /**
     * Render (IRenderable)
     */
    public function render():Void {
    }

    /**
     * Post-render (IRenderable)
     */
    public function postrender(changeRect:Rectangle = null):Void {
        // Update time elapsed since last frame render
        _deltaTime = Lib.getTimer();
    }

    /**
     *  Removed from stage handler
     *  @param event - 
     */
    override private function removedFromStageHandler(event:Event):Void {
        super.removedFromStageHandler(event);

        blitting.removeRenderer(this);
    }

    /**
     *  Dispose (IDisposable)
     */
    override public function dispose():Void {
        super.dispose();

        blitting.removeRenderer(this);
    }

}
