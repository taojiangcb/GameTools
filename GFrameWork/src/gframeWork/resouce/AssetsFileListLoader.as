package gframeWork.resouce
{
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	
	import gframeWork.IDisposable;
	import gframeWork.collection.HashTable;
	import gframeWork.url.URLFileReference;
	import gframeWork.utils.ObjectConvert;
	
	import mx.events.Request;
	import mx.utils.StringUtil;

	public class AssetsFileListLoader extends EventDispatcher implements IDisposable
	{
		
		/**
		 * 当前加载的列表 
		 */		
		private var mList:Vector.<AssetsFileLoader>;
		
		/**
		 * 列表的引导文件 
		 */		
		private var mProfile:URLFileReference;
		
		/**
		 * 引导文件的址址 
		 */		
		private var mProfileRequest:URLRequest;
		
		/**
		 * 加载列表完成的回调处理 
		 */		
		private var mCompleteHandler:Function;
		
		/**
		 * 加载列表失败的回调处理 
		 */		
		private var mFaultHandler:Function;
		
		/**
		 * 当前加载的进度处理 
		 */		
		private var mProgressHandler:Function;
		
		/**
		 * 域的地址
		 */		
		private var mClientDomain:String = "";
		
		/**
		 * 资源的版本 
		 */		
		private var mAssetVersion:String = "";
		
		/**
		 * 
		 * 当前下载到第几条
		 *  
		 */		
		private var mCurrentCount:uint = 0;
		
		/**
		 * 当前正在下载的资源 
		 */		
		private var mCurrentLoadAsset:AssetsFileLoader;
		
		
		[Event(name="change",type="flash.events.Event")]
		
		/**
		 *
		 * 按照资源清单文件下载网络资源
		 *  
		 */
		public function AssetsFileListLoader(profile:URLRequest=null)
		{
			mProfileRequest = profile;
			mList = new Vector.<AssetsFileLoader>();
		}
		
		/**
		 * 
		 * 按资源清单文件下载网络资源文件 
		 * @param clinetDoman						客户端地址域
		 * @param version							资源版本号
		 * @param request							资源列表清单
		 * @param completeHandler					下载完成后的回调函数
		 * @param faultHandler						下载失败后的回调函数
		 * @param progressHandler					下载中回调函数
		 * 
		 */		
		public function load( clinetDoman:String = "",
							 version:String = "",
							 request:URLRequest = null,
							 completeHandler:Function = null,
							 faultHandler:Function = null,
							 progressHandler:Function = null):void
			
		{
			mCompleteHandler = completeHandler;
			mFaultHandler = faultHandler;
			mProgressHandler = progressHandler; 
			
			if(request != null)
			{
				mProfileRequest = request;
			}
			
			if(mProfile)
			{
				mProfile.close();
				mProfile = null;
			}
			
			mProfile = new URLFileReference(mProfileRequest);
			mProfile.openFile(openProfileSucceed,openProfileFault,openProfileProgress);
			
		}
		
		private function openProfileSucceed(event:Event):void
		{
			var profile:String = String(mProfile.getFileStrem());
			
			var lines:Vector.<String> = ObjectConvert.profileToArray(profile);
			
			var assets:AssetsFileLoader = null;
			
			if(mList)
			{
				while(mList.length > 0)
				{
					assets = mList.shift();
					ResouceManager.clearAssets(new URLRequest(assets.fileUrl));
				}
			}
			
			while(lines.length > 0)
			{
				var url:String = StringUtil.substitute(lines.shift(),mClientDomain,mAssetVersion);
				var request:URLRequest = new URLRequest(url);
				
				//获取当前要下载的资源
				assets = ResouceManager.getAssetsFile(request);
				mList.push(assets);
			}
			
			mCurrentCount = 0;
			loadNextAssets();
			
		}
		
		private function openProfileFault(event:IOErrorEvent):void
		{
			throw new IOError(event.text);
		}
		
		private function openProfileProgress(event:ProgressEvent):void
		{
			if(mProgressHandler != null)
			{
				mProgressHandler(event);
			}
		}
		
		/**
		 * 
		 * 加载下条资源 
		 * 
		 */		
		private function loadNextAssets():void
		{
			mCurrentLoadAsset = mList.shift();
			listener();
			mCurrentLoadAsset.loader();
		}
		
		private function listener():void
		{
			if(mCurrentLoadAsset)
			{
				mCurrentLoadAsset.addEventListener(Event.COMPLETE,assetsComplete,false,0,true);
				mCurrentLoadAsset.addEventListener(IOErrorEvent.IO_ERROR,assetsIOErrorHandler,false,0,true);
				mCurrentLoadAsset.addEventListener(ProgressEvent.PROGRESS,assetsProgressHandler,false,0,true);
				mCurrentLoadAsset.addEventListener(SecurityErrorEvent.SECURITY_ERROR,assetsSecurityHandler,false,0,true);
			}
		}
		
		private function removeListener():void
		{
			if(mCurrentLoadAsset)
			{
				mCurrentLoadAsset.removeEventListener(Event.COMPLETE,assetsComplete);
				mCurrentLoadAsset.removeEventListener(IOErrorEvent.IO_ERROR,assetsIOErrorHandler);
				mCurrentLoadAsset.removeEventListener(ProgressEvent.PROGRESS,assetsProgressHandler);
				mCurrentLoadAsset.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,assetsSecurityHandler);
			}
		}
		
		private function assetsComplete(event:Event):void
		{
			mCurrentCount++;
			
			if(count == currentCount)
			{
				removeListener();
				mCurrentLoadAsset = null;
				if(mCompleteHandler != null)
				{
					mCompleteHandler(event);
				}
			}
			else
			{
				removeListener();
				mCurrentLoadAsset = null;
				loadNextAssets();
			}
			
			if(hasEventListener(Event.CHANGE))
			{
				dispatchEvent(new Event(Event.CHANGE));
			}
			
		}
		
		private function assetsIOErrorHandler(event:IOErrorEvent):void
		{
			
			if(mFaultHandler != null)
			{
				mFaultHandler(event);
			}
			else
			{
				throw new IOError(event.text);
				mCurrentCount++;
				removeListener();
				mCurrentLoadAsset = null;
				loadNextAssets();
			}
		}
		
		private function assetsProgressHandler(event:ProgressEvent):void
		{
			if(mProgressHandler != null)
			{
				mProgressHandler(event);
			}
		}
		
		private function assetsSecurityHandler(event:SecurityErrorEvent):void
		{
			
			throw new SecurityError(event.text);
			mCurrentCount++;
			removeListener();
			mCurrentLoadAsset = null;
			loadNextAssets();
		}
		
		public function setCompleteFun(fun:Function):void
		{
			mCompleteHandler = fun;
		}
		
		public function setFaultFun(fun:Function):void
		{
			mFaultHandler = fun;
		}
		
		public function setProgressFun(fun:Function):void
		{
			mProgressHandler = fun;
		}
		
		public function dispose():void
		{
			removeListener();
			mCurrentLoadAsset = null;
			
			if(mProfile)
			{
				mProfile.close();
				mProfile = null;
			}
			
			if(mList)
			{
				while(mList.length > 0)
				{
					var assets:AssetsFileLoader = mList.shift();
					ResouceManager.clearAssets(new URLRequest(assets.fileUrl));
				}
			}
		}
		
		public function get currentCount():uint
		{
			return mCurrentCount
		}
		
		/**
		 * 
		 * 当前下载的总条数 
		 * @return
		 *  
		 */		
		public function get count():uint
		{
			return mList.length;
		}
		
	}
}