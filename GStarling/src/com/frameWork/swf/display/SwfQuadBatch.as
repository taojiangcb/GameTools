package com.frameWork.swf.display
{
	import com.coffeebean.swf.typeData.SpriteData;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.QuadBatch;
	
	public class SwfQuadBatch extends QuadBatch
	{
		/**
		 * sprite的类名
		 * */
		public var spriteName:String;
		/**
		 * sprite本身的数据 
		 * */
		public var data:SpriteData;
		/**
		 * sprite child的数据
		 * */
		public var spriteData:SpriteData;
		
		private var mChilds:Vector.<DisplayObject>;
		
		public function SwfQuadBatch()
		{
			super();
			mChilds = new Vector.<DisplayObject>();
		}
		
		public function addChild(display:DisplayObject):void
		{
			if(display is Image)
			{
				addImage(display as Image);
				mChilds.push(display);
			}
			else if(display is QuadBatch)
			{
				addQuadBatch(display as QuadBatch);
				mChilds.push(display);
			}
			else if(display is Quad)
			{
				addQuad(display as Quad);
				mChilds.push(display);
			}
		}
		
		public override function dispose():void
		{
			if(mChilds)
			{
				while(mChilds.length > 0)
				{
					if(mChilds[0] != null) 	mChilds.shift().removeFromParent(true);
					else					mChilds.shift();
				}
			}
			mChilds = null;
			super.dispose();
		}
		
		public function getChildAt(index:int):DisplayObject
		{
			var len:int = mChilds.length;
			if(index < 0) return null;
			if(index >= len) return null;
			return mChilds[index];
		}
		
	}
}