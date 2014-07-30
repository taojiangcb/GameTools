package application.controls
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.events.FlexEvent;
	
	import application.ui.MainUIPanel;
	
	import gframeWork.uiController.JT_MainUIControllerBase;
	
	public class MainUIControler extends JT_MainUIControllerBase
	{
		
		private var chrooseFile:ImportSwfProxy;
		
		public function MainUIControler()
		{
			super();
		}
		
		protected override function uiCreateComplete(event:FlexEvent):void
		{
			super.uiCreateComplete(event);
			chrooseFile = new ImportSwfProxy();
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