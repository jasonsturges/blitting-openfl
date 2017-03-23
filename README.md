Blitting OpenFL
===============

## Introduction

Blitting OpenFL is a rendering engine and lifecycle pipeline, distributed as a haxelib.

Focused in bit blit (bit-boundary block transfer), Blitting leverages performance oriented design
for graphics, bitmap, and 3D rendering.  Through a core engine, pipelines optimize rendering, layout, and invalidation lifecycles.

Blitting OpenFL is an [OpenFL](http://www.openfl.org/) port to the [Haxe](http://haxe.org/) programming language
of the [Blitting](https://github.com/jasonsturges/blitting) ActionScript library.  ActionScript developers should use Blitting.

## Installation

This library can be installed through haxelib by executing:

    $ haxelib install blitting
    
To use a local copy as a development haxelib, clone this repo and link the source directory by executing:
 
     $ git clone https://github.com/jasonsturges/blitting-openfl.git
     $ haxelib dev blitting-openfl ./blitting-openfl
     
## Project Setup

For inclusion into a Haxe project, add this library by updating your project.xml:

    <project>
        ...
        <haxelib name="blitting" />
        ...
    </project>


### Where do I find more information?

Here are a few starting points:

* [API Reference](http://jasonsturges.github.io/blitting-openfl/)


### Releases

* v.0.9.1 beta on March 21, 2017
  - Rendering lifecycle, parity with blitting library 
* v0.9 beta on August 31, 2015
  - Initial import to haxelib.


### Generating Dox Documentation

To generate documentation using dox, execute:

    haxe documentation.hxml


## License

This project is free, open-source software under the [MIT license](LICENSE.md).

Copyright 2015 [Jason Sturges](http://jasonsturges.com)


