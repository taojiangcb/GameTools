package com.frameWork.swf.components.feathers
{
	import lzm.starling.swf.components.BitmapTextField;
	import lzm.starling.swf.components.ISwfComponent;
	import lzm.starling.swf.display.SwfSprite;
	
	import starling.text.TextField;
	
	

	/**
	 * Flash中的位图数字组件 
	 * @author JiangTao
	 * 
	 */	
	public class Comp_BitmapField extends BitmapTextField implements ISwfComponent
	{
		
		public function Comp_BitmapField():void
		{
			super(1,1,"0","JCHEadA",20,0,false);
			isCoustomColor = true;
		}
		
		/**
		 * 初始化组件 
		 * @param componetContent	组件的基础显示内容
		 */	
		public function initialization(componetContent:SwfSprite):void
		{
			var _textFormat:TextField = componetContent.getChildByName("_textFormat") as TextField;
			if(_textFormat)
			{
				width 		= _textFormat.width;
				height 		= _textFormat.height;
				color 		= _textFormat.color;
				fontSize 	= _textFormat.fontSize;
				hAlign 		= _textFormat.hAlign;
				vAlign 		= _textFormat.vAlign;
				text 		= _textFormat.text;
			}
			componetContent.removeFromParent(true);
		}
		
		public function get editableProperties():Object{
			return {
				color:color,
				fontSize:fontSize,
				text:text,
				fontSize:fontSize,
				hAlign:hAlign,
				vAlign:vAlign
			};
		}
		
		public function set editableProperties(properties:Object):void{
			for(var key:String in properties){
				this[key] = properties[key];
			}
		}
	}
}