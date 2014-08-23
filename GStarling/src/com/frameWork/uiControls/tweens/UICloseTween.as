package com.frameWork.uiControls.tweens
{
	import com.gskinner.motion.GTween;
	import com.gskinner.motion.easing.Sine;
	
	import starling.display.DisplayObject;
	
	public class UICloseTween extends UITweens
	{
		public function UICloseTween(display:DisplayObject, dur:Number=1)
		{
			super(display, dur);
		}
		
		public override function play():void
		{
			if(gTween)
			{
				gTween.paused = true;
				gTween = null;
			}
			
			gTween = new GTween(uiTag,duration,{alpha:0},{ease:Sine.easeOut});
			gTween.onComplete = function(g:GTween):void
			{
				dispatchComplete();	
			}
		}
		
		public override function stop():void
		{
			if(gTween) gTween.paused = true;
		}
		
		public override function dispose():void
		{
			if(gTween)
			{
				gTween.paused = true;
				gTween = null;
			}
			super.dispose();
		}
	}
}