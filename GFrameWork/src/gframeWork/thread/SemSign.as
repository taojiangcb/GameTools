/**
 *
 * 线程中的原子量子
 * 
 */
package gframeWork.thread
{
	public class SemSign implements ISign
	{
		
		private var mSem:int = 0;
		
		public function SemSign()
		{
			
		}
		
		public function semPost():void
		{
			mSem++;
		}
		
		public function semWath():void
		{
			mSem--;
		}
		
		public function canRun():Boolean
		{
			return mSem > 0;
		}
	}
}