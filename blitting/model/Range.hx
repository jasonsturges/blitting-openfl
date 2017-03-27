/*
     |      | _)  |    |   _)
     __ \   |  |  __|  __|  |  __ \    _` |
     |   |  |  |  |    |    |  |   |  (   |
    _.__/  _| _| \__| \__| _| _|  _| \__, |
                                     |___/
    Blitting, http://blitting.com
    Copyright (c) 2014 Jason Sturges, http://jasonsturges.com
*/
package blitting.model;

class Range<T> implements IRange<T> {

    //------------------------------
    //  model
    //------------------------------

    private var _minimum:T;
    private var _maximum:T;

    /**
     *  Minimum value
     */
    public var minimum(get, set):T;

    public function get_minimum():T {
        return _minimum;
    }

    public function set_minimum(value:T):T {
        return _minimum = value;
    }

    /**
     *  Maximum value
     */
    public var maximum(get, set):T;

    public function get_maximum():T {
        return _maximum;
    }

    public function set_maximum(value:T):T {
        return _maximum = value;
    }


    //------------------------------
    //  lifecycle
    //------------------------------

    public function new() {
    }
}
