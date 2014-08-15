package application.comps
{
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.geom.Point;
	import mx.core.UIComponent;
	
	public class RootStage extends UIComponent
	{
		/**
		 * 中心点 
		 */		
		public var centerPt:Point;
		
		/**
		 * 主对像容器，十字聚焦点 
		 */		
		public function RootStage()
		{
			super();
			width = 2096 * 2;
			height = 1280 * 2;
			centerPt = new Point(width >> 1,height >> 1);
		}
		
		protected override function createChildren():void
		{
			super.createChildren();
			drawLine();
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