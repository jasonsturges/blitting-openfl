package blitting.core;

import openfl.display.DisplayObject;
import openfl.display.Shape;
import openfl.events.Event;
import openfl.events.EventDispatcher;
import blitting.lifecycle.IValidatable;
import blitting.lifecycle.IRenderable;
import blitting.lifecycle.IResizable;
import blitting.model.ISingleton;

class Blitting extends EventDispatcher implements ISingleton<Blitting> {

    private var layoutPipeline:Map<IResizable, DisplayObject>;

    private var renderPipeline:Map<IRenderable, RenderType>;

    private var validationPipeline:Map<IValidatable, ValidationType>;

    private var _shapeRenderer:Shape;

    public function new() {
        super();

        layoutPipeline = new Map<IResizable, DisplayObject>();
        renderPipeline = new Map<IRenderable, RenderType>();
        validationPipeline = new Map<IValidatable, ValidationType>();

        _shapeRenderer = new Shape();

        start();
    }

    public function start():Void {
        _shapeRenderer.addEventListener(Event.ENTER_FRAME, frameConstructedHandler);
    }

    private function frameConstructedHandler(event:Event):Void {
        trace("enter frame");
    }


}
