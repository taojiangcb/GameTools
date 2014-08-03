/**
 *
 * 线程中的原子量子
 * 
 */
package gframeWork.thread
{
	public class JT_SemSign implements I_JT_Sign
	{
		
		private var mSem:int = 0;
		
		public function JT_SemSign()
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