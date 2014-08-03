package utils
{
	import com.coffeebean.swf.typeData.S9ImageData;
	
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	
	import lzm.starling.swf.tool.Starup;

	public class Scale9Util
	{
		/**
		 * 获取scale9image的变形范围
		 * */
		public static function getScale9Info(clazz:Class):S9ImageData
		{
			var mc:MovieClip = new clazz();
			Starup.tempContent.addChild(mc);
			var rect:Rectangle = mc.getBounds(Starup.tempContent);
			Starup.tempContent.removeChild(mc);
			
			var s9Data:S9ImageData = new S9ImageData();
			s9Data.x = (mc.scale9Grid.x - rect.x) * Util.swfScale;
			s9Data.y = (mc.scale9Grid.y - rect.y) * Util.swfScale;
			s9Data.width = (mc.scale9Grid.width) * Util.swfScale;
			s9Data.height = (mc.scale9Grid.height) * Util.swfScale;
			return s9Data;
		}
	}
}