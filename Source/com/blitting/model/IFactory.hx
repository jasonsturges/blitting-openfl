package com.blitting.model;

interface IFactory<T> {

    function create <T> ():IFactory<T>;

}
