/**
 * 
 * 线程
 * 
 */
package gframeWork.thread
{
	import gframeWork.JT_internal;
	
	use namespace JT_internal;
	
	public class JT_Thread
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
		private var mSign:I_JT_Sign = null;
		
		/**
		 * 是否正在执行中 
		 */		
		private var isRunFag:Boolean = false;
		
		public function JT_Thread(func:Function,parm:Array=null,sign:I_JT_Sign=null)
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
			JT_ThreadMgr.join(this);
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
					JT_ThreadMgr.threadEnd(this);
					
				}
				else
				{
					isRunFag = true;
					mFunc.apply(null,mParameters);
					JT_ThreadMgr.threadEnd(this);
				}
			}
		}
		
		/**
		 * 线程信号 
		 * @return
		 */		
		public function getSign():I_JT_Sign
		{
			return mSign;
		}
		
	}
}