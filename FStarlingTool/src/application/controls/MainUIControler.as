package application.controls
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.events.FlexEvent;
	
	import application.controls.proxy.ImportSwfProxy;
	import application.controls.proxy.UIchrooseProxy;
	import application.ui.MainUIPanel;
	
	import gframeWork.uiController.JT_MainUIControllerBase;
	
	public class MainUIControler extends JT_MainUIControllerBase
	{
		
		private var importFileProxy:ImportSwfProxy;
		
		private var uiOperation:UIchrooseProxy;
		
		public function MainUIControler()
		{
			super();
		}
		
		protected override function uiCreateComplete(event:FlexEvent):void
		{
			super.uiCreateComplete(event);
			importFileProxy = new ImportSwfProxy();
			uiOperation = new UIchrooseProxy();
		}
		
		private function listener():void
		{
			
		}
		
		public function get gui():MainUIPanel
		{
			return mGUI as MainUIPanel;
		}
	}
}