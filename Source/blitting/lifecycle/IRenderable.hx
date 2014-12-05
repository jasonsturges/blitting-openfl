package blitting.lifecycle;

import openfl.geom.Rectangle;

interface IRenderable {

    function prerender():Void;

    function render():Void;

    function postrender(changeRect:Rectangle = null):Void;

}
