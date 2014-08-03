package gframeWork.events
{
	import flash.events.Event;
	
	public class JT_Event extends Event
	{

		/**
		 * 基础模块启动完成 
		 */		
		public static const START_UP_COMPLETE:String = "startUPComplete";
		
		/**
		 * 动画播放完成 
		 */		
		public static const MOVIE_COMPLETED:String = "movieCompleted";
		
		/**
		 * 动画播放停止 
		 */		
		public static const MOVIE_STOP:String = "movieStop";
		
		/**
		 * 播放动画 
		 */		
		public static const MOVIE_PLAYER:String = "moviePlayer";
		
		public function JT_Event(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}