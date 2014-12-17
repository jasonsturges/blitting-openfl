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

    private static var _instance:EventPipeline;

    public static function getInstance():EventPipeline {
        if (EventPipeline._instance == null)
            EventPipeline._instance = new EventPipeline();

        return EventPipeline._instance;
    }

    public function new() {
        super();
    }

}
