/*
     |      | _)  |    |   _)
     __ \   |  |  __|  __|  |  __ \    _` |
     |   |  |  |  |    |    |  |   |  (   |
    _.__/  _| _| \__| \__| _| _|  _| \__, |
                                     |___/
    Blitting, http://blitting.com
    Copyright (c) 2014 Jason Sturges, http://jasonsturges.com
*/
package blitting.display;
import blitting.core.RenderType;
import blitting.error.BlittingRenderError;

import openfl.display.Stage3D;
import openfl.display3D.Context3D;
import openfl.display3D.Context3DRenderMode;
import openfl.events.ErrorEvent;
import openfl.events.Event;
import openfl.geom.Rectangle;
import openfl.system.ApplicationDomain;

class Viewport3d extends ResizableViewport {

    //------------------------------
    //  model
    //------------------------------

    private var _antiAlias:Int;
    private var _context3d:Context3D;
    private var _context3dCreated:Bool;
    private var _context3dRenderMode:String;
    private var _enableDepthAndStencil:Bool;
    private var _enableErrorChecking:Bool;
    private var _fillColor:UInt;
    private var _stage3d:Stage3D;
    private var _stage3dAvailable:Bool;


    //------------------------------
    //  lifecycle
    //------------------------------

    public function new(fillColor:UInt = 0xff000000, context3dRenderMode:String = "auto") {
        super();

        _fillColor = fillColor;
        _context3dRenderMode = context3dRenderMode;

        autoOrientation();
        fullStage = true;
    }

    override public function initialize():Void {
        super.initialize();

        _antiAlias = 16;
        _context3d = null;
        _context3dCreated = false;
        _context3dRenderMode = Context3DRenderMode.AUTO;
        _enableDepthAndStencil = true;
        _enableErrorChecking = false;
        _fillColor = 0xff000000;
        _stage3d = null;
        _stage3dAvailable = false;
    }

    override private function addedToStageHandler(event:Event):Void {
        super.addedToStageHandler(event);

        stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE, context3dCreateHandler);
        stage.stage3Ds[0].addEventListener(ErrorEvent.ERROR, errorEventHandler);
        stage.stage3Ds[0].requestContext3D(_context3dRenderMode);
    }

    private function context3dCreateHandler(event:Event):Void {
        _stage3d = cast(event.target, Stage3D);
        _stage3d.removeEventListener(Event.CONTEXT3D_CREATE, context3dCreateHandler);

        _context3d = _stage3d.context3D;
        _context3d.enableErrorChecking = _enableErrorChecking;
        _context3d.configureBackBuffer(stage.stageWidth, stage.stageHeight, _antiAlias, _enableDepthAndStencil);

        _context3dCreated = true;
        changeRenderType(RenderType.Continuous);
    }

    private function errorEventHandler(event:ErrorEvent):Void {
        throw new BlittingRenderError(event.text, event.errorID);
    }

    override public function layout():Void {
        super.layout();

        if (_context3d == null)
            return;

        _context3d.configureBackBuffer(stage.stageWidth, stage.stageHeight, _antiAlias, _enableDepthAndStencil);
    }

    override public function prerender():Void {
        super.prerender();

        if (_context3d == null)
            return;

        _context3d.clear(0, 0, 0, 1);
    }

    override public function postrender(changeRect:Rectangle = null):Void {
        super.postrender(changeRect);

        if (_context3d == null)
            return;

        _context3d.present();
    }

    override private function removedFromStageHandler(event:Event):Void {
        super.removedFromStageHandler(event);

        stage.stage3Ds[0].removeEventListener(ErrorEvent.ERROR, errorEventHandler);
    }

    override public function dispose():Void {
        super.dispose();
    }

}
