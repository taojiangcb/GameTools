/**
 * 
 * 线程管理
 * 
 */
package gframeWork.thread
{
	import flash.utils.Dictionary;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import gframeWork.FrameWork;
	import gframeWork.JT_internal;
	
	use namespace JT_internal;

	public class FWThreadMgr
	{
		
		
		/**
		 * 信号
		 */		
		private static var mSignMap:Dictionary
		
		/**
		 * 每次运行间隔的时间 
		 */		
		private static var mCUPTime:Number = 0;
		
		private static var interID:uint = 0;
		
		public function FWThreadMgr()
		{
			
		}
		
		/**
		 * 
		 * 原子量子增1  
		 * @param sign
		 * 
		 */		
		public static function semPost(sign:SemSign):void
		{
			sign.semPost();
		}
		
		/**
		 * 原子量子减1 
		 * @param sign
		 * 
		 */		
		public static function semWait(sign:SemSign):void
		{
			sign.semWath();
		}
		/**
		 * 互斥量子锁 
		 * @param sign
		 * 
		 */		
		public static function mutexLock(sign:MutexSign):void
		{
			sign.lock();
		}
		
		/**
		 * 互斥量子解锁 
		 * @param sign
		 * 
		 */		
		public static function mutexUnLock(sign:MutexSign):void
		{
//			var threads:Vector.<JT_Thread> = getThreads(sign);
//			if(threads.length > 0)
//			{
//				threadEnd(threads[0]);
//			}
			sign.unLock();
		}
		
		/**
		 * 
		 * 删除一个量子组线程 
		 * @param sign
		 * @return 
		 * 
		 */		
		public static function destorySign(sign:ISign):void
		{
			
			if(mSignMap && mSignMap[sign])
			{
				delete mSignMap[sign];
			}
		}
		
		/**
		 * 获取当前信号的线程集 
		 * @param sign
		 * @return 
		 * 
		 */		
		public static function getThreads(sign:ISign):Vector.<FWThread>
		{
			return mSignMap[sign] as Vector.<FWThread>
		}
		
		/**
		 * 线程结束处理 
		 * @param thread
		 * 
		 */		
		JT_internal static function threadEnd(thread:FWThread):void
		{
			if(mSignMap[thread.getSign()])
			{
				var threadList:Vector.<FWThread> = mSignMap[thread.getSign()];
				if(threadList && threadList.length > 0)
				{
					var index:int = threadList.indexOf(thread);
					if(index > -1)
					{
						threadList.splice(index,1) as FWThread;
					}
				}
			}
		}
		
		JT_internal static function join(thread:FWThread):void
		{
			if(!mSignMap)
			{
				mSignMap = new Dictionary();
			}
			
			if(mSignMap[thread.getSign()])
			{
				mSignMap[thread.getSign()].push(thread);
			}
			else
			{
				mSignMap[thread.getSign()] = new Vector.<FWThread>();
				mSignMap[thread.getSign()].push(thread);
			}
			
			if(mCUPTime == 0)
			{
				mCUPTime = 1000 / 60;
			}
			
			clearInterval(interID);
			interID = setInterval(inetRun,mCUPTime);
			
		}
		
		
		/**
		 * 
		 * 线程开启处理 
		 * 
		 */		
		JT_internal static function inetRun():void
		{
			var count:uint = 5;
			var ths:Vector.<FWThread>;
			
			var canExe:Vector.<FWThread> = null;
			
			for each(ths in mSignMap)
			{
				if(ths)
				{
					for(var i:int = 0; i < ths.length; i++)
					{
						if(!canExe)
						{
							canExe = new Vector.<FWThread>();
						}
						canExe.push(ths[i]);
					}
				}
			}
			
			if(canExe)
			{
				while(canExe.length > 0)
				{
					canExe[0].execute();
					canExe.shift();
				}
			}
		}
	}
}
