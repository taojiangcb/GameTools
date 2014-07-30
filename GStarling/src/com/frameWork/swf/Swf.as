package com.frameWork.swf
{
	import com.coffeebean.controls.components.MovieBatch;
	import com.coffeebean.swf.typeData.ImgData;
	import com.coffeebean.swf.typeData.MovieClipData;
	import com.coffeebean.swf.typeData.S9ImageData;
	import com.coffeebean.swf.typeData.SpriteData;
	import com.coffeebean.swf.typeData.TypeData;
	import com.frameWork.swf.SwfUpdateManager;
	import com.frameWork.swf.components.ComponentConfig;
	import com.frameWork.swf.components.ISwfComponent;
	import com.frameWork.swf.display.ShapeImage;
	import com.frameWork.swf.display.SwfMovieClip;
	import com.frameWork.swf.display.SwfQuadBatch;
	import com.frameWork.swf.display.SwfSprite;
	import com.frameWork.uiComponent.Button;
	import com.frameWork.utils.Clone;
	import com.frameWork.utils.Scale9BatchUtil;
	import com.gameabc.ipad.proto.movie.BatchVO;
	import com.gameabc.ipad.proto.movie.MovieBatchVO;
	import com.netease.protobuf.Message;
	
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	import starling.utils.AssetManager;
	
	
	/**
	 * 
	 * @author zmliu
	 * 
	 */
	public class Swf
	{
		public static const dataKey_Sprite:String 			= "spr";
		public static const dataKey_Image:String 				= "img";
		public static const dataKey_MovieClip:String 			= "mc";
		public static const dataKey_TextField:String 			= "text";
		public static const dataKey_Button:String 			= "btn";
		public static const dataKey_Scale9:String 			= "s9";
		public static const dataKey_ShapeImg:String 			= "shapeImg";
		public static const dataKey_Componet:String 			= "comp";
		public static const dataKey_MovieBatchEffect:String 	= "mbe";
		public static const dataKey_QuadBatch:String			= "qb";
		public static const ANGLE_TO_RADIAN:Number = Math.PI / 180;
		public static var starlingRoot:Sprite;
		
		public var textureSmoothing:String = TextureSmoothing.BILINEAR;
		
		private static var _isInit:Boolean = false;//是否已经初始化
		public static function init(starlingRoot:Sprite):void
		{
			if(_isInit) return;
			_isInit = true;
			Swf.starlingRoot = starlingRoot;
		}
		
		private const createFuns:Object = {
			"img":createImage,
			"spr":createSprite,
			"mc":createMovieClip,
			"text":createTextField,
			"btn":createButton,
			"s9":createS9Image,
			"shapeImg":createShapeImage,
			"comp":createComponent,
			"mbe":creatMoviceBatch,
			"qb":createQuadBatch
		};
		
		private var _assets:AssetManager;
		private var _swfDatas:TypeData;
		private var _swfUpdateManager:SwfUpdateManager;
		
		public function Swf(swfData:ByteArray,assets:AssetManager,fps:int=24)
		{
			if(!_isInit)
			{
				throw new Error("要使用Swf，请先调用Swf.init");
			}
			
			var bytes:ByteArray = Clone.clone(swfData);
			bytes.uncompress();
			
			this._swfDatas = new TypeData();
			_swfDatas.mergeFrom(bytes);
			
			this._assets = assets;
			this._swfUpdateManager = new SwfUpdateManager(fps,starlingRoot);
			
			bytes.clear();
		}
		
		/**
		 * swf数据
		 * */
		public function get swfData():TypeData
		{
			return _swfDatas;
		}
		
		/**
		 * 获取资源
		 * */
		public function get assets():AssetManager{
			return _assets;
		}
		
		/**
		 * 更新器
		 * */
		public function get swfUpdateManager():SwfUpdateManager
		{
			return _swfUpdateManager;
		}
		
		
		/**
		 * 设置/获取 帧频率
		 * */
		public function set fps(value:int):void
		{
			_swfUpdateManager.fps = value;
		}
		
		public function get fps():int
		{
			return _swfUpdateManager.fps;
		}
		
		/**
		 * 创建显示对象
		 * */
		public function createDisplayObject(className:String):DisplayObject
		{
			var childInfo:Message = getChildInfoByClassName(className);
			for(var k:String in createFuns)
			{
				if(_swfDatas[k] && childInfo)
				{
					var fun:Function = createFuns[k];
					return fun(className);
				}
			}
			return null;
		}
		
		/**
		 * 是否有某个Sprite
		 * */
		public function hasSprite(className:String):Boolean
		{
			return getChildInfoByClassName(className) ? true : false;
		}
		
		/**
		 * 创建sprite
		 * */
		public function createSprite(className:String,data:SpriteData = null,sprData:SpriteData = null):SwfSprite
		{
			if(sprData == null)
			{
				sprData = getChildInfoByClassName(className) as SpriteData;
			}
			
			var sprite:SwfSprite = new SwfSprite();
			var length:int = sprData.spriteChildsData.length;
			var objData:SpriteData;
			var display:Object;
			var fun:Function;
			
			for (var i:int = 0; i < length; i++) 
			{
				objData = sprData.spriteChildsData[i];													//当前的sprite数据
				fun = createFuns[objData.type];													//获取创建对像的方法
				display = fun(objData.childClassName,objData);									//创建一个子级对象
				display.name = objData.childName;												//元件名称
				if(display is DisplayObject)
				{
					display.x = objData.x;
					display.y = objData.y;
					
					if(objData.type != dataKey_Scale9 && objData.type != dataKey_ShapeImg)
					{
						display.scaleX = objData.scaleX;
						display.scaleY = objData.scaleY;
					}
					
					display.skewX = objData.sketwX * ANGLE_TO_RADIAN;
					display.skewY = objData.sketwY * ANGLE_TO_RADIAN;
					display.alpha = objData.alpha;
					sprite.addChild(display as DisplayObject);
				}
				else if(display is ISwfComponent)
				{
					sprite.addComponent(display as ISwfComponent);
				}
			}
			
			sprite.spriteName = className;
			sprite.data = data;
			sprite.spriteData = sprData;
			return sprite;
		}
		
		/**
		 * 是否有某个MovieClip
		 * */
		public function hasMovieClip(className:String):Boolean
		{
			return _swfDatas.movieClipNames.indexOf(className) > 0 ? true : false;
		}
		
		/**
		 * 创建movieclip
		 * */
		public function createMovieClip(className:String,data:Object=null):SwfMovieClip
		{
			//获取movieClip的数据信息
			var movieClipData:MovieClipData = getChildInfoByClassName(className) as MovieClipData;
			
			var displayObjects:Object = {};						//movieClip所有的显示子级
			var displayObjectArray:Array;						//当前子级的队列容器
			var type:String;									
			var count:int;										
			var fun:Function;
			var i:int = 0, j:int = 0;
			var len:int = movieClipData.childClassNames.length;//子级名称数量
			var childClassName:String = "";
			
			//创建当前所有子级
			for(i = 0; i != len; i++)
			{
				childClassName = movieClipData.childClassNames[i];				//当前子级名称
				type = getChildType(childClassName);							//当前子级类型
				count = movieClipData.childClassNameCount[i];					//当前子级数量
				fun = createFuns[type];											//确定子级的创建方法
				displayObjectArray = displayObjects[childClassName] == null ? [] : displayObjects[childClassName];
				for (j = 0; j != count; j++) 
				{
					//创建一个子级添加到队列中
					displayObjectArray.push(fun(childClassName,null));
				}
				
				//将队列添加组件集中
				displayObjects[childClassName] = displayObjectArray;
			}
			
			var mc:SwfMovieClip = new SwfMovieClip(movieClipData.frames,movieClipData.labels,displayObjects,this);
			mc.loop = movieClipData.loop;
			
			return mc;
		}
		
		/**
		 * 是否有某个Image
		 * */
		public function hasImage(className:String):Boolean
		{
			return getChildInfoByClassName(className) ? true : false;
		}
		
		/**
		 * 创建图片
		 * */
		public function createImage(className:String,data:Object = null):Image
		{
			var texture:Texture = _assets.getTexture(className);
			if(texture == null) throw new Error("Texture \"" + className +"\" not exist");
			var imageData:ImgData = getChildInfoByClassName(className)  as ImgData;
			var image:Image = new Image(texture);
			
			image.smoothing = textureSmoothing;
			
			image.pivotX = imageData.pivotX;
			image.pivotY = imageData.pivotY;
			return image;
		}
		
		/**
		 * 是否有某个Button
		 * */
		public function hasButton(className:String):Boolean
		{
			return getChildInfoByClassName(className) ? true : false;
		}
		
		/**
		 * 创建按钮
		 * */
		public function createButton(className:String,data:Object=null):Button
		{
			var sprData:SpriteData = getChildInfoByClassName(className) as SpriteData
			var skin:Sprite = createSprite(null,null,sprData);
			return new Button(skin);
		}
		
		/**
		 * 是否有某个S9Image
		 * */
		public function hasS9Image(className:String):Boolean
		{
			return getChildInfoByClassName(className) ? true : false;
		}
		
		/**
		 * 创建9宫格图片
		 * */
		public function createS9Image(className:String,data:Object = null):DisplayObject
		{
			var scale9Data:S9ImageData = getChildInfoByClassName(className) as S9ImageData;
			var texture:Texture = _assets.getTexture(className);
			var s9Texture:Scale9Textures = new Scale9Textures(texture,new Rectangle(scale9Data.x,scale9Data.y,scale9Data.width,scale9Data.height));
			var s9image:DisplayObject = null;
			if(data && SpriteData(data).isQuadBatch)
			{
				s9image = Scale9BatchUtil.getScale9Batch(s9Texture,data.width,data.height);
			}
			else
			{
				s9image = new Scale9Image(s9Texture,_assets.scaleFactor);
				if(data)
				{
					s9image.width = data.width;
					s9image.height = data.height;
				}
			}
			return s9image;
		}
		
		/**
		 * 是否有某个S9Image
		 * */
		public function hasShapeImage(className:String):Boolean
		{
			return getChildInfoByClassName(className) ? true : false;
		}
		
		/**
		 * 创建纹理填充图片
		 * */
		public function createShapeImage(className:String,data:Object = null):ShapeImage
		{
			var imageData:ImgData = getChildInfoByClassName(className) as ImgData;
			var shapeImage:ShapeImage = new ShapeImage(_assets.getTexture(className));
			if(data)
			{
				shapeImage.setSize(data.width,data.height);
			}
			return shapeImage;
		}
		
		public function createTextField(name:String,data:Object):TextField
		{
			var textfield:TextField = new TextField(2,2,"");
			if(data)
			{
				textfield.width = data.width;
				textfield.height = data.height;
				textfield.fontName = data.font;
				textfield.color = data.color;
				textfield.fontSize = data.size;
				textfield.hAlign = data.align;
				textfield.italic = data.italic;
				textfield.bold = data.bold;
				textfield.text = data.text;
			}
			return textfield;
		}
		
		/**
		 * 获取一个批量渲染动画
		 * @param name
		 * @param data
		 * @return 
		 */		
		public function creatMoviceBatch(name:String,data:BatchVO=null):MovieBatch
		{
			if(data==null)
			{
				if(_swfDatas[dataKey_MovieBatchEffect])
				{
					data = _swfDatas[dataKey_MovieBatchEffect][name] as BatchVO;
				}
			}
			if(data)
			{
				var vo:MovieBatchVO = new MovieBatchVO();
				vo.movieClipVO = data;
				vo.textureAtlas = _assets.getTextureAtlas(name);
				var batch:MovieBatch = new MovieBatch(vo,true);
				batch.loop = true;
			}
			return batch;
		}
		
		public function hasQuadBatch(className:String,data:Object = null):Boolean
		{
			return getChildInfoByClassName(className) ? true : false;
		}
		
		/**
		 * 创建一个QuadBatch 
		 * @param className
		 * @param data
		 * @return 
		 */		
		public function createQuadBatch(className:String,data:Object = null):SwfQuadBatch
		{
			var batchData:SpriteData = getChildInfoByClassName(className) as SpriteData;
			if(!batchData) return null;
			
			var quadBatch:SwfQuadBatch = new SwfQuadBatch();
			quadBatch.reset();
			
			var length:int = batchData.spriteChildsData.length;
			var objData:SpriteData;
			var display:Object;
			var fun:Function;
			trace("===========");
			for (var i:int = 0; i < length; i++) 
			{
				objData = batchData.spriteChildsData[i];													//当前的sprite数据
				fun = createFuns[objData.type];													//获取创建对像的方法
				display = fun(objData.childClassName,objData);									//创建一个子级对象
				display.name = objData.childName;												//元件名称
				display.x = objData.x;
				display.y = objData.y;
				if(objData.type != dataKey_Scale9 && objData.type != dataKey_ShapeImg)
				{
					display.scaleX = objData.scaleX;
					display.scaleY = objData.scaleY;
				}
				
				display.skewX = objData.sketwX * ANGLE_TO_RADIAN;
				display.skewY = objData.sketwY * ANGLE_TO_RADIAN;
				display.alpha = objData.alpha;
				quadBatch.addChild(display as DisplayObject);
				
				trace(objData.childClassName);
			}
			
			quadBatch.spriteName = className;
			quadBatch.data = batchData;
			quadBatch.spriteData = batchData;
			
			return quadBatch;
		}
		
		/**
		 * 是有有某个组件 
		 */		
		public function hasComponent(className:String):Boolean
		{
			return getChildInfoByClassName(className) ? true : false;
		}
		
		public function createComponent(className:String,data:SpriteData = null):*
		{
			var sprData:SpriteData = getChildInfoByClassName(className) as SpriteData;
			var conponentContnt:SwfSprite = createSprite(className,data,sprData);
			
			var componentClass:Class = ComponentConfig.getComponentClass(className);
			if(componentClass == null)
			{
				return conponentContnt;
			}
			
			var component:ISwfComponent = new componentClass();
			component.initialization(conponentContnt);
			
			if(data && data.compData != null && data.compData != "")
			{
				var compData:Object = JSON.parse(data.compData);
				component.editableProperties = compData;
			}
			return component;
		}
		
//		/**
//		 * 合并swf数据 
//		 * @param swfData	需要合并的数据
//		 * 
//		 */		
//		public function mergerSwfData(swfData:Object):void{
//			var typeKey:String;
//			var typeData:Object;
//			
//			var objectKey:String;
//			for(typeKey in swfData){
//				typeData = swfData[typeKey];
//				for(objectKey in typeData){
//					this._swfDatas[typeKey][objectKey] = typeData[objectKey];
//				}
//			}
//		}
		
//		/**
//		 * 合并swf数据 
//		 * @param mergerSwfDataBytes	需要合并的数据
//		 * 
//		 */		
//		public function mergerSwfDataBytes(swfDataBytes:ByteArray):void{
//			var bytes:ByteArray = Clone.clone(swfDataBytes);
//			bytes.uncompress();
//			
//			mergerSwfData(JSON.parse(new String(bytes)));
//			
//			bytes.clear();
//		}
		
		public function dispose(disposeAssets:Boolean):void
		{
			_swfUpdateManager.dispose();
			if(disposeAssets)
			{
				_assets.purge();
				_assets.dispose();
			}
			
			_assets = null;
			_swfDatas = null;
			_swfUpdateManager = null;
		}
		
		
		/**
		 * 根据连接名获来获取次源队列中的位置索引
		 * @param clazzName
		 * @return 
		 */		
		public function getClassIndex(clazzName:String):int
		{
			var type:String = getChildType(clazzName);
			switch(type)
			{
				case Swf.dataKey_Image:
					return _swfDatas.imageNames.indexOf(clazzName);
					break;
				case Swf.dataKey_Button:
					return _swfDatas.buttonNames.indexOf(clazzName);
					break;
				case Swf.dataKey_Componet:
					return _swfDatas.componentNames.indexOf(clazzName);
					break;
				case Swf.dataKey_MovieClip:
					return _swfDatas.movieClipNames.indexOf(clazzName);
					break;
				case Swf.dataKey_Scale9:
					return _swfDatas.s9Names.indexOf(clazzName);
					break;
				case Swf.dataKey_ShapeImg:
					return _swfDatas.shapeImgNames.indexOf(clazzName);
					break;
				case Swf.dataKey_Sprite:
					return _swfDatas.spriteNames.indexOf(clazzName);
					break;
				case Swf.dataKey_QuadBatch:
					return _swfDatas.quadBatchNames.indexOf(clazzName);
					break;
			}
			return 0;
		}
		
		/**
		 * 根据对象的连接名获取一个对象的实例 
		 * @param className
		 * @return 
		 * 
		 */		
		public function getChildInfoByClassName(className:String):Message
		{
			var type:String = getChildType(className);
			var childIndex:int = getClassIndex(className);
			switch(type)
			{
				case Swf.dataKey_Image:
					return _swfDatas.imageDatas[childIndex];
					break;
				case Swf.dataKey_Button:
					return _swfDatas.buttonDatas[childIndex];
					break;
				case Swf.dataKey_Componet:
					return _swfDatas.componentDatas[childIndex];
					break;
				case Swf.dataKey_MovieClip:
					return _swfDatas.movieClipDatas[childIndex];
					break;
				case Swf.dataKey_Scale9:
					return _swfDatas.s9Datas[childIndex];
					break;
				case Swf.dataKey_ShapeImg:
					return _swfDatas.shapeImgDatas[childIndex];
					break;
				case Swf.dataKey_Sprite:
					return _swfDatas.spriteDatas[childIndex];
					break;
				case Swf.dataKey_QuadBatch:
					return _swfDatas.quadBatchDatas[childIndex];
					break;
			}
			return null;
		}
		
		/**
		 * 返回子集类型
		 *
		 */
		public static function getChildType(className:String):String
		{
			var types:Array = ["img","spr","mc","btn","s9","bat","flash.text::TextField","text","btn","s9","shapeImg","comp","qb"];
			var types1:Array = ["img","spr","mc","btn","s9","bat","text","text","btn","s9","shapeImg","comp","qb"];
			var i:int = 0;
			var len:int = types.length;
			for (i=0; i != len; i++) 
			{
				if(className.indexOf(types[i]) == 0)
				{
					return types1[i];
				}
			}
			return null;
		}
	}
}