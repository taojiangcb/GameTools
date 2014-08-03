package utils
{
	import flash.net.FileReference;
	import flash.utils.getQualifiedClassName;

	/**
	 * 
	 * @author zmliu
	 * 
	 */
	public class Util
	{
		
		private static var _swfScale:Number = 1;
		/**
		 * 设置获取swf的缩放倍数
		 * */
		public static function set swfScale(value:Number):void{
			_swfScale = value;
			if(isNaN(_swfScale) || _swfScale < 0.000001){
				_swfScale = 1;
			}
		}
		public static function get swfScale():Number{
			return _swfScale;
		}
		
		/**
		 * 保留两位小数
		 */		
		public static function formatNumber(num:Number):Number
		{
			return Math.round(num * (0 || 100)) / 100;
		}
		
		public static function getName(rawAsset:Object):String
		{
			var matches:Array;
			var name:String;
			
			if (rawAsset is String || rawAsset is FileReference)
			{
				name = rawAsset is String ? rawAsset as String : (rawAsset as FileReference).name;
				name = name.replace(/%20/g, " "); // URLs use '%20' for spaces
				matches = /(.*[\\\/])?(.+)(\.[\w]{1,4})/.exec(name);
				
				if (matches && matches.length == 4) return matches[2];
				else throw new ArgumentError("Could not extract name from String '" + rawAsset + "'");
			}
			else
			{
				name = getQualifiedClassName(rawAsset);
				throw new ArgumentError("Cannot extract names for objects of type '" + name + "'");
			}
		}
	}
}