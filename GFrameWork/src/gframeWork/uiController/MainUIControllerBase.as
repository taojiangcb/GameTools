/**
 *
 * 
 * 一般主界面上的UI控制
 * 
 *  
 */
package gframeWork.uiController
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import gframeWork.FrameWork;
	import gframeWork.JT_internal;
	
	import mx.core.UIComponent;
	import mx.events.FlexEvent;

	use namespace JT_internal
	
	public class MainUIControllerBase extends UIControllerBase
	{
		public function MainUIControllerBase()
		{
			super();
			mDieTime = 5000;
		}
		
		public override function internalInit(gui:UIComponent):void
		{
			super.internalInit(gui);
		}
		
		public override function show(isPop:Boolean=false, point:Point=null):void
		{
			if(!mCanUse)
			{
				throw new Error("please call open function from JT_UserInterFaceManager");
				return;
			}
			
			if(isPop)
			{
				getRoot().addEventListener(MouseEvent.CLICK,validatePopupClick,false,0,true);				
			}
			
			if(point)
			{
				mGUI.move(point.x,point.y);
			}
			
			addToUiSpace();
			
			if(getGui().initialized)
			{
				openRefresh();
			}
		}
		
		/**
		 * 
		 * 打开时刷新方法，由子级覆盖现实 
		 * 
		 */		
		public function openRefresh():void
		{
			
		}
		
		protected override function uiCreateComplete(event:FlexEvent):void
		{
			super.uiCreateComplete(event);
			openRefresh();
		}
		
		public override function getSpace():UIComponent
		{
			return FrameWork.getInstance().mainUISpace;
		}
		
		
	}
}