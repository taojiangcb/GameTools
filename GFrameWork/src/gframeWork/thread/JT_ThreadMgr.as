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
	
	import gframeWork.JT_FrameWork;
	import gframeWork.JT_internal;
	
	use namespace JT_internal;

	public class JT_ThreadMgr
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
		
		public function JT_ThreadMgr()
		{
			
		}
		
		/**
		 * 
		 * 原子量子增1  
		 * @param sign
		 * 
		 */		
		public static function semPost(sign:JT_SemSign):void
		{
			sign.semPost();
		}
		
		/**
		 * 原子量子减1 
		 * @param sign
		 * 
		 */		
		public static function semWait(sign:JT_SemSign):void
		{
			sign.semWath();
		}
		/**
		 * 互斥量子锁 
		 * @param sign
		 * 
		 */		
		public static function mutexLock(sign:JT_MutexSign):void
		{
			sign.lock();
		}
		
		/**
		 * 互斥量子解锁 
		 * @param sign
		 * 
		 */		
		public static function mutexUnLock(sign:JT_MutexSign):void
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
		public static function destorySign(sign:I_JT_Sign):void
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
		public static function getThreads(sign:I_JT_Sign):Vector.<JT_Thread>
		{
			return mSignMap[sign] as Vector.<JT_Thread>
		}
		
		/**
		 * 线程结束处理 
		 * @param thread
		 * 
		 */		
		JT_internal static function threadEnd(thread:JT_Thread):void
		{
			if(mSignMap[thread.getSign()])
			{
				var threadList:Vector.<JT_Thread> = mSignMap[thread.getSign()];
				if(threadList && threadList.length > 0)
				{
					var index:int = threadList.indexOf(thread);
					if(index > -1)
					{
						threadList.splice(index,1) as JT_Thread;
					}
				}
			}
		}
		
		JT_internal static function join(thread:JT_Thread):void
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
				mSignMap[thread.getSign()] = new Vector.<JT_Thread>();
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
			var ths:Vector.<JT_Thread>;
			
			var canExe:Vector.<JT_Thread> = null;
			
			for each(ths in mSignMap)
			{
				if(ths)
				{
					for(var i:int = 0; i < ths.length; i++)
					{
						if(!canExe)
						{
							canExe = new Vector.<JT_Thread>();
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
