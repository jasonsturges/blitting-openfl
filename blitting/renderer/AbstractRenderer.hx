/*
     |      | _)  |    |   _)
     __ \   |  |  __|  __|  |  __ \    _` |
     |   |  |  |  |    |    |  |   |  (   |
    _.__/  _| _| \__| \__| _| _|  _| \__, |
                                     |___/
    Blitting, http://blitting.com
    Copyright (c) 2014 Jason Sturges, http://jasonsturges.com
*/
package blitting.renderer;

import openfl.geom.Point;
import openfl.geom.Rectangle;
import blitting.lifecycle.IDisposable;
import blitting.lifecycle.IInitializable;


class AbstractRenderer
    implements IRenderer
    implements IInitializable
    implements IDisposable {

    //------------------------------
    //  model
    //------------------------------

    private var _bounds:Rectangle;
    private var _registration:Point;


    /**
     * Viewport bounds (IRenderer)
     */
    public var bounds(get, set):Rectangle;

    public function get_bounds():Rectangle {
        return _bounds;
    }

    public function set_bounds(value:Rectangle):Rectangle {
        return _bounds = value;
    }

    /**
     * Registration point (IRenderer)
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

    public function new() {
        initialize();
    }

    public function initialize():Void {
        bounds = new Rectangle();
        registration = new Point();
    }

    public function dispose():Void {
        bounds = null;
        registration = null;
    }

}
