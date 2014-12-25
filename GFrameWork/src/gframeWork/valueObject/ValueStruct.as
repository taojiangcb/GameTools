
/**
 * 数据结构基层 
 */
package gframeWork.valueObject
{
	import gframeWork.utils.ObjectConvert;
	
	import mx.events.FlexEvent;

	public class ValueStruct implements IValueStruct
	{
		//-------------------------------------------
		//
		//		IIvalueObject
		//
		//--------------------------------------------
		/**
		 * 克隆数据复本 
		 * @return 
		 * 
		 */		
		public function clone():Object
		{
			return null;
		}
		/**
		 * 应用新的数据 
		 * @param data
		 * 
		 */		
		public function applyInfo(data:Object):void
		{
			if(data == null)
			{
				dispose();
			}
			else
			{
				var info:Object = ObjectConvert.classTargetToObject(data);
				var key:String = "";
				for(key in info)
				{
					this[key] = info[key];
				}
				info = null;
			}
		}
		
		/**
		 * 属性增量 
		 * @param data
		 * 
		 */		
		public function increase(data:Object):void
		{
			var info:Object = ObjectConvert.classTargetToObject(data);
			var key:String = "";
			for(key in info)
			{
				if(this[key] != null && typeof(this[key]) == "number")
				{
					this[key] += info[key];
				}
			}
			info = null;
		}
		
		/**
		 *　释放内存资源 
		 */		
		public function dispose():void
		{
			
		}
		
		/*减法*/
		public function decrease(data:Object):void
		{
			var info:Object = ObjectConvert.classTargetToObject(data);
			var key:String = "";
			for(key in info)
			{
				if(this[key] != null && typeof(this[key]) == "number")
				{
					this[key] -= info[key];
				}
			}
		}
		
		/*加法*/
		public function sum(data:Object):void
		{
			var info:Object = ObjectConvert.classTargetToObject(data);
			var key:String = "";
			for(key in info)
			{
				if(this[key] != null && typeof(this[key]) == "number")
				{
					this[key] += info[key];
				}
			}
		}
		
		public function toString():String
		{
			var obj:Object = ObjectConvert.classTargetToObject(this);
			var value:String = "";
			var key:String = "";
			for(key in obj)
			{
				value += key + ":" + obj[key] + ",";		
			}
			return value;
		}
		
	}
}