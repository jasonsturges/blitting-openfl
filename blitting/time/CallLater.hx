package
import openfl.events.TimerEvent;
import openfl.utils.Timer;

/**
    Setup a timer to call a handler once at a later time.
**/
class CallLater {

//------------------------------
//  model
//------------------------------

    /**
        The delay to make the call, in ms.  If delay is 0, then make the call
        immediately; otherwise, defaulting to 1ms to execute next frame.
     */
    @:dox(show)
    private var delay:Int = 1;

    /**
        An object that specifies the value of `this` object within the function body.
    **/
    @:dox(show)
    private var scope:Dynamic;

    /**
        The function to call.
    **/
    @:dox(show)
    private var callback:Dynamic;

    /**
        Parameters to be passed to the function.
    **/
    @:dox(show)
    private var params:Array<Dynamic>;

    /**
        Timer to dispatch time to call.
    **/
    @:dox(show)
    private var timer:Timer;


    //------------------------------
    //  lifecycle
    //------------------------------

    /**
        Constructor

        @param delay    The delay in ms to make the call.
        @param scope    An object that specifies the value of `this` object within the function body.
        @param callback The function to call.
        @param params   Parameters to be passed to the function.
    **/
    public function new(delay:Int = 1, ?scope:Dynamic, ?callback:Dynamic, ?params:Array<Dynamic>) {
        this.delay = delay;
        this.scope = scope;
        this.callback = callback;
        this.params = params;

        timer = null;
    }

    /**
        Call the function.
    **/
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

    /**
        Handler to execute the call function.
    **/
    @:dox(show)
    private function callHandler():Void {
        if (callback != null)
            Reflect.callMethod(scope, callback, params);

        callback = null;
        params = null;
    }

    /**
         @param timerEvent The type of the event
    **/
    @:dox(show)
    private function timerHandler(timerEvent:TimerEvent):Void {
        timer.reset();
        timer.removeEventListener(TimerEvent.TIMER, timerHandler);
        timer = null;

        callHandler();
    }
}
