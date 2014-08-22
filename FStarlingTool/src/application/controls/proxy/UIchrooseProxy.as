package application.controls.proxy
{
	import flash.events.Event;
	
	import spark.events.DropDownEvent;
	
	import application.AppUI;
	import application.STLConstant;
	import application.ui.MainUIPanel;
	import application.ui.RootStateUIPanel;
	
	import assets.Assets;
	
	import gframeWork.uiController.JT_UserInterfaceManager;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	
	import utils.SwfUtil;

	public class UIchrooseProxy
	{
		public function UIchrooseProxy()
		{
			internalInit();
		}
		
		private function internalInit():void
		{
			gui.s9DownList.addEventListener(DropDownEvent.CLOSE,onSelectS9ImageHandler,false,0,true);
			gui.shapeDownList.addEventListener(DropDownEvent.CLOSE,onSelectShapeImageHandler,false,0,true);
			gui.sprDownList.addEventListener(DropDownEvent.CLOSE,onSelectSprImageHandler,false,0,true);
			gui.compsDownList.addEventListener(DropDownEvent.CLOSE,compDownListImageHandler,false,0,true);
			gui.movieDownList.addEventListener(DropDownEvent.CLOSE,onSelectMovieImageHandler,false,0,true);
			gui.btnDownList.addEventListener(DropDownEvent.CLOSE,onSelectBtnImageHandler,false,0,true);
			gui.imageDownList.addEventListener(DropDownEvent.CLOSE,onSelectImage,false,0,true);
		}
		
		private function onSelectImage(event:Event):void
		{
			var libName:String = gui.imageDownList.selectedItem;
			var img:Image = Assets.swf.createImage(libName);
			addDisplayToStage(img);
		}
		
		private function onSelectS9ImageHandler(event:Event):void
		{
			
		}
		
		private function onSelectShapeImageHandler(event:Event):void
		{
			
		}
		
		private function onSelectSprImageHandler(event:Event):void
		{
			
		}
		
		private function compDownListImageHandler(event:Event):void
		{
			
		}
		
		private function onSelectMovieImageHandler(event:Event):void
		{
			
		}
		
		private function onSelectBtnImageHandler(event:Event):void
		{
			
		}
		
		private function addDisplayToStage(child:DisplayObject):void
		{
			removeStageAll();
			child.y = 300;
			STLConstant.currnetAppRoot.addChild(child);
		}
		
		private function removeStageAll():void
		{
			STLConstant.currnetAppRoot.removeChildren(0,-1,true);
		}
		
		private function get gui():MainUIPanel
		{
			return JT_UserInterfaceManager.getUIByID(AppUI.APP_UI_MAIN).getGui() as MainUIPanel;
		}
		
		private function get rootUI():RootStateUIPanel
		{
			return JT_UserInterfaceManager.getUIByID(AppUI.APP_ROOT_PANE).getGui() as RootStateUIPanel;
		}
	}
}