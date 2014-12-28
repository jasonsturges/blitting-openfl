/*
     |      | _)  |    |   _)
     __ \   |  |  __|  __|  |  __ \    _` |
     |   |  |  |  |    |    |  |   |  (   |
    _.__/  _| _| \__| \__| _| _|  _| \__, |
                                     |___/
    Blitting, http://blitting.com
    Copyright (c) 2014 Jason Sturges, http://jasonsturges.com
*/
package blitting.model;

import blitting.lifecycle.IDisposable;
import blitting.lifecycle.IInitializable;
import blitting.model.ISingleton;

class ObjectPool implements ISingleton<ObjectPool> {

    //------------------------------
    //  singleton instance
    //------------------------------

    private static var instance:ObjectPool;

    public static function getInstance():ObjectPool {
        if (instance == null)
            instance = new ObjectPool();

        return instance;
    }


    //------------------------------
    //  model
    //------------------------------

    private var pool:Map<String, Array<Dynamic>>;

    private var MAX_POOL_SIZE:UInt = 64;


    //------------------------------
    //  lifecycle
    //------------------------------

    public function new() {
        pool = new Map<String, Array<Dynamic>>();
    }

    public function construct<T>(type:Class<T>):T {
        if (type == null)
            return null;

        var className:String = Type.getClassName(type);

        if (!pool.exists(className))
            pool[className] = new Array<Dynamic>();

        var set:Array<Dynamic> = pool[className];

        if (set.length > 0) {
            var object:Dynamic = set.pop();

            if (Std.is(object, IInitializable))
                cast((object), IInitializable).initialize();

            return object;
        }

        return Type.createInstance(type, []);
    }

    public function dispose<T>(object:Dynamic, ?type:Class<Dynamic>):Void {
        if (object == null)
            return;

        if (type == null)
            type = Type.getClass(object);

        var className:String = Type.getClassName(type);

        if (Std.is(object, IDisposable))
            cast((object), IDisposable).dispose();

        if (!pool.exists(className))
            pool[className] = new Array<Dynamic>();

        var set:Array<Dynamic> = pool[className];

        if (set.length > MAX_POOL_SIZE)
            return;

        set.push(object);
    }

}
