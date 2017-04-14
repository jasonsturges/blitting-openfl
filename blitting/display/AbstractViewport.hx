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

import openfl.display.Sprite;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import blitting.lifecycle.IDisposable;
import blitting.lifecycle.IInitializable;


class AbstractViewport extends Sprite
implements IViewport
implements IInitializable
implements IDisposable {


    //------------------------------
    //  model
    //------------------------------

    private var _bounds:Rectangle;
    private var _registration:Point;


    /**
     * Viewport bounds (IViewport)
     */
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
     * Constructor
     */
    public function new() {
        super();

        initialize();
    }

    /**
     * Initialize (IInitializable)
     */
    public function initialize():Void {
        bounds = new Rectangle();
        registration = new Point();
    }

    /**
     * Dispose (IDisposable)
     */
    public function dispose():Void {
        bounds = null;
        registration = null;
    }

}
