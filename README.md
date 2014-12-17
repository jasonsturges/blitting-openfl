Blitting OpenFL
===============

## Introduction

Blitting OpenFL is a rendering engine and lifecycle pipeline, distributed as a haxelib.

Focused in bit blit (bit-boundary block transfer), Blitting leverages performance oriented design
for graphics, bitmap, and 3D rendering.  Through a core engine, pipelines optimize rendering, layout, and invalidation lifecycles.

Blitting OpenFL is an [OpenFL](http://www.openfl.org/) port to the [Haxe](http://haxe.org/) programming language
of the [Blitting](https://github.com/jasonsturges/blitting) ActionScript library.  ActionScript developers should use Blitting.


### Where do I find more information?

Here are a few starting points:

* [API Reference](http://api.blitting.com)


### Releases

* beta, coming soon


### Generating ASDoc Documentation

To generate documentation, first build target appending the `-xml` argument, such as :

    openfl build flash -xml

Then, run dox:

    haxelib run dox -i Export/flash/ -o Documentation/ -in blitting


## Licence

Copyright 2014 [Jason Sturges](http://jasonsturges.com)

This project is free, open-source software under the [MIT license](LICENSE.md).
