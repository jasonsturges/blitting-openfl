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

import openfl.display.DisplayObject;
import openfl.display.StageAlign;
import openfl.display.StageScaleMode;
import openfl.events.Event;
import blitting.lifecycle.IDisposable;
import blitting.lifecycle.IValidatable;

class Viewport extends AbstractViewport
    implements IValidatable {

    //------------------------------
    //  model
    //------------------------------

    /**
     * Whether properties have been invalidated,
     * requiring validation.
     */
    private var invalidated:Bool;


    //------------------------------
    //  lifecycle
    //------------------------------

    /**
     * constructor
     */
    public function new() {
        super();
    }

    /**
     * initialize (IInitializable)
     */
    override public function initialize():Void {
        super.initialize();

        invalidated = false;
        mouseEnabled = mouseChildren = tabChildren = false;
        //focusRect = tabEnabled  = false;

        addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
    }

    /**
     * autoOrientation
     */
    public function autoOrientation():Void {
        if (stage == null)
            throw "autoOrientation may only be called on a root viewport with access to the stage.";

        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;
    }

    /**
     * addedToStageHandler
     */
    private function addedToStageHandler(event:Event):Void {
        removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
        addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
    }

    /**
     * Indicate component has been invalidated. (IValidatable).
     *
     * Viewport abstract base class does not manage invalidation through
     * the BlittingEngine; therefore, validation commit stage must be
     * implemented via inheritance.
     */
    public function invalidate():Void {
        if (invalidated)
            return;

        invalidated = true;
    }

    /**
     * Indicate component has been validated. (IValidatable).
     *
     * Viewport abstract base class does not manage invalidation through
     * the BlittingEngine; therefore, validation commit stage must be
     * implemented via inheritance.
     */
    public function validate():Void {
        invalidated = false;
    }

    /**
     * removedFromStageHandler
     */
    private function removedFromStageHandler(event:Event):Void {
        removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
        addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
    }

    /**
     * dispose (IDisposable)
     */
    override public function dispose():Void {
        super.dispose();

        // remove children
        while (numChildren > 0) {
            var displayObject:DisplayObject = removeChildAt(0);

            if (Std.is(displayObject, IDisposable))
                cast(displayObject, IDisposable).dispose();
        }

        removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
        removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
    }

}
