package com.frameWork.uiControls.tweens
{
	import com.frameWork.IDisable;
	import com.gskinner.motion.GTween;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.EventDispatcher;

	[Event(name="complete", type="starling.events.Event")]
	public class UITweens extends EventDispatcher implements IDisable
	{
		protected var uiTag:DisplayObject;
		protected var gTween:GTween;
		protected var duration:Number = 0;
		
		public function UITweens(display:DisplayObject,dur:Number = 1):void
		{
			uiTag = display;
			duration = dur;
		}
		
		public function play():void
		{
			
		}
		
		public function stop():void
		{
			
		}
		
		protected function dispatchComplete():void
		{
			if(hasEventListener(Event.COMPLETE))
			{
				dispatchEventWith(Event.COMPLETE);
			}
		}
		
		public function dispose():void
		{
			
		}
		
		
	}
}