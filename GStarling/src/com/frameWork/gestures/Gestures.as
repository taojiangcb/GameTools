package com.frameWork.gestures
{
	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	/**
	 * 手势操作的基类 
	 * @author taojiang
	 * 
	 */	
	public class Gestures
	{
		protected var _target:DisplayObject;//目标
		protected var _callBack:Function;//回调
		
		public function Gestures(target:DisplayObject,callBack:Function=null)
		{
			_target = target;
			_callBack = callBack;
			_target.addEventListener(TouchEvent.TOUCH,onTouch);
		}
		
		public function set callBack(value:Function):void
		{
			_callBack = value;
		}
		
		public function get callBack():Function
		{
			return _callBack;
		}
		
		/**
		 * 检测手势
		 * */
		protected function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(_target);
			if(touch) checkGestures(touch);
			
			var touches:Vector.<Touch> = e.getTouches(_target);
			if(touches && touches.length > 0) checkGesturesByTouches(touches);
		}
		
		
		/**
		 * 检测手势
		 * */
		public function checkGestures(touch:Touch):void
		{
			
		}
		
		/**
		 * 检测手势
		 * */
		public function checkGesturesByTouches(touches:Vector.<Touch>):void
		{
			
		}
		
		public function dispose():void
		{
			if(_target) _target.removeEventListener(TouchEvent.TOUCH,onTouch);
			_target = null;
			_callBack = null;
		}
	}
}