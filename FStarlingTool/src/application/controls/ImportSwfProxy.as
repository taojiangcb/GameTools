package application.controls
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.media.Video;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	
	import application.AppUI;
	import application.ui.MainUIPanel;
	
	import gframeWork.JT_IDisposable;
	import gframeWork.uiController.JT_UserInterfaceManager;

	/**
	 * 导入swf文件的相关处理,选择文件，刷新当前文件
	 * @author JiangTao
	 * 
	 */	
	public class ImportSwfProxy implements JT_IDisposable
	{
		
		private const SWF:String = "*.swf";
		
		private var file:File;
		private var fileStream:FileStream;
		
		public function ImportSwfProxy()
		{
			internalInit();
		}
		
		private function internalInit():void
		{
			file = new File();
			file.addEventListener(Event.SELECT,fileSelectHandler,false,0,true);
			gui.btnFileSelect.addEventListener(MouseEvent.CLICK,chrooseClick,false,0,true);
			gui.btnFileRefresh.addEventListener(MouseEvent.CLICK,refreshClick,false,0,true);
		}
		
		private function chrooseClick(event:MouseEvent):void
		{
			file.browseForOpen("选择一个swf文件",[new FileFilter(SWF,SWF)]);
		}
		
		private function refreshClick(event:MouseEvent):void
		{
			
		}
		
		private function fileSelectHandler(event:Event):void
		{
			trace(file.url);
			trace(file.nativePath);
			if(!fileStream) fileStream = new FileStream();
			fileStream.(file,FileMode.READ);
		} 
		
		private function get gui():MainUIPanel
		{
			return JT_UserInterfaceManager.getUIByID(AppUI.APP_UI_MAIN).getGui() as MainUIPanel;
		}
		
		public function dispose():void
		{
			
		}
	}
}