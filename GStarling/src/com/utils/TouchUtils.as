package com.utils
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.utils.Color;

	public class TouchUtils
	{
		
		public function oneTouchOnTag(display:DisplayObject):void
		{
			
		}
		
		public function twoTouchOnTag(display:DisplayObject):void
		{
			
		}
		
		public function TouchUtils()
		{
			
		}
		
		//验证当前的触发点是否是透明
		public static function isAlpha(touch:Touch):Boolean
		{
			var target:DisplayObject = touch.target;
			if(target && target.stage)
			{
				var localPoint:Point = touch.getLocation(target);
				var bitmapData:BitmapData = Utils.copyAsBitmapData(target);
				var piexlColor:uint = bitmapData.getPixel32(localPoint.x,localPoint.y);
				var alpna:uint = Color.getAlpha(piexlColor);
				if(alpna <= 20)
				{
					return true;
				}
			}
			return false;
		}
		
	}
}