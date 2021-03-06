/*
     |      | _)  |    |   _)
     __ \   |  |  __|  __|  |  __ \    _` |
     |   |  |  |  |    |    |  |   |  (   |
    _.__/  _| _| \__| \__| _| _|  _| \__, |
                                     |___/
    Blitting, http://blitting.com
    Copyright (c) 2014 Jason Sturges, http://jasonsturges.com
*/
package blitting.controller;

import openfl.events.EventDispatcher;
import openfl.events.IEventDispatcher;

class AbstractController<T> extends EventDispatcher
    implements IController<T> {

    public function new(target:IEventDispatcher = null) {
        super(target);
    }

}
