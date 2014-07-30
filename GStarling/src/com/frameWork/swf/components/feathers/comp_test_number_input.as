package com.frameWork.swf.components.feathers
{
	
	import flash.text.TextFormat;
	
	import feathers.controls.TextInput;
	
	import lzm.starling.swf.components.ISwfComponent;
	import lzm.starling.swf.display.SwfSprite;
	
	import starling.display.DisplayObject;
	import starling.text.TextField;
	
	public class comp_test_number_input extends TextInput implements ISwfComponent
	{
		public function comp_test_number_input()
		{
			super();
		}
		
		public function initialization(componetContent:SwfSprite):void{
			var _backgroundSkin:DisplayObject = componetContent.getSkinByName("_backgroundFocusedSkin");
			var _backgroundDisabledSkin:DisplayObject = componetContent.getSkinByName("_backgroundFocusedSkin");
			var _backgroundFocusedSkin:DisplayObject = componetContent.getSkinByName("_backgroundFocusedSkin");
			
			var _textFormat:TextField = componetContent.getTextField("_textFormat");
			
			if(_backgroundSkin)
			{
				this.backgroundSkin = _backgroundSkin;
			}
			
			if(_backgroundFocusedSkin)
			{
				this.backgroundFocusedSkin = _backgroundFocusedSkin;
			}
			
			if(_backgroundDisabledSkin)
			{
				this.backgroundDisabledSkin = _backgroundDisabledSkin;
			}
			
			if(_textFormat != null)
			{
				this.textEditorProperties.fontFamily = _textFormat.fontName;
				this.textEditorProperties.fontSize = _textFormat.fontSize;
				this.textEditorProperties.color = _textFormat.color;
				
				var textFormat:TextFormat = new TextFormat();
				textFormat.font = _textFormat.fontName;
				textFormat.size = _textFormat.fontSize;
				textFormat.color = _textFormat.color;
				
				this.promptProperties.textFormat = textFormat;
				this.prompt = _textFormat.text;
			}
			componetContent.removeFromParent(true);
		}
		
		public function get editableProperties():Object{
			return {
				prompt:prompt,
				displayAsPassword:displayAsPassword,
				maxChars:maxChars,
				isEditable:isEditable
			};
		}
		
		public function set editableProperties(properties:Object):void{
			for(var key:String in properties){
				this[key] = properties[key];
			}
		}
		
	}
}