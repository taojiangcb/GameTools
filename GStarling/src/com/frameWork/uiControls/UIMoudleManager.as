package com.frameWork.uiControls
{
	public class UIMoudleManager
	{
		public function UIMoudleManager()
		{
			
		}
	}
}
import com.frameWork.uiControls.UIMoudle;

import flash.utils.Dictionary;

import starling.display.DisplayObject;

class UIManager
{
	/*注册的列表*/
	private var regMap:Dictionary;
	/*当前的ui列表*/
	private var uiMap:Dictionary;
	/*开启的ui列表*/
	private var openList:Vector.<UIMoudle>;
	
	public function UIManager():void
	{
		uiMap = new Dictionary();
		regMap = new Dictionary();
		openList = new Vector.<UIMoudle>();
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
	public function getUIModelById(id:int):UIMoudle
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
}

class UICache
{
	public var uiId:int = 0;
	public var moudleCls:Class;
	public var uiCls:Class;
}