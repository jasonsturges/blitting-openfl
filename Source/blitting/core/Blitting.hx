package blitting.core;

import flash.Lib;
import openfl.display.DisplayObject;
import openfl.display.Shape;
import openfl.events.Event;
import openfl.events.EventDispatcher;
import blitting.display.IRenderer;
import blitting.lifecycle.IProcess;
import blitting.lifecycle.IRenderable;
import blitting.lifecycle.IResizable;
import blitting.lifecycle.IValidatable;
import blitting.model.ISingleton;

class Blitting extends EventDispatcher
implements ISingleton<Blitting>
implements IProcess {

    //------------------------------
    //  singleton instance
    //------------------------------

    public static var instance:Blitting;

    public static function getInstance():Blitting {
        if (instance == null)
            instance = new Blitting();

        return Blitting.instance;
    }

    public static function getRenderer():Shape {
        return Blitting.instance.shapeRenderer;
    }


    //------------------------------
    //  model
    //------------------------------

    private var layoutPipeline:Map<IResizable, DisplayObject>;

    private var renderPipeline:Map<IRenderable, RenderType>;

    private var validationPipeline:Map<IValidatable, ValidationType>;

    private var _shapeRenderer:Shape;

    public var shapeRenderer(default, null):Shape;

    public function get_shapeRenderer():Shape {
        _shapeRenderer.graphics.clear();
        _shapeRenderer.filters = [];

        return _shapeRenderer;
    }

    /**
        Total time elapsed of viewport, in milliseconds.
    **/
    private var _runtime:Int;

    public var runtime (default, null):Int;

    public function get_runtime():Int {
        return Lib.getTimer() - _runtime;
    }

    /**
        Total time elapsed of viewport, in milliseconds.
    **/
    private var _deltaTime:Int;

    public var deltaTime (default, null):Int;

    public function get_deltaTime():Int {
        return Lib.getTimer() - _deltaTime;
    }

    /**
     * Current (total) frame number.
     */
    private var _frameNumber:UInt;

    public var frameNumber (default, null):UInt;

    public function get_frameNumber():UInt {
        return _frameNumber;
    }


    //------------------------------
    //  lifecycle
    //------------------------------

    public function new() {
        super();

        // instantiate pipelines
        layoutPipeline = new Map<IResizable, DisplayObject>();
        renderPipeline = new Map<IRenderable, RenderType>();
        validationPipeline = new Map<IValidatable, ValidationType>();

        // instantiate renderer
        _shapeRenderer = new Shape();

        // start engine
        start();
    }

    public function start():Void {
        _runtime = _deltaTime = Lib.getTimer();

        // TODO: Blocked by GitHub issue blitting-openfl#3 and blitting-openfl#4
        _shapeRenderer.addEventListener(Event.ENTER_FRAME, frameConstructedHandler);
        _shapeRenderer.addEventListener(Event.RENDER, exitFrameHandler);
    }

    public function addInvalidation(validatable:IValidatable, ?type:ValidationType) {
        if (type == null)
            type = ValidationType.Self;

        validationPipeline.set(validatable, type);
    }

    public function addRenderer(renderer:IRenderable, ?renderType:RenderType):Void {
        if (renderType == null)
            renderType = RenderType.Continuous;

        switch (renderType) {
            case RenderType.Continuous:
                renderPipeline.set(renderer, RenderType.Continuous);
            case RenderType.Once:
                if (renderPipeline.exists(renderer) && renderPipeline[renderer] == RenderType.Continuous)
                    return;
                renderPipeline.set(renderer, RenderType.Once);
            case RenderType.OnInvalidation:
                // TODO: Evaluate whether validation should be implemented here or in renderered viewport.
        }
    }

    private function frameConstructedHandler(event:Event):Void {
        trace("frame");
        trace("  " + Lambda.count(renderPipeline));
        ++_frameNumber;

        for (renderer in renderPipeline.keys()) {
            renderer.prerender();
        }

        for (renderer in renderPipeline.keys()) {
            renderer.render();
        }
    }

    private function exitFrameHandler(event:Event):Void {
        for (renderer in renderPipeline.keys()) {
            renderer.postrender();

            if (renderPipeline[renderer] == RenderType.Once)
                renderPipeline.remove(renderer);
        }
    }

    public function removeRenderer(renderer:IRenderable):Void {
        renderPipeline.remove(renderer);
    }

    public function stop():Void {
    }

    public function dispose():Void {
        stop();

        layoutPipeline = null;
        renderPipeline = null;
        validationPipeline = null;

        _shapeRenderer = null;

        Blitting.instance = null;
    }

}
