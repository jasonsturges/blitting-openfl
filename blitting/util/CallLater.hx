/*
     |      | _)  |    |   _)
     __ \   |  |  __|  __|  |  __ \    _` |
     |   |  |  |  |    |    |  |   |  (   |
    _.__/  _| _| \__| \__| _| _|  _| \__, |
                                     |___/
    Blitting, http://blitting.com
    Copyright (c) 2014 Jason Sturges, http://jasonsturges.com
*/
package blitting.util;

import openfl.events.TimerEvent;
import openfl.utils.Timer;

/**
 *  Utility to call a handler once at a later time.
 */
class CallLater {

    //------------------------------
    //  model
    //------------------------------

    private var delay:Int = 1;
    private var scope:Dynamic;
    private var callback:Dynamic;
    private var params:Array<Dynamic>;
    private var timer:Timer;


    //------------------------------
    //  lifecycle
    //------------------------------

    /**
        Constructor
        @param delay     The delay in ms to make the call.
        @param scope     An object that specifies the scope (value of `this` object) within the function body.
        @param callback  Function to call after the specified delay.
        @param params    Parameters to be passed to the function.
    **/
    public function new(delay:Int = 1, ?scope:Dynamic, ?callback:Dynamic, ?params:Array<Dynamic>) {
        this.delay = delay;
        this.scope = scope;
        this.callback = callback;
        this.params = params;

        timer = null;
    }

    /**
     *  Call, and wait for callback.
     */
    public function call():Void {
        var delay:Int = (delay > 0) ? (delay) : (0);

        if (delay > 0 && timer == null) {
            timer = new Timer(delay, 1);
            timer.addEventListener(TimerEvent.TIMER, timerHandler);
            timer.start();
        }
        else {
            callHandler();
        }
    }

    private function timerHandler(timerEvent:TimerEvent):Void {
        timer.reset();
        timer.removeEventListener(TimerEvent.TIMER, timerHandler);
        timer = null;

        callHandler();
    }

    private function callHandler():Void {
        if (callback != null)
            Reflect.callMethod(scope, callback, params);

        callback = null;
        params = null;
    }

}
