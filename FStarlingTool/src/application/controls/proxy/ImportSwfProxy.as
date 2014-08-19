package application.controls.proxy
{
	import com.frameWork.swf.Swf;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.media.Video;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.core.UIComponent;
	
	import application.AppUI;
	import application.ui.MainUIPanel;
	
	import assets.Assets;
	
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.ITextRenderer;
	
	import gframeWork.JT_IDisposable;
	import gframeWork.uiController.JT_UserInterfaceManager;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	import utils.ExportUtil;
	import utils.ImageUtil;
	import utils.MovieBatchUtil;
	import utils.SwfUtil;
	import utils.Util;

	/**
	 * 导入swf文件的相关处理,选择文件，刷新当前文件
	 * @author JiangTao
	 */	
	public class ImportSwfProxy implements JT_IDisposable
	{
		private const SWF:String = "*.swf";
		/*文件*/
		private var file:File;
		//文件加载
		private var fileLoad:Loader;		
		
		public function ImportSwfProxy()
		{
			internalInit();
		}
		
		private function internalInit():void
		{
			file = new File();
			file.addEventListener(Event.SELECT,fileSelectHandler,false,0,true);
			gui.btnFileSelect.addEventListener(MouseEvent.CLICK,chrooseClick,false,0,true);
			gui.btnFileRefresh.addEventListener(MouseEvent.CLICK,refreshClick,false,0,true);
		}
		
		private function chrooseClick(event:MouseEvent):void
		{
			file.browseForOpen("选择一个swf文件",[new FileFilter(SWF,SWF)]);
		}
		
		/**
		 * 刷新按钮处理 
		 * @param event
		 */		
		private function refreshClick(event:MouseEvent):void
		{
			Assets.openTempFile(file.url,onloadSwf);
		}
		
		private function onloadSwf():void
		{
			var loadComple:Function = function(event:Event):void
			{
				fileLoad.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadComple);
				gui.btnFileRefresh.enabled = true;
				analysisSWF();
			};
			if(!fileLoad)  fileLoad = new Loader();
			fileLoad.contentLoaderInfo.addEventListener(Event.COMPLETE,loadComple);
			fileLoad.load(new URLRequest(file.url));
		}
		
		private function fileSelectHandler(event:Event):void
		{
			Assets.openTempFile(file.url,onloadSwf);
		} 
		
		/**
		 * 解析swf文件 
		 */		
		private function analysisSWF():void
		{
			Util.swfScale = 1;
			var loaderinfo:LoaderInfo = fileLoad.contentLoaderInfo;
			Assets.init();
			Assets.swfUtil.parse(loaderinfo.content.loaderInfo.applicationDomain);
			Assets.swf = new Swf(Assets.swfUtil.getSwfData(),Assets.asset);
			//Assets.swf.swfData[Swf.dataKey_MovieBatchEffect]=Assets.swfUtil.effectDatas;
			var len:int = Assets.swfUtil.exportImages.length;
			var imageName:String;
			for (var i:int = 0; i < len; i++) 
			{
				imageName = Assets.swfUtil.exportImages[i];
				Assets.asset.addTexture(imageName,Texture.fromBitmapData(ImageUtil.getBitmapdata(Assets.swfUtil.getClass(imageName),1)));
			}
			len = Assets.swfUtil.typeData.imageNames.length;
			var exp:ExportUtil = new ExportUtil();
			exp.padding = 2;
			exp.isMerger = true;
			exp.exportScale = 1;
			exp.isMergerBigImage = true;
			for ( i = 0; i < len; i++) 
			{
				imageName = Assets.swfUtil.typeData.imageNames[i];
				var datarr:Array = exp.getbitmapdataXml(Assets.swfUtil,imageName,MovieBatchUtil.getMovieBatchImageNames(Assets.swfUtil.effectDatas[imageName]));
				var textureAtlas:TextureAtlas = new TextureAtlas(Texture.fromBitmapData(datarr[0]),datarr[1])
				Assets.asset.addTextureAtlas(imageName,textureAtlas);
			}
			
			if(Assets.swfUtil.typeData.imageNames.length > 0)
			{
				gui.imageDownList.dataProvider = new ArrayCollection(Assets.swfUtil.typeData.imageNames.concat().sort());
				gui.imageDownList.enabled = true;
			}
			else
			{
				gui.imageDownList.dataProvider = null;
				gui.imageDownList.enabled = false;
			}
			
			if(Assets.swfUtil.typeData.spriteNames.length > 0)
			{
				gui.sprDownList.dataProvider = new ArrayCollection(Assets.swfUtil.typeData.spriteNames.concat().sort());
				gui.sprDownList.enabled = true;
			}
			else
			{
				gui.sprDownList.dataProvider = null;
				gui.sprDownList.enabled = false;
			}
			
			if(Assets.swfUtil.typeData.buttonNames.length > 0)
			{
				gui.btnDownList.dataProvider = new ArrayCollection(Assets.swfUtil.typeData.spriteNames.concat().sort());
				gui.btnDownList.enabled = true;
			}
			else
			{
				gui.btnDownList.dataProvider = new ArrayCollection(Assets.swfUtil.typeData.spriteNames.concat().sort());
				gui.btnDownList.enabled = false;
			}
			
			if(Assets.swfUtil.typeData.s9Names.length > 0)
			{
				gui.btnDownList.dataProvider = new ArrayCollection(Assets.swfUtil.typeData.buttonNames.concat().sort());
				gui.btnDownList.enabled = true;
			}
			else
			{
				gui.btnDownList.dataProvider = null;
				gui.btnDownList.enabled = false;
			}
			if(Assets.swfUtil.typeData.shapeImgNames.length > 0)
			{
				gui.shapeDownList.dataProvider = new ArrayCollection(Assets.swfUtil.typeData.shapeImgNames.concat().sort());
				gui.shapeDownList.enabled = true;
			}
			else
			{
				gui.btnDownList.dataProvider = null;
				gui.btnDownList.enabled = false;
			}
			if(Assets.swfUtil.typeData.componentNames.length > 0)
			{
				gui.compsDownList.dataProvider = new ArrayCollection(Assets.swfUtil.typeData.componentNames.concat().sort());
				gui.compsDownList.enabled = true;
			}
			else
			{
				gui.compsDownList.dataProvider = null;
				gui.compsDownList.enabled = false;
			}
			
//			if(Assets.swfUtil.effectNames.length>0){
//				_batcheffectComboBox.items = Assets.swfUtil.effectNames
//				_batcheffectComboBox.enabled = true;
//			}else
//			{
//				_batcheffectComboBox.items = [];
//				_batcheffectComboBox.enabled = false;
//			}
		}
		
		public function dispose():void
		{
			if(fileLoad)
			{
				fileLoad.unloadAndStop();
				fileLoad = null;
			}
		}
		
		private function get gui():MainUIPanel
		{
			return JT_UserInterfaceManager.getUIByID(AppUI.APP_UI_MAIN).getGui() as MainUIPanel;
		}
	}
}