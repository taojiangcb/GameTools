package com.frameWork.swf.components.feathers
{
	import com.frameWork.swf.components.ISwfComponent;
	import com.frameWork.swf.display.SwfSprite;
	
	import flash.text.TextFormat;
	
	import feathers.controls.TextInput;
	
	import starling.display.DisplayObject;
	import starling.text.TextField;
	
	public class FeathersTextInput extends TextInput implements ISwfComponent
	{
		public function FeathersTextInput()
		{
			super();
		}
		
		public function initialization(componetContent:SwfSprite):void{
			var _backgroundSkin:DisplayObject = componetContent.getChildByName("_backgroundSkin");
			var _backgroundDisabledSkin:DisplayObject = componetContent.getChildByName("_backgroundDisabledSkin");
			var _backgroundFocusedSkin:DisplayObject = componetContent.getChildByName("_backgroundFocusedSkin");
			
			var _textFormat:TextField = componetContent.getTextField("_textFormat");
			
			if(_backgroundSkin)
			{
				_backgroundSkin.removeFromParent();
				this.backgroundSkin = _backgroundSkin;
			}
			if(_backgroundDisabledSkin)
			{
				_backgroundDisabledSkin.removeFromParent();
				this.backgroundDisabledSkin = _backgroundDisabledSkin;
			}
			if(_backgroundFocusedSkin)
			{
				_backgroundFocusedSkin.removeFromParent();
				this.backgroundFocusedSkin = _backgroundFocusedSkin;
			}
			
			if(_textFormat != null){
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