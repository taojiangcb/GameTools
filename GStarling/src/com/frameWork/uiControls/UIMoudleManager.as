package com.frameWork.uiControls
{
	import flash.geom.Point;

	public class UIMoudleManager
	{
		private static var $instance:UIManager;
		
		public function UIMoudleManager() {}
		
		public static function registerUIMoudle(id:int,moudleCls:Class,uiCls:Class):void {
			instance.registerUIMoudle(id,moudleCls,uiCls);
		}
		
		public static function openUIByid(uiId:int,pt:Point = null,data:Object = null):int {
			return instance.openUIByid(uiId,pt,data);
		}
		
		public static function getUIMoudleById(id:int):UIMoudle {
			return instance.getUIMoudleById(id);
		}
		
		public static  function closeUIById(uiId:int):int {
			return instance.closeUIById(uiId);
		}
		
		private static function get instance():UIManager {
			if(!$instance) {
				$instance = new UIManager();
			}
			return $instance;
		}
	}
}
import com.frameWork.uiControls.UIConstant;
import com.frameWork.uiControls.UIMoudle;
import com.frameWork.utils.ssetInterval;

import flash.geom.Point;
import flash.system.System;
import flash.utils.Dictionary;

import starling.core.Starling;
import starling.display.DisplayObject;
import starling.utils.SystemUtil;

class UIManager
{
	/*注册的列表*/ // {uid:UICache}
	private var regMap:Dictionary;
	/*当前的ui列表*/  //{uid:UIMoudle}
	private var uiMap:Dictionary;
	/*开启的ui列表*/
	private var openList:Vector.<UIMoudle>;
	//gc列表记录每个ui的gc时间 {uid:gctime}
	private var gcMap:Dictionary;
	
	private var gcCheckId:int = 0;
	
	public function UIManager():void
	{
		uiMap 		= new Dictionary();
		regMap 		= new Dictionary();
		openList 	= new Vector.<UIMoudle>();
		gcMap 		= new Dictionary();
		
		const CHECK_TIME:int = 1000;
		/*每隔一秒检测一次gc列表，看看哪些模块是要被gc掉的。 */
		gcCheckId = ssetInterval(function():void{
			var clearList:Array = [];
			var key:String;
			for(key in gcMap)
			{
				var runTime:Number = Starling.juggler.elapsedTime;
				var gcTime:Number = gcMap[int(key)];
				if(runTime > gcTime) 
				{
					destoryUIMoudle(int(key));
					clearList.push(int(key))
				}
			}
			
			while(clearList.length > 0)
			{
				var uiId:int = clearList.shift();
				if(uiMap.hasOwnProperty(uiId)) delete uiMap[uiId];
				delete gcMap[uiId];
				if(clearList.length == 0)
				{
					System.gc();
				}
			}
		},CHECK_TIME);
		
	}
	
	/**
	 * 注册一个ui模块 
	 * @param id
	 * @param moudleCls
	 * @param uiCls
	 * 
	 */	
	public function registerUIMoudle(id:int,moudleCls:Class,uiCls:Class):void
	{
		if(!regMap.hasOwnProperty(id))
		{
			var cache:UICache = new UICache();
			cache.uiId = id;
			cache.moudleCls = moudleCls;
			cache.uiCls = uiCls;
			regMap[id] = cache;
		}
	}
	
	/**
	 * 根据一个id获取一个uiMoudle 
	 * @param id
	 * @return 
	 * 
	 */	
	public function getUIMoudleById(id:int):UIMoudle
	{
		if(uiMap.hasOwnProperty(id)) return uiMap[id];
		var uiCache:UICache = regMap[id];
		var uiMoudle:UIMoudle;
		var uiDisplay:DisplayObject;
		if(uiCache)
		{
			uiMoudle = new uiCache.moudleCls();
			uiDisplay = new uiCache.uiCls();
			uiMoudle.internalInit(uiDisplay);
			uiMap[id] = uiMoudle;
			return uiMoudle;
		}
		return null;
	}
	
	/**
	 * 开启某个ui模块，返回1开启成功，返回0开启失败 
	 * @param uiId
	 * @param pt
	 * @param data
	 * @return 
	 * 
	 */	
	public function openUIByid(uiId:int,pt:Point = null,data:Object = null):int
	{
		var uiMoudle:UIMoudle = getUIMoudleById(uiId);
		if(!uiMoudle) return 0;
		if(uiMoudle.uiState == UIConstant.OPEN)
		{
			if(uiMoudle.smartClose) uiMoudle.close();
			return 0;
		}
		
		//先清除gc标记
		if(gcMap.hasOwnProperty(uiId)) delete gcMap[uiId];
		uiMoudle.open(pt,data);
		openList.push(uiMoudle);
		return 1;
	}
	
	/**
	 * 关闭某个ui模块,返回1关闭成功，返回0关闭失败 
	 * @param uiId
	 * @return 
	 * 
	 */	
	public function closeUIById(uiId:int):int
	{
		var uiMoudle:UIMoudle = getUIMoudleById(uiId);
		if(!uiMoudle) return 0;
		if(uiMoudle.uiState == UIConstant.OPEN)
		{
			var findIndex:int = openList.indexOf(uiMoudle);
			openList.splice(findIndex,1);
			uiMoudle.close();
			if(uiMoudle.gcDelayTime > 0)
			{
				//gc标记的时间
				gcMap[uiId] = Starling.juggler.elapsedTime + uiMoudle.gcDelayTime;			
			}
			return 1;
		}
		return 0;
	}
	
	/**
	 * gc一个ui模块 
	 * @param uiId
	 */	
	private function destoryUIMoudle(uiId:int):void
	{
		var uiMoudle:UIMoudle = getUIMoudleById(uiId);
		if(!uiMoudle) return;
		var gcTime:Number = gcMap[uiId] ? gcMap[uiId] : 0;
		var nowRunTime:Number = Starling.juggler.elapsedTime;
		
		if(gcTime > nowRunTime && uiMoudle.uiState == UIConstant.HIDE)
		{
			uiMoudle.dispose();
		}
	}
}

class UICache
{
	public var uiId:int = 0;
	public var moudleCls:Class;
	public var uiCls:Class;
}