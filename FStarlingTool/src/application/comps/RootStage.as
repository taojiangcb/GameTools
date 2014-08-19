package application.comps
{
	import com.frameWork.gestures.DragGestures;
	import com.frameWork.swf.Swf;
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.system.Capabilities;
	
	import mx.core.UIComponent;
	
	import application.STLConstant;
	import application.STLRootClass;
	
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.ITextRenderer;
	
	import starling.core.Starling;
	import starling.events.Event;
	import starling.utils.HAlign;
	
	public class RootStage extends UIComponent
	{
		
		/**
		 * 零时空间 
		 */		
		public static var tempContent:Sprite = new Sprite();
		
		/**
		 * 中心点 
		 */		
		public var centerPt:Point;
		
		public static const STL_WIDTH:int = 2096 * 2;
		public static const STL_HEIGHT:int = 1280 * 2;
		
		private var mStarling:Starling;
		
		private var dragGestures:DragGestures;
		
		/**
		 * 主对像容器，十字聚焦点 
		 */		
		public function RootStage()
		{
			super();
			width = STL_WIDTH
			height = STL_HEIGHT;
			centerPt = new Point(width >> 1,height >> 1);
		}
		
		protected override function createChildren():void
		{
			super.createChildren();
			initStarling();
			drawLine();
		}
		
		/**
		 * 初始化starling() 
		 */		
		private function initStarling():void
		{
			mStarling = new Starling(STLRootClass, stage, null,null,"auto","baseline");
			mStarling.antiAliasing = 0;
			mStarling.stage.stageWidth  = RootStage.STL_WIDTH;
			mStarling.stage.stageHeight = RootStage.STL_HEIGHT;
			mStarling.simulateMultitouch  = false;
			mStarling.enableErrorChecking = Capabilities.isDebugger;
			mStarling.addEventListener(starling.events.Event.ROOT_CREATED,rootCreateComp);
		}
		
		private function rootCreateComp(event:starling.events.Event,app:STLRootClass):void
		{
			STLConstant.currnetAppRoot = app;
			mStarling.removeEventListener(starling.events.Event.ROOT_CREATED, rootCreateComp);
			mStarling.start();
			mStarling.showStatsAt(HAlign.LEFT);
			Swf.init(app);
			
			FeathersControl.defaultTextRendererFactory = function():ITextRenderer
			{
				return new TextFieldTextRenderer();
			};
			
//				lineShape = new Shape();
//				app.addChild(lineShape);
//				drawLine();

//				contentSprite = new Sprite();
//				app.addChild(contentSprite);

//				Swf.init(contentSprite);

//				setTimeout(function():void{
//					dragGestures = new DragGestures(app,onDrag);
//				},300);
		}
		
		public override function addChild(child:DisplayObject):DisplayObject
		{
			if(child)
			{
				child.x += centerPt.x;
				child.y += centerPt.y;
			}
			return addChild(child);
		}
		
		public override function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			if(child)
			{
				child.x += centerPt.x;
				child.y += centerPt.y;
			}
			return addChildAt(child,index);
		}
		
		public override function getChildAt(index:int):DisplayObject
		{
			var child:DisplayObject = super.getChildAt(index);
			if(child)
			{
				child.x -= centerPt.x;
				child.y -= centerPt.y;
			}
			return child;
		}
		
		public override function getChildByName(name:String):DisplayObject
		{
			var child:DisplayObject = super.getChildByName(name);
			if(child)
			{
				child.x -= centerPt.x;
				child.y -= centerPt.y;
			}
			return child;
		}
		
		private function drawLine():void
		{
			var g:Graphics = graphics;
			g.clear();
			g.lineStyle(1,0xFFFFFF,1);
			g.moveTo(0,centerPt.y);
			g.lineTo(width,centerPt.y);
			g.moveTo(centerPt.x,0);
			g.lineTo(centerPt.x,height);
		}
	}
}