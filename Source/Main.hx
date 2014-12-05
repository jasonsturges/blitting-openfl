package;

import blitting.constant.ColorPalette;
import blitting.controller.AbstractController;
import blitting.controller.IController;
import blitting.controller.MovieClipController;
import blitting.controls.AbstractControl;
import blitting.controls.IControl;
import blitting.core.Blitting;
import blitting.core.RenderType;
import blitting.core.ValidationType;
import blitting.display.AbstractViewport;
import blitting.display.AbstractRenderer;
import blitting.display.BitmapRenderer;
import blitting.display.BufferedViewport;
import blitting.display.Context3dRenderer;
import blitting.display.GraphicsRenderer;
import blitting.display.IBitmapRenderer;
import blitting.display.IContext3dRenderer;
import blitting.display.IGraphicsRenderer;
import blitting.display.IRenderer;
import blitting.display.IViewport;
import blitting.display.RenderedViewport;
import blitting.display.ResizableViewport;
import blitting.display.Viewport;
import blitting.display.Viewport3d;
import blitting.effects.AbstractEffect;
import blitting.effects.IEffect;
import blitting.error.BlittingInvalidOperation;
import blitting.error.BlittingRenderError;
import blitting.event.EventPipeline;
import blitting.lifecycle.IDisposable;
import blitting.lifecycle.IInitializable;
import blitting.lifecycle.IProcess;
import blitting.lifecycle.IRenderable;
import blitting.lifecycle.IResizable;
import blitting.lifecycle.IValidatable;
import blitting.math.Geometry;
import blitting.math.Numeric;
import blitting.math.Statistics;
import blitting.model.Color;
import blitting.model.IFactory;
import blitting.model.ISingleton;
import blitting.model.ObjectPool;
import blitting.model.TimeSpan;
import blitting.model.UUID;
import blitting.net.AbstractService;
import blitting.net.AbstractSocketService;
import blitting.net.XmlService;
import blitting.time.CallLater;
import blitting.time.CountdownTimer;
import blitting.time.RandomTimer;

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
