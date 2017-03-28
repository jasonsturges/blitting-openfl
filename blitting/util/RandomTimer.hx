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
 * Dispatch timer events at random intervals.
 *  
 * Inherits from native `openfl.utils.Timer`;
 * therefore, implemented using standard timer patterns.
 *  
 * Dispatches native `openfl.events.TimerEvent`
 * of types `TimerEvent.TIMER` and `TimerEvent.TIMER_COMPLETE`.
 *  
 * When inheriting from RandomTimer, the `timerHandler()` override
 * provides a convenient implementation to timer
 * event handling without directly assigning listeners.
 *
 * Example:
 *
 * ```
 * public class FunctionTimer extends RandomTimer {
 *     private var _functions:Vector.<Function> = new <Function>[];
 *
 *     public function addFunction(f:Function):void {
 *         _functions.push(f);
 *     }
 *
 *     override protected function timerHandler(event:TimerEvent):void {
 *         super.timerHandler(event);
 *         for each(var f:Function in _functions) {
 *             if (f != null)
 *                 f();
 *         }
 *     }
 * }
 * ```
 */
class RandomTimer extends Timer {

    //------------------------------
    //  model
    //------------------------------

    /** Minimum possible delay for random timer signal. */
    public var minimumDelay:Float;

    /** Maximum possible delay for random timer signal. */
    public var maximumDelay:Float;

    private var _count:UInt = 0;
    private var _repeatCount:UInt = 0;


    //------------------------------
    //  lifecycle
    //------------------------------

    /**
     * Create random timer dispatching events within
     * min / max millisecond values.
     */
    public function new(min:Float, max:Float, repeatCount:UInt = 0) {
        super(delay, repeatCount);

        minimumDelay = min;
        maximumDelay = max;
        _repeatCount = repeatCount;
    }

    /**
     * Start the timer.  As the timer runs, random
     * delay periods will be set on each timer event.
     */
    override public function start():Void {
        delay = nextDelay();
        addEventListener(TimerEvent.TIMER, timerHandler);
        super.start();
    }

    /**
     * Determine next delay period.
     */
    private function nextDelay():Float {
        return (minimumDelay + (Math.random() * (maximumDelay - minimumDelay)));
    }

    /**
     * Stop the timer.
     */
    override public function stop():Void {
        removeEventListener(TimerEvent.TIMER, timerHandler);
        super.stop();
    }

    /**
     * Handler on TimerEvent.TIMER, responsible for
     * changing delay to random value.
     */
    @:dox(show)
    private function timerHandler(event:TimerEvent):Void {
        _count++;

        if ((_repeatCount > 0) && (_count >= _repeatCount))
            stop();

        delay = nextDelay();
    }

}
