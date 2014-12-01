package com.blitting.display;

import openfl.display.Sprite;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import com.blitting.lifecycle.IDisposable;
import com.blitting.lifecycle.IInitializable;


class AbstractViewport extends Sprite
    implements IViewport
    implements IInitializable
    implements IDisposable {

    //------------------------------
    //  model
    //------------------------------

    /**
     * Viewport bounds (IViewport)
     */
    private var _bounds:Rectangle;

    public var bounds(get, set):Rectangle;

    public function get_bounds():Rectangle {
        return _bounds;
    }

    public function set_bounds(value:Rectangle):Rectangle {
        return _bounds = value;
    }

    /**
     * Registration point (IViewport)
     */
    private var _registration:Point;

    public var registration(get, set):Point;

    public function get_registration():Point {
        return _registration;
    }

    public function set_registration(value:Point):Point {
        return _registration = value;
    }


    //------------------------------
    //  lifecycle
    //------------------------------

    /**
     * constructor
     */

    public function new() {
        super();

        initialize();
    }

    /**
     * initialize (IInitializable)
     */

    public function initialize():Void {
        bounds = new Rectangle();
        registration = new Point();
    }

    /**
     * dispose (IDisposable)
     */

    public function dispose():Void {
        bounds = null;
        registration = null;
    }

}
