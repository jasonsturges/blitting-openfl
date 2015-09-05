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

import blitting.model.ISingleton;

class EventPipeline extends EventDispatcher implements ISingleton<EventPipeline> {

    //------------------------------
    //  singleton instance
    //------------------------------

    public static var instance(get, null):EventPipeline;

    private static function get_instance():EventPipeline {
        if (instance == null)
            instance = new EventPipeline();

        return instance;
    }


    //------------------------------
    //  lifecycle
    //------------------------------

    public function new() {
        super();
    }

}
