package com.blitting.controller;

import openfl.events.EventDispatcher;
import openfl.events.IEventDispatcher;

class AbstractController extends EventDispatcher implements IController {

    public function new(target:IEventDispatcher = null) {
        super(target);
    }

}
