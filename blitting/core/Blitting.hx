/*
     |      | _)  |    |   _)
     __ \   |  |  __|  __|  |  __ \    _` |
     |   |  |  |  |    |    |  |   |  (   |
    _.__/  _| _| \__| \__| _| _|  _| \__, |
                                     |___/
    Blitting, http://blitting.com
    Copyright (c) 2014 Jason Sturges, http://jasonsturges.com
*/
package blitting.core;

import openfl.display.Shape;
import openfl.events.Event;
import openfl.Lib;

import blitting.controller.AbstractController;
import blitting.core.RenderType;
import blitting.lifecycle.IProcess;
import blitting.lifecycle.IResizable;
import blitting.lifecycle.IRenderable;
import blitting.lifecycle.IValidatable;
import blitting.model.ISingleton;


class Blitting extends AbstractController<Blitting>
implements ISingleton<Blitting>
implements IProcess {


    //------------------------------
    //  singleton instance
    //------------------------------

    public static var instance(get, null):Blitting;

    private static function get_instance():Blitting {
        if (instance == null)
            instance = new Blitting();

        return instance;
    }

    public static function getRenderer():Shape {
        return Blitting.instance.shapeRenderer;
    }


    //------------------------------
    //  model
    //------------------------------

    private var _layoutPipeline:Map<IResizable, Bool>;
    private var _renderPipeline:Map<IRenderable, RenderType>;
    private var _validationPipeline:Map<IValidatable, ValidationType>;
    private var _shapeRenderer:Shape;
    private var _frameNumber:UInt;
    private var _runtime:Int;
    private var _deltaTime:Int;


    /**
     *  Graphics renderer, used to obtain graphics context
     */
    public var shapeRenderer(get, null):Shape;

    public function get_shapeRenderer():Shape {
        _shapeRenderer.graphics.clear();
        _shapeRenderer.filters = [];

        return _shapeRenderer;
    }

    /**
     * Current (total) frame number.
     */
    public var frameNumber(get, null):UInt;

    public function get_frameNumber():UInt {
        return _frameNumber;
    }

    /**
     *  Total time elapsed of engine, in milliseconds.
     */
    public var runtime(get, null):Int;

    public function get_runtime():Int {
        return Lib.getTimer() - _runtime;
    }

    /**
     *  Time since last frame render, in milliseconds.
     */
    public var deltaTime(get, null):Int;

    public function get_deltaTime():Int {
        return Lib.getTimer() - _deltaTime;
    }


    //------------------------------
    //  lifecycle
    //------------------------------

    public function new() {
        super();

        // instantiate pipelines
        _layoutPipeline = new Map<IResizable, Bool>();
        _renderPipeline = new Map<IRenderable, RenderType>();
        _validationPipeline = new Map<IValidatable, ValidationType>();

        // instantiate renderer
        _shapeRenderer = new Shape();

        // start engine
        start();
    }

    public function start():Void {
        _runtime = _deltaTime = Lib.getTimer();
        _frameNumber = 0;

        // add frame constructed and exit frame listeners to graphics renderer
        _shapeRenderer.addEventListener(Event.FRAME_CONSTRUCTED, frameConstructedHandler);
        _shapeRenderer.addEventListener(Event.EXIT_FRAME, exitFrameHandler);
    }

    public function addInvalidation(validatable:IValidatable, ?type:ValidationType) {
        if (type == null)
            type = ValidationType.Self;

        _validationPipeline.set(validatable, type);
    }

    public function addLayout(resizable:IResizable):Void {
        _layoutPipeline.set(resizable, true);
    }

    public function addRenderer(renderer:IRenderable, ?renderType:RenderType):Void {
        if (renderType == null)
            renderType = RenderType.Continuous;

        switch (renderType) {
            case RenderType.Continuous:
                _renderPipeline.set(renderer, RenderType.Continuous);
            case RenderType.Once:
                if (_renderPipeline.exists(renderer) && _renderPipeline[renderer] == RenderType.Continuous)
                    return;
                _renderPipeline.set(renderer, RenderType.Once);
            case RenderType.OnInvalidation:
            // TODO: Evaluate whether validation should be implemented here or in renderered viewport.
        }
    }

    public function changeRenderer(renderer:IRenderable, renderType:RenderType):Void {
        _renderPipeline.set(renderer, renderType);
    }

    private function frameConstructedHandler(event:Event):Void {
        ++_frameNumber;

        // validation
        for (validatable in _validationPipeline.keys()) {
            validatable.validate();
            _validationPipeline.remove(validatable);
        }

        // layout
        for (resizable in _layoutPipeline.keys()) {
            resizable.layout();
            _layoutPipeline.remove(resizable);
        }

        // pre-render
        for (prerenderer in _renderPipeline.keys()) {
            prerenderer.prerender();
        }

        // render
        for (renderer in _renderPipeline.keys()) {
            renderer.render();
        }
    }

    private function exitFrameHandler(event:Event):Void {
        // postrender
        for (renderer in _renderPipeline.keys()) {
            renderer.postrender();

            if (_renderPipeline[renderer] == RenderType.Once)
                _renderPipeline.remove(renderer);
        }

        _deltaTime = Lib.getTimer();
    }

    public function removeRenderer(renderer:IRenderable):Void {
        _renderPipeline.remove(renderer);
    }

    public function stop():Void {
        _shapeRenderer.removeEventListener(Event.FRAME_CONSTRUCTED, frameConstructedHandler);
        _shapeRenderer.removeEventListener(Event.EXIT_FRAME, exitFrameHandler);
    }

    public function dispose():Void {
        stop();

        _layoutPipeline = null;
        _renderPipeline = null;
        _validationPipeline = null;

        _shapeRenderer = null;

        Blitting.instance = null;
    }

}
