package application.controls.proxy
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.media.Video;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import application.AppUI;
	import application.ui.MainUIPanel;
	
	import gframeWork.JT_IDisposable;
	import gframeWork.uiController.JT_UserInterfaceManager;

	/**
	 * 导入swf文件的相关处理,选择文件，刷新当前文件
	 * @author JiangTao
	 */	
	public class ImportSwfProxy implements JT_IDisposable
	{
		private const SWF:String = "*.swf";
		/*文件*/
		private var file:File;
		//文件加载
		private var fileLoad:Loader;		
		
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
		
		/**
		 * 刷新按钮处理 
		 * @param event
		 */		
		private function refreshClick(event:MouseEvent):void
		{
			
		}
		
		private function fileSelectHandler(event:Event):void
		{
			var loadComple:Function = function(event:Event):void
			{
				fileLoad.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadComple);
			};
			if(!fileLoad)  fileLoad = new Loader();
			fileLoad.contentLoaderInfo.addEventListener(Event.COMPLETE,loadComple);
			fileLoad.load(new URLRequest(file.url));
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