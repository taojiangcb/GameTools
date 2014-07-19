package com.pool
{
	import flash.utils.Dictionary;
	
	/**
	 * 对像创建缓充池,对像创建缓充管理 
	 * @author JT
	 * 
	 */	
	public class PoolMgr
	{
		/**
		 * 
		 */		
		private static var internalCall:Boolean = false;
		
		private static var mInstance:PoolMgr = null;
		
		private static const REF_COUNT:String = "refCount";
		
		public static function get instance():PoolMgr
		{
			if(!mInstance)
			{
				internalCall = true;
				mInstance = new PoolMgr();
				internalCall = false;
			}
			return mInstance;
		}
		
		/**
		 * 共享的poolDict 
		 */		
		private var poolDict:Dictionary;
		
		public function PoolMgr()
		{
			if(!internalCall)
			{
				throw new Error("Please call properties instance");
			}
			poolDict = new Dictionary(true);
		}
		
		/**
		 * 
		 * 获取一个缓中对像
		 * @param url
		 * 
		 */		
		public function getObjByUrl(url:String):Object
		{
			if(poolDict[url])
			{
				var obj:Object = poolDict[url];
				obj[REF_COUNT] = obj[REF_COUNT] + 1;
			}
			return poolDict[url];
		}
		
		/**
		 * 添加一个对像到缓冲池
		 * @param url
		 * @param textureObj
		 * 
		 */		
		public function addObjToPool(url:String,poolObj:Object):void
		{
			poolObj[REF_COUNT] = 1;
			poolDict[url] = poolObj;
		}
		
		/**
		 * 释放一个位图集,只有当引用数为0的时候才会真正的清除 
		 * @param url
		 * 
		 */		
		public function releasePool(url:String):void
		{
			if(poolDict[url])
			{
				var obj:Object = poolDict[url];
				obj[REF_COUNT] = Math.max(0,obj[REF_COUNT] - 1);
			}
		}
		
		/**
		 * 清除没有用的缓冲
		 * 
		 */		
		public function destoryDead():void
		{
			var clears:Array = [];
			var k:String;
			for (k in poolDict)
			{
				var obj:Object = poolDict[k];
				if(obj[REF_COUNT] == 0)
				{
					clears.push(k);
				}
			}
			
			while(clears.length > 0)
			{
				k = String(clears.shift());
				delete poolDict[k]; 
			}
		}
	}
}
