package gframeWork.appDrag.utils
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import mx.core.FlexGlobals;
	
	import gframeWork.appDrag.AppDragMgr;

	public class DragBinds
	{
		
		private var bindTarget:DisplayObject;
		public var dragData:Object;
		private var dragMode:int = AppDragMgr.DRAG;
		private var pt:Point;
		private var spaceTime:int = 200;
		private var spaceId:int = 0;
		public function DragBinds() {
			
		}
		
		public function bind(tag:DisplayObject,data:Object,mode:int = AppDragMgr.DRAG):void {
			if(!tag) return;
			bindTarget = tag;
			dragData = data;
			bindTarget.addEventListener(MouseEvent.MOUSE_DOWN,downHandler,false,0,true);
			Stage(FlexGlobals.topLevelApplication.stage).addEventListener(MouseEvent.MOUSE_UP,upHandler,false,0,true);
		}
		
		private function downHandler(event:MouseEvent):void {
			pt = new Point(event.stageX,event.stageY);
			clearTimeout(spaceId);
			spaceId = setTimeout(spaceHandler,spaceTime);
		}
		
		private function upHandler(event:MouseEvent):void {
			clearTimeout(spaceId);
			spaceId = 0;
		}
		
		private function spaceHandler():void {
			AppDragMgr.clingyItem(bindTarget,dragData,null,dragMode);
		}
		
		public function dispose():void {
			clearTimeout(spaceId);
			spaceId = 0;
			Stage(FlexGlobals.topLevelApplication.stage).removeEventListener(MouseEvent.MOUSE_UP,upHandler);
			bindTarget.removeEventListener(MouseEvent.MOUSE_DOWN,downHandler);
		}
	}
}