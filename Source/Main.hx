package;

import blitting.time.RandomTimer;
import blitting.time.CountdownTimer;
import blitting.time.CallLater;
import blitting.net.XmlService;
import blitting.net.AbstractSocketService;
import blitting.net.AbstractService;
import blitting.model.UUID;
import blitting.model.TimeSpan;
import blitting.model.ObjectPool;
import blitting.model.Color;
import blitting.model.ISingleton;
import blitting.model.IFactory;
import blitting.math.Statistics;
import blitting.math.Numeric;
import blitting.math.Geometry;
import blitting.lifecycle.IValidatable;
import blitting.lifecycle.IResizable;
import blitting.lifecycle.IProcess;
import blitting.lifecycle.IInitializable;
import blitting.lifecycle.IDisposable;
import blitting.event.EventPipeline;
import blitting.error.BlittingRenderError;
import blitting.error.BlittingInvalidOperation;
import blitting.effects.IEffect;
import blitting.display.Viewport3d;
import blitting.display.ResizableViewport;
import blitting.display.RenderedViewport;
import blitting.display.IViewport;
import blitting.display.IRenderer;
import blitting.lifecycle.IRenderable;
import blitting.display.IGraphicsRenderer;
import blitting.display.IContext3dRenderer;
import blitting.display.IBitmapRenderer;
import blitting.display.GraphicsRenderer;
import blitting.display.Context3dRenderer;
import blitting.display.BufferedViewport;
import blitting.display.BitmapRenderer;
import blitting.display.AbstractViewport;
import blitting.display.AbstractRenderer;
import blitting.effects.AbstractEffect;
import blitting.core.ValidationType;
import blitting.core.RenderType;
import blitting.core.Blitting;
import blitting.controls.IControl;
import blitting.controls.AbstractControl;
import blitting.controller.MovieClipController;
import blitting.controller.IController;
import blitting.controller.AbstractController;
import blitting.constant.ColorPalette;
import blitting.display.Viewport;

class Main extends Viewport {

    public function new() {
        super();

        var linkageLibrary:Array<Dynamic> = [
            AbstractControl,
            AbstractController,
            AbstractEffect,
            AbstractRenderer,
            AbstractService,
            AbstractSocketService,
            AbstractViewport,
            BitmapRenderer,
            Blitting,
            BlittingInvalidOperation,
            BlittingRenderError,
            BufferedViewport,
            CallLater,
            Color,
            ColorPalette,
            Context3dRenderer,
            CountdownTimer,
            EventPipeline,
            Geometry,
            GraphicsRenderer,
            IBitmapRenderer,
            IContext3dRenderer,
            IControl,
            IController,
            IDisposable,
            IEffect,
            IFactory,
            IGraphicsRenderer,
            IInitializable,
            IProcess,
            IRenderable,
            IRenderer,
            IResizable,
            ISingleton,
            IValidatable,
            IViewport,
            MovieClipController,
            Numeric,
            ObjectPool,
            RandomTimer,
            RenderedViewport,
            RenderType,
            ResizableViewport,
            Statistics,
            TimeSpan,
            UUID,
            ValidationType,
            Viewport,
            Viewport3d,
            XmlService
        ];
    }

}
