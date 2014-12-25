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

import openfl.display3D.Context3D;
import openfl.display3D.IndexBuffer3D;
import openfl.display3D.Program3D;
import openfl.display3D.VertexBuffer3D;
import blitting.display.AbstractRenderer;

class Context3dRenderer extends AbstractRenderer {

    //------------------------------
    //  model
    //------------------------------

    private var program3d:Program3D;

    private var vertexBuffer3d:VertexBuffer3D;

    private var indexBuffer3d:IndexBuffer3D;


    //------------------------------
    //  lifecycle
    //------------------------------

    public function Context3dRenderer() {
        super();
    }

    public function render(context3d:Context3D):Void {
    }

    override public function dispose():Void {
        super.dispose();

        program3d = null;
        vertexBuffer3d = null;
        indexBuffer3d = null;
    }

}
