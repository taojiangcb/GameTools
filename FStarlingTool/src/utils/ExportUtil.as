package utils
{
	import com.frameWork.utils.LSOManager;
	import com.gameabc.ipad.proto.movie.BatchVO;
	
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.PNGEncoderOptions;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.setTimeout;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * 导出处理 
	 */	
	public class ExportUtil
	{
		/*导出的文件列表*/
		private var _exportFiles:Array;
		/*缩放比率*/
		private var _exportScale:Number=1;
		/*是否合并*/
		private var _isMerger:Boolean;
		/*是否合并大图片*/
		private var _isMergerBigImage:Boolean;
		/*纹理间隔*/
		private var _padding:Number;
		/*导出的路径*/
		private var _exportPath:String;
		/*纹理集最大宽度*/
		private var _bigImageWidth:Number;
		/*纹理集最大高度*/
		private var _bigImageHeight:Number;
		
		private var _exportCount:int;
		
		public function get exportScale():Number
		{
			return _exportScale;
		}

		public function set exportScale(value:Number):void
		{
			_exportScale = value;
		}

		public function get padding():Number
		{
			return _padding;
		}

		public function set padding(value:Number):void
		{
			_padding = value;
		}

		public function get isMergerBigImage():Boolean
		{
			return _isMergerBigImage;
		}

		public function set isMergerBigImage(value:Boolean):void
		{
			_isMergerBigImage = value;
		}

		public function get isMerger():Boolean
		{
			return _isMerger;
		}

		public function set isMerger(value:Boolean):void
		{
			_isMerger = value;
		}

		private var _callBack:Function;
		
		
		/**
		 * 导出,解析swf文件，并且转换纹理贴图数据
		 * @param exportFiles		需要导出的文件
		 * @param exportScale		导出倍数
		 * @param isMerger			是否合并纹理
		 * @param isMergerBigImage	是否合并大图
		 * @param padding			纹理间距
		 * @param exportPath		导出地址
		 * @param bigImageWidth		大图宽
		 * @param bigImageHeight	大图高
		 * @param callBack			导出完毕的回掉
		 */		
		public function exportFiles(exportFiles:Array,
									exportScale:Number,
									isMerger:Boolean,
									isMergerBigImage:Boolean,
									padding:Number,exportPath:String,
									bigImageWidth:Number,
									bigImageHeight:Number,
									callBack:Function):void
		{
			_exportFiles = exportFiles;
			_exportScale = exportScale;
			_isMerger = isMerger;
			_isMergerBigImage = isMergerBigImage;
			_padding = padding;
			_exportPath = exportPath;
			_bigImageWidth = bigImageWidth;
			_bigImageHeight = bigImageHeight;
			_callBack = callBack;
			_exportCount = _exportFiles.length;
			loadSwf(_exportFiles.shift());
		}
		
		private function loadSwf(file:File):void
		{
			if(file == null)
			{
				_callBack();
				return;
			}
			
			//Loading.instance.text = "Export..." + (_exportCount - _exportFiles.length) + "/" +_exportCount;
			
			setTimeout(
				function():void
				{
					var loader:Loader = new Loader();
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadSwfComplete);
					loader.load(new URLRequest(file.url));
					var swfUtil:SwfUtil = new SwfUtil();
					
					function loadSwfComplete(e:Event):void
					{
						loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadSwfComplete);
						swfUtil.parse(loader.contentLoaderInfo.content.loaderInfo.applicationDomain);
						exportImages();
						loadSwf(_exportFiles.shift());
					}
				
					function exportImages():void
					{
						var swfName:String = file.name.split(".")[0];
						var mergerImageExportPath:String = _exportPath + "/" + swfName + "/";
						var imageExportPath:String = _exportPath + "/" + swfName + "/images/";
						var bigImageExportPath:String = _exportPath + "/" + swfName + "/big_images/";
						var dataExportPath:String = _exportPath + "/" + swfName + "/" + swfName + ".bytes";
						
						//保存swf数据
						saveSwfData(dataExportPath,swfUtil.getSwfData());
						var data:Array = getbitmapdataXml(swfUtil,swfName)
						if(data==null) return;
						//[textureAtlasBitmapData,xml,imageNames,bitmapdatas,bigImageNames,bigBitmapDatas]
						var textureAtlasBitmapData:BitmapData =  data[0];
						var xml:XML =  data[1];
						var imageNames:Array = data[2];						
						var bitmapdatas:Array = data[3];
						var bigImageNames:Array = data[4];
						var bigBitmapDatas:Array = data[5];
						if(_isMerger)
						{
							saveImage(mergerImageExportPath + swfName + ".png",textureAtlasBitmapData);																
							saveXml(mergerImageExportPath + swfName + ".xml",xml.toXMLString());
						}
						else
						{
							//小图导出
							var length:int = imageNames.length;
							for (var i:int = 0; i < length; i++)
							{
								saveImage(imageExportPath + imageNames[i] + ".png",bitmapdatas[i]);
							}
						}

						//大图导出
						length = bigImageNames.length;
						for (i = 0; i < length; i++) 
						{
							saveImage(bigImageExportPath + bigImageNames[i] + ".png",bigBitmapDatas[i]);
						}
						
						length = swfUtil.effectNames.length;		
//						padding = 2;
						isMerger = true;
//						exportScale = 1;
						isMergerBigImage = true;
						for ( i = 0; i < length; i++) 
						{
							var imageName:String = swfUtil.effectNames[i];
							var datarr:Array = getbitmapdataXml(swfUtil,imageName,MovieBatchUtil.getMovieBatchImageNames(swfUtil.effectDatas[imageName]));
							saveBzsgSkill(_exportPath+"/"+"bzsgeffect/",imageName,datarr,swfUtil.effectDatas[imageName])
						}
					}
				},30);
		}
		
		public function getbitmapdataXml(swfUtil:SwfUtil,swfName:String,names:Array=null):Array
		{
			var date:Array;
			var images:Array = swfUtil.exportImages;
			var length:int = images.length;
			if(length == 0)
			{
				return null;
			}
			
			var bitmapdata:BitmapData;
			var bitmapdatas:Array = [];
			var bigBitmapDatas:Array = [];
			
			var imageNames:Array = [];
			var bigImageNames:Array = [];
			var rectMap:Object = {};
			
			var i:int;
			for (i = 0; i < length; i++) 
			{
				if(names&&names.indexOf(images[i])==-1)
					continue;
				bitmapdata = ImageUtil.getBitmapdata(swfUtil.getClass(images[i]),_exportScale);
				if(_isMerger)
				{//合并纹理
					if(isBigImage(bitmapdata) && !_isMergerBigImage)
					{
						bigImageNames.push(images[i]);
						bigBitmapDatas.push(bitmapdata);
					}
					else
					{
						bitmapdatas.push(bitmapdata);
						imageNames.push(images[i]);
						rectMap[images[i]] = new Rectangle(0,0,bitmapdata.width,bitmapdata.height);
					}
				}
				else
				{//不合并
					if(isBigImage(bitmapdata))
					{
						bigImageNames.push(images[i]);
						bigBitmapDatas.push(bitmapdata);
					}
					else
					{
						imageNames.push(images[i]);
						bitmapdatas.push(bitmapdata);
					}
				}
			}
			//获取纹理贴图矩型信息
			var textureAtlasRect:Rectangle = TextureUtil.packTextures(0,_padding,rectMap);
			if(textureAtlasRect)
			{
				var textureAtlasBitmapData:BitmapData = new BitmapData(textureAtlasRect.width,textureAtlasRect.height,true,0);
				var xml:XML = <TextureAtlas />;
				var childXml:XML;
				var imageName:String;
				var imageRect:Rectangle;
				
				var tempRect:Rectangle = new Rectangle();
				var tempPoint:Point = new Point();
				
				length = imageNames.length;
				for (i = 0; i < length; i++) {
					imageName = imageNames[i];
					imageRect = rectMap[imageName];
					bitmapdata = bitmapdatas[i];
					
					tempRect.width = bitmapdata.width;
					tempRect.height = bitmapdata.height;
					tempPoint.x = imageRect.x;
					tempPoint.y = imageRect.y;
					
					childXml = <SubTexture />;
					childXml.@name = imageName;
					childXml.@x = tempPoint.x;
					childXml.@y = tempPoint.y;
					childXml.@width = tempRect.width;
					childXml.@height = tempRect.height;
					xml.appendChild(childXml);
					
					textureAtlasBitmapData.copyPixels(bitmapdata,tempRect,tempPoint);
				}
				xml.@imagePath = swfName + ".png";
			}
			date = [textureAtlasBitmapData,xml,imageNames,bitmapdatas,bigImageNames,bigBitmapDatas]
			return date;
		}
		//是否是大纹理
		private function isBigImage(bitmapdata:BitmapData):Boolean
		{
			if(bitmapdata.width > (_bigImageWidth * _exportScale) 
				&& bitmapdata.height > (_bigImageWidth * _exportScale))
			{
				return true;
			}
			return false;
		}
		
		//保存图片
		private function saveImage(path:String,bitmapdata:BitmapData):void
		{
			try
			{
				var bytes:ByteArray = bitmapdata.encode(new Rectangle(0,0,bitmapdata.width,bitmapdata.height),new PNGEncoderOptions());
				var file:File = new File(path);
				var fs:FileStream = new FileStream();
				fs.open(file,FileMode.WRITE);
				fs.writeBytes(bytes);
				fs.close();
			} 
			catch(error:Error) 
			{
				trace(path);
			}
		}
		//保存xml
		private function saveXml(path:String,data:String):void
		{
			var bytes:ByteArray = new ByteArray();
			bytes.writeMultiByte(data,"utf-8");
			var file:File = new File(path);
			var fs:FileStream = new FileStream();
			fs.open(file,FileMode.WRITE);
			fs.writeBytes(bytes);
			fs.close();
		}
		
		//保存swf数据
		private function saveSwfData(path:String,swfData:ByteArray):void
		{
			var file:File = new File(path);
			var fs:FileStream = new FileStream();
			fs.open(file,FileMode.WRITE);
			fs.writeBytes(swfData);
			fs.close();
			
			var swfName:String = file.name;
			
			var oldPcPath:String = LSOManager.get("oldPcPath");
			var oldIosPath:String = LSOManager.get("oldIosPath");
			if(oldPcPath)
			{
				file.url = oldPcPath + "/" +swfName;
				fs.open(file,FileMode.WRITE);
				fs.writeBytes(swfData);
				fs.close();
			}
			
			if(oldIosPath)
			{
				file.url = oldIosPath + "/" +swfName;
				fs.open(file,FileMode.WRITE);
				fs.writeBytes(swfData);
				fs.close();
			}
		}
		
		private function saveBzsgSkill(path:String,imageName:String,datarr:Array,vo:BatchVO):void
		{
				if(datarr==null) return;
				var textureAtlasBitmapData:BitmapData =  datarr[0];
				var xml:XML =  datarr[1];
				var imageNames:Array = datarr[2];						
				var bitmapdatas:Array = datarr[3];
				var bigImageNames:Array = datarr[4];
				var bigBitmapDatas:Array = datarr[5];
				var byt:ByteArray = new ByteArray()
				byt.writeInt(5);
				var str:String =xml.toString(); 				
				var by:ByteArray =new ByteArray		
				by.writeUTFBytes(str);
				by.position = 0;
				byt.writeInt(by.length);
				byt.writeBytes(by);	
				saveXml(path+imageName+".xml",str)
				by =  textureAtlasBitmapData.encode(new Rectangle(0,0,textureAtlasBitmapData.width,textureAtlasBitmapData.height),new PNGEncoderOptions());					
				by.position = 0;
				byt.writeInt(by.length);
				byt.writeBytes(by);
				saveImage(path+imageName+".png",textureAtlasBitmapData)
				by = new ByteArray();
				vo.writeTo(by)
				by.position = 0;
				byt.writeInt(by.length);
				byt.writeBytes(by);
				//				trace(byt.readUTFBytes(str.length));				
				var file:File = new File(path+imageName+".bzsg");
				var fsConfig:FileStream = new FileStream();
				fsConfig.open(file, FileMode.WRITE);				
				fsConfig.writeBytes(byt);
				fsConfig.close();
				for(var i:int = 0;i<imageNames.length;i++)
				{
					saveImage(path+imageName+"/"+imageNames[i]+".png",bitmapdatas[i])
				}
				for( i = 0;i<bigImageNames.length;i++)
				{
					saveImage(path+imageName+"/"+bigImageNames[i]+".png",bigBitmapDatas[i])
				}
//				trace(byt.length)
//				byt.compress();
//				trace('---'+byt.length)
			
		}
	}
}