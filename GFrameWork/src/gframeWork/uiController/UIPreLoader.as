/**
 *
 * 在打开UI之前先要下载相关的资源逻辑处理，例如在打开一个窗口的时候，可能选要预下载此窗口内相关的资源文件等等。
 * author:jiangtao;
 * version:1.0.0;
 * date:20120910
 *  
 */
package gframeWork.uiController
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	import gframeWork.resouce.AssetsFileLoader;
	import gframeWork.resouce.ResouceManager;
	
	import mx.utils.StringUtil;

	[event(name="complete",type="flash.events.Event")]
	public class UIPreLoader extends EventDispatcher
	{
		
		/**
		 * 
		 * 加载的资源文件列表
		 *  
		 */		
		private var mLoadList:Vector.<String>;
		
		/**
		 * 当前加载的资源文件列表 
		 */		
		private var mAssetsList:Vector.<AssetsFileLoader>;
		
		/**
		 * 标记是否正在清除中 
		 */		
		private var mClearingFag:Boolean = false;
		
		
		/**
		 * 当前下载的索引 
		 */		
		private var mCurIndex:int = 0;
		
		
		/**
		 * 
		 * 当前下载的资源
		 *  
		 */		
		protected var mCurAssets:AssetsFileLoader;
		
		
		public function UIPreLoader()
		{
			mLoadList = new Vector.<String>(); 
			mAssetsList = new Vector.<AssetsFileLoader>();
			registerToLoaded();
		}
		
		/**
		 * 
		 * 注册当前UI所需加载的资源,由子对像覆盖实现.
		 * 
		 * 
		 */		
		protected function registerToLoaded():void
		{
			
		}
		
		/**
		 * 
		 * 资源文件读取中的进度处理函数，由子对像覆盖实现。
		 * @param event
		 * 
		 * 
		 */		
		protected function loadProgress(event:ProgressEvent):void
		{
			
		}
		
		/**
		 * 
		 * 资源文件读取完成 
		 * @param event
		 * 
		 */		
		private function loadComponent(event:Event):void
		{
			if(mAssetsList.length > 0)
			{
				nextLoad();
			}
			else
			{
				onComplete();
				sotpAndClear();
				
				if(hasEventListener(Event.COMPLETE))
				{
					dispatchEvent(new Event(Event.COMPLETE));
				}
			}
		}
		
		/**
		 * 
		 * 资源文件读取失败 
		 * @param event
		 * 
		 */		
		private function loadError(event:IOErrorEvent):void
		{
			onFault(event);
		}
		
		
		private function nextLoad():void
		{
			if(mCurAssets)
			{
				mCurAssets.removeEventListener(Event.COMPLETE,loadComponent);
				mCurAssets.removeEventListener(IOErrorEvent.IO_ERROR,loadError);
				mCurAssets.removeEventListener(ProgressEvent.PROGRESS,loadProgress);
				mCurAssets.dispose();
				mCurAssets = null;
			}
			
			if(mAssetsList.length > 0)
			{
				mCurAssets = mAssetsList.shift();
			}
			
			if(mCurAssets)
			{
				mCurIndex++;
				onLoadChange();
				
				mCurAssets.addEventListener(Event.COMPLETE,loadComponent,false,0,true);
				mCurAssets.addEventListener(IOErrorEvent.IO_ERROR,loadError,false,0,true);
				mCurAssets.addEventListener(ProgressEvent.PROGRESS,loadProgress,false,0,true);
				mCurAssets.loader();
				
			}
		}
		
		/**
		 *
		 * 当下载的资源列表完成时处理,由子对像覆盖实现
		 * 
		 */		
		protected function onComplete():void
		{
			
		}
		
		/**
		 * 
		 * 当下载的资源失败时处理,由子对像覆盖实现
		 * 
		 */		
		protected function onFault(error:IOErrorEvent):void
		{
			
		}
		
		/**
		 * 
		 * 当下载的资源发生变更时的处理,由子对像覆盖实现
		 * 
		 */		
		protected function onLoadChange():void
		{
			
		}
		
		/**
		 *
		 * 开始下载当前指定的资源 
		 * 
		 */		
		public function beginLoad():void
		{
			if(!mClearingFag)
			{
				for(var i:int = 0; i < loadCount; i++)
				{
					mAssetsList.push(ResouceManager.getAssetsFile(new URLRequest(mLoadList[i])));
				}
				if(mAssetsList.length > 0)
				{
					nextLoad();
				}
			}
			else
			{
				throw new Error("please before here call stopClear() function delete previous content。");
			}
		}
		
		/**
		 * 
		 * 添加到源列表中 
		 * @param val
		 * 
		 */		
		public function appendToList(val:String):void
		{
			if(val == null  || StringUtil.trim(val).length == 0) return;
			if(!(mLoadList.indexOf(val) > -1))
			{
				mLoadList.push(val);
			}
		}
		
		/**
		 * 
		 * 暂停并且清除当前所下载的列表资源 
		 * 
		 */		
		public function sotpAndClear():void
		{
			mClearingFag = true;
			mCurIndex = 0;
			if(mCurAssets)
			{
				mCurAssets.removeEventListener(Event.COMPLETE,loadComponent);
				mCurAssets.removeEventListener(IOErrorEvent.IO_ERROR,loadError);
				mCurAssets.removeEventListener(ProgressEvent.PROGRESS,loadProgress);
				mCurAssets.dispose();
				mCurAssets = null;
			}
			
			if(mAssetsList)
			{
				while(mAssetsList.length > 0)
				{
					mAssetsList[0].removeEventListener(Event.COMPLETE,loadComponent);
					mAssetsList[0].removeEventListener(IOErrorEvent.IO_ERROR,loadError);
					mAssetsList[0].removeEventListener(ProgressEvent.PROGRESS,loadProgress);
					mAssetsList[0].dispose();
					mAssetsList.shift();
				}
			}
			
			if(mLoadList && mLoadList.length)
			{
				mLoadList.length = 0;	
			}
			mClearingFag = false;
		}
		
		public function dispose():void
		{
			sotpAndClear();
		}
		
		/**
		 * 
		 * 当前下载的资源列表 
		 * @return 
		 * 
		 */		
		public function get loadList():Vector.<String>
		{
			return mLoadList;
		}
		
		/**
		 * 当前下载的条数 
		 * @return 
		 * 
		 */		
		public function get loadIndex():int
		{
			return mCurIndex;
		}
		
		/**
		 * 总共的条数 
		 */		
		public function get loadCount():int
		{
			return loadList.length;
		}
	}
}