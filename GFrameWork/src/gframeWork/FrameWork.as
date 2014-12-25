package gframeWork
{
	import com.gskinner.motion.plugins.MotionBlurPlugin;
	
	import flash.display.DisplayObject;
	
	import gframeWork.thread.FWThreadMgr;
	
	import mx.core.IUIComponent;
	import mx.core.UIComponent;

	public class FrameWork
	{
		
		private static var mInstance:FrameWork;
		
		private static var mInternalCall:Boolean = false;
		
		/**
		 * 窗口空间 
		 */		
		public var mWindowSpace:UIComponent;
		
		/**
		 * 主界面中的UI空间 
		 */		
		public var mainUISpace:UIComponent;
		
		
		public var mRoot:UIComponent;
		
		public function FrameWork()
		{
			if(!mInternalCall)
			{
				throw new Error("Can't instantiation");
			}
		}
		
		public static function getInstance():FrameWork
		{
			if(!mInstance)
			{
				mInternalCall = true;
				mInstance = new FrameWork();
				mInternalCall = false;
			}
			return mInstance;
		}
		
		public function setLayout(root:UIComponent,winLay:UIComponent,mainLay:UIComponent):void
		{
			MotionBlurPlugin.install();
			mRoot = root;
			mWindowSpace = winLay;
			mainUISpace = mainLay;
		}
		
	}
}