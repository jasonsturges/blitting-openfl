package
import openfl.events.TimerEvent;
import openfl.utils.Timer;

/**
 * <p>
 * Dispatch timer events at random intervals.
 * </p>
 * <p>
 * Inherits from native flash.utils.Timer;
 * therefore, implemented using standard Timer patterns.<br />
 * </p>
 * <p>
 * Dispatches native flash.events.TimerEvent
 * of types TimerEvent.TIMER and TimerEvent.TIMER_COMPLETE.
 * </p>
 */
class RandomTimer extends Timer {

    //------------------------------
    //  model
    //------------------------------

    /** Minimum possible delay for random timer signal. */
    public var minimumDelay:Float;

    /** Maximum possible delay for random timer signal. */
    public var maximumDelay:Float;

    /** _count */
    private var _count:UInt = 0;

    /** _repeatCount */
    private var _repeatCount:UInt = 0;


    //------------------------------
    //  lifecycle
    //------------------------------

    /**
     * constructor
     *
     * <p>
     * Create random timer dispatching events within
     * min / max millisecond values.<br />
     * </p>
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
     * Internal private function to determine next delay period.
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
     *
     * When inheriting from RandomTimer, this override
     * provides a convenient implementation to timer
     * event handling without directly assigned.
     *
     * Example:
     *
     * ```haxe
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
    @:dox(show)
    private function timerHandler(event:TimerEvent):Void {
        _count++;

        if ((_repeatCount > 0) && (_count >= _repeatCount))
            stop();

        delay = nextDelay();
    }

}
