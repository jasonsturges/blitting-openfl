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

import openfl.display.DisplayObject;
import openfl.display.Graphics;
import blitting.display.AbstractRenderer;
import blitting.display.IGraphicsRenderer;

class GraphicsRenderer extends AbstractRenderer implements IGraphicsRenderer {

    //------------------------------
    //  model
    //------------------------------

    private var displayObject:DisplayObject;

    private var graphics:Graphics;


    //------------------------------
    //  lifecycle
    //------------------------------

    public function new() {
        super();
    }

    override public function initialize():Void {
        super.initialize();

        displayObject = null;
        graphics = null;
    }

    public function render(graphics:Graphics, ?displayObject:DisplayObject):Void {
        this.displayObject = displayObject;
        this.graphics = graphics;
    }

    override public function dispose():Void {
        super.dispose();

        displayObject = null;
        graphics = null;
    }

}
