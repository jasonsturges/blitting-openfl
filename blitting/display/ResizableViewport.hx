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

import openfl.display.StageDisplayState;
import openfl.events.Event;
import blitting.display.RenderedViewport;
import blitting.lifecycle.IResizable;

class ResizableViewport extends RenderedViewport
implements IResizable {

    //------------------------------
    //  model
    //------------------------------

    /**
     * Bind to full stage bounds.
     */
    public var fullStage:Bool;


    //------------------------------
    //  lifecycle
    //------------------------------

    /**
     *  Constructor
     */
    public function new() {
        super();
    }

    /**
     *  Initialize (IInitializable)
     */
    override public function initialize():Void {
        super.initialize();

        fullStage = false;
    }

    /**
     *  Added to stage handler
     */
    override private function addedToStageHandler(event:Event):Void {
        super.addedToStageHandler(event);

        // add event listeners.
        addEventListener(Event.RESIZE, resizeHandler);

        // bind to full stage
        if (fullStage) {
            stage.addEventListener(Event.RESIZE, resizeHandler);
            resize(stage.stageWidth, stage.stageHeight);
        }
    }

    /**
     *  Enter full screen mode specifying whether display
     *  remains interactive to keyboard events.
     */
    private function fullScreen(interactive:Bool = true):Void {
        #if flash
        if (interactive && stage.allowsFullScreenInteractive) {
            stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
        } else
            #end
        if (stage.allowsFullScreen) {
            stage.displayState = StageDisplayState.FULL_SCREEN;
        }
    }

    /**
     *  Resize handler
     */
    private function resizeHandler(event:Event):Void {
        if (fullStage)
            resize(stage.stageWidth, stage.stageHeight);
    }

    /**
     *  Resize (IResizable) -command to invalidate size of viewport
     *  and automatically enqueue rendering.
     */
    public function resize(width:Float, height:Float):Void {
        bounds.width = width;
        bounds.height = height;

        blitting.addLayout(this);

        invalidate();
    }

    /**
     *  Layout (IResizable)
     */
    public function layout():Void {
    }

    /**
     *  Dispose (IDisposable)
     */
    override public function dispose():Void {
        super.dispose();

        // remove resize event listener
        removeEventListener(Event.RESIZE, resizeHandler);

        if (fullStage)
            stage.removeEventListener(Event.RESIZE, resizeHandler);
    }
}
