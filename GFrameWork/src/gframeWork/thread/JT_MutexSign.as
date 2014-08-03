/**
 *
 * 
 * 线程中的互斥量子
 *  
 */

package gframeWork.thread
{
	public class JT_MutexSign implements I_JT_Sign
	{
		
		private var mLock:Boolean = false;
		
		public function JT_MutexSign()
		{
						
		}
		
		public function lock():void
		{
			mLock = true;
		}
		
		public function unLock():void
		{
			mLock = false;			
		}
		
		/**
		 * 
		 * 返回当前信号是否被锁,
		 * @return
		 *  
		 */		
		public function canRun():Boolean
		{
			return !mLock;
		}
		
	}
}