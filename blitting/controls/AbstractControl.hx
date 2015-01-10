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

class AbstractControl<T> extends ResizableViewport implements IControl {

    //------------------------------
    //  model
    //------------------------------

    @:isVar private var value(get, set):T;

    public function get_value():T {
        return value;
    }

    public function set_value(value:T):T {
        if (this.value != value)
            invalidate();

        return this.value = value;
    }


    //------------------------------
    //  lifecycle
    //------------------------------

    public function new() {
        super();

        renderType = RenderType.OnInvalidation;
    }

    override public function initialize():Void {
        super.initialize();

        value = null;
    }

}
