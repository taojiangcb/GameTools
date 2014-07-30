package com.gameabc.ipad.proto.movie
{
	import flash.display.Bitmap;
	
	import starling.textures.TextureAtlas;

	public class MovieBatchVO
	{
		public var textureAtlas:TextureAtlas
		public var movieClipVO:BatchVO
		public var xml:XML;
		public var bitmap:Bitmap;
		public function MovieBatchVO()
		{
		}
		public function dispose():void
		{
			if(textureAtlas)
				textureAtlas.dispose();
			if(bitmap)
				bitmap.bitmapData.dispose();
			bitmap = null;
			textureAtlas = null;
			movieClipVO = null;
			xml = null;
		}
	}
}