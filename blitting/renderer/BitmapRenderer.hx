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

import openfl.display.BitmapData;
import blitting.renderer.AbstractRenderer;
import blitting.renderer.IBitmapRenderer;

class BitmapRenderer extends AbstractRenderer implements IBitmapRenderer {

    //------------------------------
    //  model
    //------------------------------

    private var bitmapData:BitmapData;


    //------------------------------
    //  lifecycle
    //------------------------------

    public function new() {
        super();
    }

    override public function initialize():Void {
        super.initialize();

        bitmapData = null;
    }

    public function render(bitmapData:BitmapData):Void {
        this.bitmapData = bitmapData;
    }

    override public function dispose():Void {
        super.dispose();

        bitmapData = null;
    }

}
