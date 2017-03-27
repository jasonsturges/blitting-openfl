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

interface IRange<T> {

    var minimum(get, set):T;
    function get_minimum():T;
    function set_minimum(value:T):T;

    var maximum(get, set):T;
    function get_maximum():T;
    function set_maximum(value:T):T;

}
