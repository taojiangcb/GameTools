/**
 * 
 * 线程
 * 
 */
package gframeWork.thread
{
	import gframeWork.JT_internal;
	
	use namespace JT_internal;
	
	public class FWThread
	{
		/**
		 * 线程执行的函数 
		 */		
		private var mFunc:Function = null;
		
		/**
		 * 线程执行的参数 
		 */		
		private var mParameters:Array = [];
		
		/**
		 * 当前线程的量子信号 
		 */		
		private var mSign:ISign = null;
		
		/**
		 * 是否正在执行中 
		 */		
		private var isRunFag:Boolean = false;
		
		public function FWThread(func:Function,parm:Array=null,sign:ISign=null)
		{
			mFunc = func;
			mParameters = parm;
			mSign = sign;
		}
		
		/**
		 * 添加到管理队列中 
		 */		
		public function into():void
		{
			FWThreadMgr.join(this);
		}
		
		/**
		 * 执行
		 */		
		public function execute():void
		{
			if(!isRunFag)
			{
				if(mSign)
				{
					if(!mSign.canRun()) return;
					isRunFag = true;
					mFunc.apply(null,mParameters);
					FWThreadMgr.threadEnd(this);
					
				}
				else
				{
					isRunFag = true;
					mFunc.apply(null,mParameters);
					FWThreadMgr.threadEnd(this);
				}
			}
		}
		
		/**
		 * 线程信号 
		 * @return
		 */		
		public function getSign():ISign
		{
			return mSign;
		}
		
	}
}