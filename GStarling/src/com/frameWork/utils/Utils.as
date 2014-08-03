package com.frameWork.utils
{
	import flash.display.BitmapData;
	import flash.display3D.Context3D;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import starling.core.RenderSupport;
	import starling.core.Starling;
	import starling.display.DisplayObject;

	public class Utils
	{
		public function Utils()
		{
		}
		
		/**
		 * 将Startling的DisplayObject转换为bitmapData 
		 * @param ARG_sprite
		 * @return 
		 * 
		 */		
		public static function copyAsBitmapData( displayObject :DisplayObject, transparentBackground : Boolean = true, backgroundColor : uint = 0xcccccc ) : BitmapData
		{
			var resultRect : Rectangle = new Rectangle();
			displayObject.getBounds( displayObject, resultRect );
			
			if(resultRect.width == 0 || resultRect.height == 0)
			{
				return null;
			}
			
			var result : BitmapData = new BitmapData( Starling.current.stage.stageWidth, Starling.current.stage.stageHeight, transparentBackground, backgroundColor );
			var context : Context3D = Starling.context;
			var support : RenderSupport = new RenderSupport();
			RenderSupport.clear();
			support.setOrthographicProjection(0, 0, Starling.current.stage.stageWidth, Starling.current.stage.stageHeight );
			support.applyBlendMode( true );
			support.translateMatrix( -resultRect.x, -resultRect.y );
			support.pushMatrix();
			support.blendMode = displayObject.blendMode;
			displayObject.render( support, 1.0 );
			support.popMatrix();
			support.finishQuadBatch();
			context.drawToBitmapData( result );
			
			var croppedRes:BitmapData = new BitmapData(resultRect.width, resultRect.height, transparentBackground, backgroundColor );
			croppedRes.copyPixels(result, resultRect, new Point(0,0));
			
			return croppedRes;
		}
	}
}