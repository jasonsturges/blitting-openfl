/*
     |      | _)  |    |   _)
     __ \   |  |  __|  __|  |  __ \    _` |
     |   |  |  |  |    |    |  |   |  (   |
    _.__/  _| _| \__| \__| _| _|  _| \__, |
                                     |___/
    Blitting, http://blitting.com
    Copyright (c) 2014 Jason Sturges, http://jasonsturges.com
*/
package blitting.time;

import blitting.lifecycle.IDisposable;
import openfl.events.TimerEvent;
import openfl.utils.Timer;

class CountdownTimer extends Timer implements IDisposable {

    //------------------------------
    //  model
    //------------------------------

    private var _time:Float = 0;

    public var time(get, set):Float;

    public function get_time():Float {
        return _time;
    }

    public function set_time(value:Float):Float {
        return _time = value;
    }


    //------------------------------
    //  lifecycle
    //------------------------------

    public function new(time:Float = 0, delay:Float = 1000) {
        super(delay, repeatCount);

        if (!Math.isNaN(time))
            this.time = time;

        repeatCount = Math.ceil(time / delay);

        addEventListener(TimerEvent.TIMER, timerHandler);
        addEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteHandler);
    }

    override public function start():Void {
        super.start();
    }

    private function timerHandler(event:TimerEvent):Void {
        time -= delay;
    }

    private function timerCompleteHandler(event:TimerEvent):Void {
    }

    override public function stop():Void {
        super.stop();
    }

    public function dispose():Void {
        removeEventListener(TimerEvent.TIMER, timerHandler);
        removeEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteHandler);
    }

}
