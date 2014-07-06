package com.utils
{
	
	import flash.utils.Dictionary;
	
	import starling.animation.IAnimatable;
	import starling.core.Starling;

	internal class TimeoutUtils implements IAnimatable
	{
		
		/**
		 * 自增长ID 
		 */		
		private static var growhID:int = 0;
		
		/**
		 * 缓存 
		 */		
		private static var cache:Dictionary = new Dictionary();
		
		
		//==========================================================================
		
		/**
		 * 构建时的时间
		 */		
		private var initTime:Number = 0;
		
		/**
		 * 延迟执行的时间 
		 */		
		private var delayTime:Number = 0;
		
		/**
		 * 回调函数 
		 */		
		private var callBack:Function = null;
		
		/**
		 * 被执行的时间点 
		 */		
		private var runTime:Number = 0;
		
		/**
		 * 是否是间隙时间的标记 
		 */		
		public var isInterval:Boolean = false;

		
		public var id:int = 0;
		
		/**
		 * 回调时的参数 
		 */		
		private var paramters:Array = null;
		
		/**
		 * @param func  		回调的函数
		 * @param dTime			延迟的时间
		 * @param params		回调的参数
		 */		
		public function TimeoutUtils(func:Function,dTime:Number,params:Array)
		{
			if(Starling.juggler == null) return;
			initTime = Starling.juggler.elapsedTime;
			delayTime = dTime
			callBack = func;
			runTime = initTime + dTime / 1000;
			paramters = params;
			Starling.juggler.add(this);
		}
		
		/**
		 * 时间轴运行 
		 * @param time
		 */		
		public function advanceTime(time:Number):void
		{
			var newTime:Number = Starling.juggler.elapsedTime;
			if(newTime >= runTime)
			{
				if(isInterval)
				{
					runTime += delayTime / 1000;
					if(callBack != null)
					{
						callBack.apply(null,paramters);
					}
				}
				else
				{
					if(callBack != null)
					{
						callBack.apply(null,paramters);
					}
					Starling.juggler.remove(this);
					clearTimeOut(id);
				}
			}
		}
		
		public function dispose():void
		{
			Starling.juggler.remove(this);
			callBack = null;
			paramters = null;
		}
		
		/**
		 * 创建延迟时间处理
		 * @param func		
		 * @param dTime
		 * @param params
		 * @return  返回为0时创建不成功 
		 * 
		 */		
		public static function createTimeOut(func:Function,dTime:Number,params:Array):int
		{
			var id:int = ++growhID;
			if(func != null && dTime != 0)
			{
				var timeOut:TimeoutUtils = new TimeoutUtils(func,dTime,params);
				timeOut.id = id;
				cache[id] = timeOut;
			}
			else
			{
				return 0;
			}
			return id;
		}
		
		/**
		 * 创建间隔时间处理 
		 * @param func
		 * @param dTime
		 * @param params
		 * @return 
		 */		
		public static function createInterval(func:Function,dTime:Number,params:Array):int
		{
			var id:int = ++growhID;
			if(func != null && dTime != 0)
			{
				var timeOut:TimeoutUtils = new TimeoutUtils(func,dTime,params);
				timeOut.id = id;
				timeOut.isInterval = true;
				cache[id] = timeOut;
			}
			else
			{
				return 0;
			}
			return id;
		}
		
		public static function clearTimeOut(id:Number):void
		{
			if(cache[id])
			{
				cache[id].dispose();
				delete cache[id];
			}
		}
	}
}