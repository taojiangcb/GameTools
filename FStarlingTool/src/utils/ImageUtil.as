package utils
{
	import application.comps.RootStage;
	
	import com.coffeebean.swf.typeData.ImgData;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	
	/**
	 * 
	 * @author zmliu
	 * 
	 */
	public class ImageUtil
	{
		
		/**
		 * 获取图片bitmapdata
		 * */
		public static function getBitmapdata(clazz:Class,scale:Number):BitmapData
		{
			var object:Object = new clazz();
			var image:DisplayObject;
			
			if(object is BitmapData)
				image = new Bitmap(object as BitmapData);
			else
				image = object as DisplayObject;
			
			image.scaleX = image.scaleY = scale * Util.swfScale;
			
			RootStage.tempContent.addChild(image);
//			Starup.tempContent.addChild(image);
			
			var rect:Rectangle = image.getBounds(RootStage.tempContent);
			rect.width = rect.width < 1 ? 1 : rect.width;
			rect.height = rect.height < 1 ? 1 : rect.height;
			image.x = -rect.x;
			image.y = -rect.y;
			
			var addWidth:Number = Math.abs((image.x%1) + (rect.width%1));
			var addHeight:Number = Math.abs((image.y%1) + (rect.height%1));
			
			addWidth = (addWidth%1) > 0 ? int(addWidth+1) : addWidth;
			addHeight = (addHeight%1) > 0 ? int(addHeight+1) : addHeight;
			
			rect.width += addWidth;
			rect.height += addHeight;
			
			var bitmapdata:BitmapData = new BitmapData(rect.width,rect.height,true,0);
			bitmapdata.draw(RootStage.tempContent);
			
			RootStage.tempContent.removeChild(image);
			
			return bitmapdata;
		}
		
		/**
		 * 获取图片信息
		 * 返回坐标信息，x 和 y
		 */
		public static function getImageInfo(clazz:Class):ImgData
		{
			var object:Object = new clazz();
			var image:DisplayObject;
			if(object is BitmapData)
			{
				image = new Bitmap(object as BitmapData);
			}
			else
			{
				image = object as DisplayObject;
			}
			
			RootStage.tempContent.addChild(image);
			var rect:Rectangle = image.getBounds(RootStage.tempContent);
			RootStage.tempContent.removeChild(image);
			
			var exportData:ImgData = new ImgData();
			exportData.pivotX = Util.formatNumber(-rect.x * Util.swfScale);
			exportData.pivotY = Util.formatNumber(-rect.y  * Util.swfScale);
			return exportData;
		}
		
	}
}