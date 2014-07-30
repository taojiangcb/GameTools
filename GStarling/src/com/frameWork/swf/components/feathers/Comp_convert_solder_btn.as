package com.frameWork.swf.components.feathers
{
	import flash.text.TextFormat;
	
	import feathers.controls.Button;
	
	import lzm.starling.swf.components.ISwfComponent;
	import lzm.starling.swf.display.SwfSprite;
	
	import starling.display.DisplayObject;
	import starling.text.TextField;
	
	/**
	 * 转换兵种按钮 
	 * @author JiangTao
	 * 
	 */	
	public class Comp_convert_solder_btn extends Button implements ISwfComponent
	{
		public function Comp_convert_solder_btn()
		{
			super();
		}
		
		/**
		 * 初始化组件 
		 * @param componetContent	组件的基础显示内容
		 */	
		public function initialization(componetContent:SwfSprite):void
		{
			var _upSkin:DisplayObject = componetContent.getChildByName("upSkin");
			var _selectUpSkin:DisplayObject = componetContent.getChildByName("overSkin");
			var _downSkin:DisplayObject = componetContent.getChildByName("overSkin");
			var _disabledSkin:DisplayObject = componetContent.getChildByName("overSkin");
			var _selectDisabledSkin:DisplayObject = componetContent.getChildByName("overSkin");
			var _hoverSkin:DisplayObject = componetContent.getChildByName("overSkin")
			
			var _labelTextField:TextField = componetContent.getTextField("txtFormat");
			
			if(_upSkin) this.upSkin = _upSkin;
			if(_hoverSkin) this.hoverSkin = _hoverSkin;
			if(_selectUpSkin) this.defaultSelectedSkin = _selectUpSkin;
			if(_downSkin) this.downSkin = _downSkin;
			if(_disabledSkin) this.disabledSkin = _disabledSkin;
			if(_selectDisabledSkin) this.selectedDisabledSkin = _selectDisabledSkin;
			
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
			return {};
		}
		
		public function set editableProperties(properties:Object):void{
			for(var key:String in properties){
				this[key] = properties[key];
			}
		}
		
	}
}