package com.frameWork.uiControls.tweens
{
	import com.gskinner.motion.GTween;
	import com.gskinner.motion.easing.Sine;
	
	import starling.display.DisplayObject;
	
	/**
	 * ui开启时的动画处理 
	 * @author taojiang
	 * 
	 */	
	public class UIOpenTween extends UITweens
	{
		
		public function UIOpenTween(display:DisplayObject, dur:Number=1)
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
			uiTag.alpha = 0;
			gTween = new GTween(uiTag,duration,{alpha:1},{ease:Sine.easeOut});
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