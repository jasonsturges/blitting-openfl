package blitting.display;

import openfl.geom.Point;
import openfl.geom.Rectangle;

interface IViewport {

    public var bounds(get, set):Rectangle;
    public function get_bounds():Rectangle;
    public function set_bounds(value:Rectangle):Rectangle;

    public var registration(get, set):Point;
    public function get_registration():Point;
    public function set_registration(value:Point):Point;

}
