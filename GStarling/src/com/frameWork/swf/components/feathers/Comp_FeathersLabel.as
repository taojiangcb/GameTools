package com.frameWork.swf.components.feathers
{
	
	import feathers.controls.Label;
	
	import lzm.starling.swf.components.ISwfComponent;
	import lzm.starling.swf.display.SwfSprite;
	
	import starling.display.DisplayObject;
	import starling.text.TextField;
	
	public class Comp_FeathersLabel extends Label implements ISwfComponent
	{
		public function Comp_FeathersLabel()
		{
			super();
		}
		
		public function initialization(componetContent:SwfSprite):void
		{
			var _textFormat:TextField = componetContent.getTextField("_textFormat");
			if(_textFormat != null){
				this.textRendererProperties.fontFamily = _textFormat.fontName;
				this.textRendererProperties.fontSize = _textFormat.fontSize;
				this.textRendererProperties.color = _textFormat.color;
				this.textRendererProperties.text = _textFormat.text;
			}
			componetContent.removeFromParent(true);
		}
		
		public function get editableProperties():Object{
			return {};
		}
		
		public function set editableProperties(properties:Object):void{
			for(var key:String in properties){
				this[key] = properties[key];
			}
		}
		
	}
}