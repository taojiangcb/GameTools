package com.frameWork.swf.components.feathers
{
	
	import com.frameWork.swf.components.ISwfComponent;
	import com.frameWork.swf.display.SwfSprite;
	
	import flash.text.TextFormat;
	
	import feathers.controls.Button;
	
	import starling.display.DisplayObject;
	import starling.text.TextField;
	
	public class comp_test_btn_1 extends Button implements ISwfComponent
	{
		public function comp_test_btn_1()
		{
			super();
		}
		
		public function initialization(componetContent:SwfSprite):void{
			var _upSkin:DisplayObject = componetContent.getSkinByName("_upSkin");
			var _selectUpSkin:DisplayObject = componetContent.getSkinByName("_upSkin");
			var _downSkin:DisplayObject = componetContent.getSkinByName("_overSkin");
			var _disabledSkin:DisplayObject = componetContent.getSkinByName("_overSkin");
			var _selectDisabledSkin:DisplayObject = componetContent.getSkinByName("_overSkin");
			
			var _labelTextField:TextField = componetContent.getTextField("_labelTextField");
			
			if(_upSkin)
			{
				defaultSkin = _upSkin;
			}
			
			if(_selectUpSkin) 
			{
				this.defaultSelectedSkin = _selectUpSkin;
			}
			if(_downSkin)
			{
				this.downSkin = _downSkin;
			}
			
			if(_disabledSkin)
			{
				this.disabledSkin = _disabledSkin;
			}
			
			if(_selectDisabledSkin) 
			{
				this.selectedDisabledSkin = _selectDisabledSkin;
			}
			
			if(_labelTextField)
			{
				var textFormat:TextFormat = new TextFormat();
				textFormat.font = _labelTextField.fontName;
				textFormat.size = _labelTextField.fontSize;
				textFormat.color = _labelTextField.color;
				textFormat.bold = _labelTextField.bold;
				textFormat.italic = _labelTextField.italic;
				
				this.defaultLabelProperties.textFormat = textFormat;
				this.label = _labelTextField.text;
			}
			
			componetContent.removeFromParent(true);
		}
		
		public function get editableProperties():Object{
			return {
				label:label,
				isEnabled:isEnabled
			};
		}
		
		public function set editableProperties(properties:Object):void{
			for(var key:String in properties){
				this[key] = properties[key];
			}
		}
	}
}