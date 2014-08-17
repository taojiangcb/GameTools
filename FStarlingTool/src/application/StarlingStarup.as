package lzm.starling.swf.tool.starling
{
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.utils.setTimeout;
	
	import feathers.display.Scale9Image;
	
	import lzm.starling.STLConstant;
	import lzm.starling.STLMainClass;
	import lzm.starling.STLRootClass;
	import lzm.starling.STLStarup;
	import lzm.starling.gestures.DragGestures;
	import lzm.starling.swf.Swf;
	import lzm.starling.swf.display.ShapeImage;
	import lzm.starling.swf.tool.asset.Assets;
	import lzm.util.Mobile;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Shape;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.HAlign;
	
	/**
	 * 
	 * @author zmliu
	 * 
	 */
	public class StarlingStarup extends STLStarup
	{
		
		private var contentSprite:Sprite;
		private var lineShape:Shape;
		private var w:Number = 1024;
		private var h:Number = 800-121;
		private var centerPoint:Point = new Point(200,200);
		
		private var main:STLMainClass;
		
		private var dragGestures:DragGestures;
		
		public function StarlingStarup()
		{
			super();
			addEventListener(flash.events.Event.ADDED_TO_STAGE,addToStage);
		}
		
		private function addToStage(e:flash.events.Event):void{
			removeEventListener(flash.events.Event.ADDED_TO_STAGE,addToStage);
			
			STLConstant.nativeStage = stage;
			
			Starling.handleLostContext = !Mobile.isIOS();
			
			var viewPort:Rectangle = new Rectangle(0,121,w,h);
			STLConstant.StageWidth = viewPort.width;
			STLConstant.StageHeight = viewPort.height;
			
			_mStarling = new Starling(STLRootClass, stage, viewPort,null,"auto","baseline");
			_mStarling.antiAliasing = 0;
			_mStarling.stage.stageWidth  = STLConstant.StageWidth;
			_mStarling.stage.stageHeight = STLConstant.StageHeight;
			_mStarling.simulateMultitouch  = false;
			_mStarling.enableErrorChecking = Capabilities.isDebugger;
			
			_mStarling.addEventListener(starling.events.Event.ROOT_CREATED, 
				function onRootCreated(event:Object, app:STLRootClass):void
				{
					STLConstant.currnetAppRoot = app;
					
					_mStarling.removeEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);
					_mStarling.start();
					_mStarling.showStatsAt(HAlign.LEFT);
					
					lineShape = new Shape();
					app.addChild(lineShape);
					drawLine();
					
					contentSprite = new Sprite();
					app.addChild(contentSprite);
					
					Swf.init(contentSprite);
					
					setTimeout(function():void{
						dragGestures = new DragGestures(app,onDrag);
					},300);
				});
		}
		
		public function setDrag(value:Boolean):void{
			if(value){
				dragGestures = new DragGestures(STLConstant.currnetAppRoot,onDrag);
			}else{
				dragGestures.dispose();
				dragGestures = null;
			}
		}
		
		public function showScale9(name:String):void{
			var spr:Sprite = new Sprite();
			
			var scale91:DisplayObject = Assets.swf.createS9Image(name);
			spr.addChild(scale91);
			
			var scale92:DisplayObject = Assets.swf.createS9Image(name);
			spr.addChild(scale92);
			scale92.x = scale91.width + 12;
			scale92.width = scale92.width < 200 ? 200 : scale92.width;
			scale92.height = scale92.height < 200 ? 200 : scale92.height;
			
			showObject(spr);
		}
		
		public function showShapeImage(name:String):void{
			var spr:Sprite = new Sprite();
			
			var shapeImage1:ShapeImage = Assets.swf.createShapeImage(name);
			spr.addChild(shapeImage1);
			
			var shapeImage2:ShapeImage = Assets.swf.createShapeImage(name);
			spr.addChild(shapeImage2);
			shapeImage2.x = shapeImage1.width + 12;
			shapeImage2.width = shapeImage2.width < 200 ? 200 : shapeImage2.width;
			shapeImage2.height = shapeImage2.height < 200 ? 200 : shapeImage2.height;
			
			showObject(spr);
		}
		
		public function showObject(object:DisplayObject):void{
			contentSprite.removeChildren(0,-1,true);
			
			var rect:Rectangle = object.getBounds(object.parent);
			object.x = centerPoint.x;
			object.y = centerPoint.y;
			
			contentSprite.addChild(object);
		}
		
		public function clear():void{
			contentSprite.removeChildren();
		}
		
		private function onDrag():void{
			drawLine();
		}
		
		private function drawLine():void{
			var x:Number = STLConstant.currnetAppRoot.x;
			var y:Number = STLConstant.currnetAppRoot.y;
			
			lineShape.graphics.clear();
			lineShape.graphics.lineStyle(1,0xffffff);
			lineShape.graphics.moveTo(-x,centerPoint.y);
			lineShape.graphics.lineTo(w - x,centerPoint.y);
			lineShape.graphics.moveTo(centerPoint.x,-y);
			lineShape.graphics.lineTo(centerPoint.x,h - y);
			lineShape.graphics.endFill();
		}
	}
}