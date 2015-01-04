/*
     |      | _)  |    |   _)
     __ \   |  |  __|  __|  |  __ \    _` |
     |   |  |  |  |    |    |  |   |  (   |
    _.__/  _| _| \__| \__| _| _|  _| \__, |
                                     |___/
    Blitting, http://blitting.com
    Copyright (c) 2014 Jason Sturges, http://jasonsturges.com
*/
package blitting.event;

import openfl.events.EventDispatcher;

class EventPipeline extends EventDispatcher {

    public static var instance(default, null):EventPipeline = new EventPipeline();

    public function new() {
        super();
    }

}
