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

interface IRenderer {

    public var bounds(get, set):Rectangle;
    public function get_bounds():Rectangle;
    public function set_bounds(value:Rectangle):Rectangle;

    public var registration(get, set):Point;
    public function get_registration():Point;
    public function set_registration(value:Point):Point;

}
