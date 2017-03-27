/*
     |      | _)  |    |   _)
     __ \   |  |  __|  __|  |  __ \    _` |
     |   |  |  |  |    |    |  |   |  (   |
    _.__/  _| _| \__| \__| _| _|  _| \__, |
                                     |___/
    Blitting, http://blitting.com
    Copyright (c) 2014 Jason Sturges, http://jasonsturges.com
*/
package blitting.controls;

import blitting.core.RenderType;
import blitting.display.ResizableViewport;

class AbstractControl<T> extends ResizableViewport implements IControl<T> {

    //------------------------------
    //  model
    //------------------------------

    private var _value:T;

    public var value(get, set):T;

    public function get_value():T {
        return _value;
    }

    public function set_value(value:T):T {
        if (_value != value)
            invalidate();

        return _value = value;
    }


    //------------------------------
    //  lifecycle
    //------------------------------

    public function new() {
        super();
    }

    override public function initialize():Void {
        super.initialize();

        renderType = RenderType.OnInvalidation;
        value = null;
    }

}
