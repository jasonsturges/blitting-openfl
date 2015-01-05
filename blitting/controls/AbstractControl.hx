/*
     |      | _)  |    |   _)
     __ \   |  |  __|  __|  |  __ \    _` |
     |   |  |  |  |    |    |  |   |  (   |
    _.__/  _| _| \__| \__| _| _|  _| \__, |
                                     |___/
    Blitting, http://blitting.com
    Copyright (c) 2014 Jason Sturges, http://jasonsturges.com
*/
package blitting.controls;

import blitting.core.RenderType;
import blitting.display.ResizableViewport;

class AbstractControl extends ResizableViewport implements IControl {

    //------------------------------
    //  lifecycle
    //------------------------------

    public function new() {
        super();

        renderType = RenderType.OnInvalidation;
    }

}
