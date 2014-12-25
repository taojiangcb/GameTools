
/**
 * 数据结构的接口 
 */
package gframeWork.valueObject
{
	public interface IValueStruct 
	{
		/**
		 * 克隆数据复本 
		 * @return 
		 */		
		function clone():Object;
		/**
		 * 应用新的数据 
		 * @param data
		 * 
		 */		
		function applyInfo(data:Object):void;
		/**
		 *　释放内存资源 
		 */		
		function dispose():void;
		/**
		 * 属性增量 
		 * @param data
		 * 
		 */		
		function increase(data:Object):void;
		
		function decrease(data:Object):void;
	}
}