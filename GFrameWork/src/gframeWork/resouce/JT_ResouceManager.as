
package gframeWork.resouce
{
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	
	import gframeWork.JT_internal;
	
	import mx.resources.ResourceManager;

	use namespace JT_internal
	
	public class JT_ResouceManager
	{
		
		private static var mInstance:_ResourceManager
		
		/**
		 *
		 * 下载资源文件管理，如果碰到相同的文件加载会合并到同一个进程中处理。
		 *  
		 */
		public function JT_ResouceManager()
		{
			
		}
		
		/**
		 * 获取一个资源下载进程,如果当前下载进程已经存在则不会再去创建，如果不存在会创建一个新的下载进程。
		 * @param request
		 * @return 
		 * 
		 */		
		public static function getAssetsFile(request:URLRequest):JT_AssetsFileLoader
		{
			return instance.getAssetsFile(request);
		}
		
		/**
		 * 根据网络请求地址获取一个资源装载对像，如果资源相同则不会重复的构建筑装载对像。 
		 * @param request
		 * @return 
		 * 
		 */		
		public static function getAssetsLoader(request:URLRequest):JT_AssetsLoader
		{
			return instance.getAssetsLoader(request);
		}
		
		/**
		 * 销毁一个资源装对像 
		 * @param request
		 * 
		 */		
		public static function destoryAssetsLoader(request:URLRequest):void
		{
			return instance.destoryAssetsLoader(request);
		}
		
		/**
		 * 根据网络请求地址产生一个应用域所回，同一个地址只会产生一个应用域 
		 * @param request
		 * @return 
		 * 
		 */		
		public static function getAssetsDomain(request:URLRequest):ApplicationDomain
		{
			return instance.getAssetsDomain(request);
		}
		
		/**
		 * 清除一个下载进程，如果当前进程存在则会清除掉，如果下载进程不存则不会有任何处理。 
		 * @param request
		 * 
		 */		
		public static function clearAssets(request:URLRequest):void
		{
			return instance.clearAssets(request);
		}
		
		private static function get instance():_ResourceManager
		{
			if(mInstance == null)
			{
				mInstance = new _ResourceManager();
			}
			return mInstance;
		}
	}
}

import flash.events.Event;
import flash.net.URLRequest;
import flash.system.ApplicationDomain;
import flash.utils.Dictionary;
import flash.utils.setTimeout;

import gframeWork.JT_internal;
import gframeWork.resouce.JT_AssetsFileLoader;
import gframeWork.resouce.JT_AssetsLoader;

use namespace JT_internal;

class _ResourceManager
{
	
	/**
	 * 当前正在下载的资源缓充列表 
	 */	
	private var mCacheDict:Dictionary;
	
	/**
	 * 资源应用域缓充列表
	 */	
	private var mAssetsDomainDict:Dictionary;
	
	/**
	 * 资源应用装载器 
	 */	
	private var mAssetsLoaderDict:Dictionary;
	
	public function _ResourceManager():void
	{
		mCacheDict = new Dictionary();
		mAssetsDomainDict = new Dictionary();
		mAssetsLoaderDict = new Dictionary();
		
	}
	
	public function getAssetsFile(request:URLRequest):JT_AssetsFileLoader
	{
		if(request == null)
		{
			throw new ArgumentError("Parameters can't for empty!");
		}
		
		var url:String = request.url;
		
		if(mCacheDict[url])
		{
			return mCacheDict[url];
		}
		else
		{
			var assets:JT_AssetsFileLoader = new JT_AssetsFileLoader(request);
			assets.addEventListener(Event.COMPLETE,assetsLoadingComplete,false,0,true);
			mCacheDict[url] = assets;
			return assets;
		}
	}
	
	/**
	 * 获取资源装器 
	 * @param request
	 * @return 
	 * 
	 */	
	public function getAssetsLoader(request:URLRequest):JT_AssetsLoader
	{
		if(request == null)
		{
			throw new ArgumentError("Parameters can't for empty!");
		}
		
		var url:String = request.url;
		
		var assetsLoader:JT_AssetsLoader;
		
		if(mAssetsLoaderDict[url])
		{
			assetsLoader = mAssetsLoaderDict[url];
		}
		else
		{
			JT_AssetsLoader.internalCall = true;
			assetsLoader = new JT_AssetsLoader();
			JT_AssetsLoader.internalCall = false;
			mAssetsLoaderDict[url] = assetsLoader;
		}
		assetsLoader.mReferenceCount++;
		return assetsLoader;
	}
	
	public function destoryAssetsLoader(request:URLRequest):void
	{
		if(request == null)
		{
			throw new ArgumentError("Parameters can't for empty!");
		}
		
		var url:String = request.url;
		var assetsLoader:JT_AssetsLoader = mAssetsLoaderDict[url];
		
		if(assetsLoader)
		{
			assetsLoader.mReferenceCount--;
			if(assetsLoader.mReferenceCount == 0)
			{
				assetsLoader.unloadAndStop(false);
				delete mAssetsLoaderDict[url];
			}
		}
	}
	
	public function getAssetsDomain(request:URLRequest):ApplicationDomain
	{
		if(request == null)
		{
			throw new ArgumentError("Parameters can't for empty!");
		}
		
		var url:String = request.url;
		
		if(mAssetsDomainDict[url])
		{
			return mAssetsDomainDict[url];
		}
		else
		{
			var assetsDomain:ApplicationDomain = new ApplicationDomain();
			mAssetsDomainDict[url] = assetsDomain;
			return assetsDomain;
		}
	}
	
	private function assetsLoadingComplete(event:Event):void
	{
		var curAf:JT_AssetsFileLoader = event.currentTarget as JT_AssetsFileLoader;
		curAf.removeEventListener(Event.COMPLETE,assetsLoadingComplete);
		delete mCacheDict[curAf.fileUrl];
	}
	
	public function clearAssets(request:URLRequest):void
	{
		if(request == null)
		{
			throw new ArgumentError("Parameters can't for empty!");
		}
		
		var url:String = request.url;
		
		if(mCacheDict[url])
		{
			var assets:JT_AssetsFileLoader = mCacheDict[url] as JT_AssetsFileLoader;
			assets.removeEventListener(Event.COMPLETE,assetsLoadingComplete);
			assets.dispose();
			delete mCacheDict[url];
		}
	}
}