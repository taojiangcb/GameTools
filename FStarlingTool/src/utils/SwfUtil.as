package utils
{
	import com.coffeebean.swf.typeData.SpriteData;
	import com.coffeebean.swf.typeData.TypeData;
	
	import flash.system.ApplicationDomain;
	import flash.utils.ByteArray;
	
	import lzm.starling.swf.Swf;

	/**
	 * SWF信息，swf文件导出时的主要操作，其中保存这各数类型的资源数据。 
	 * 
	 */	
	public class SwfUtil
	{
		
//		public static var instance:SwfUtil;
//		
//		public static function getInstance():SwfUtil
//		{
//			if(!instance)
//			{
//				instance = new SwfUtil();
//			}
//			return instance;
//		}
//		
//		public function SwfUtil():void
//		{
//			init();
//		}
		
		//数据
		public var typeData:TypeData;
		
		/** 需要导出的图片名字 */
		public var exportImages:Array = [];
		public var effectDatas:Object;
        public var effectNames:Array;
		
		/**swf的应用域*/
		private var _appDomain:ApplicationDomain;
		private function init():void
		{
			//数据
			typeData = new TypeData();
			exportImages = [];
			_appDomain = null;
            effectDatas = {};
            effectNames = [];
		}
		
		
		/**
		 * 分解 
		 * @param appDomain swf的应用域
		 */		
		public function parse(appDomain:ApplicationDomain):void
		{
			init();
			_appDomain = appDomain;
			//获取所有的连接类定义名
			var clazzKeys:Vector.<String> = _appDomain.getQualifiedDefinitionNames();
			var clazzName:String;
			var childType:String;
			var i:int = 0;
			var length:int = clazzKeys.length;
			for (i = 0; i != length; i++) 
			{
				clazzName = clazzKeys[i];						//完全定义名称
				childType = getChildType(clazzName);			//获取定义的类型
				//图片类型
				if(childType == Swf.dataKey_Image)
				{
					typeData.imageNames.push(clazzName);
					typeData.imageDatas.push(ImageUtil.getImageInfo(getClass(clazzName)));
				}
				//sprite 类型
				else if(childType == Swf.dataKey_Sprite)
				{
					typeData.spriteNames.push(clazzName);
					typeData.spriteDatas.push(SpriteUtil.getSpriteInfo(clazzName,getClass(clazzName)));
				}
					//quadBatch
				else if(childType == Swf.dataKey_QuadBatch)
				{
					typeData.quadBatchNames.push(clazzName);
					typeData.quadBatchDatas.push(SpriteUtil.getSpriteInfo(clazzName,getClass(clazzName)));
				}
				//movieClip类型
				else if(childType == Swf.dataKey_MovieClip)
				{
					typeData.movieClipNames.push(clazzName);
					typeData.movieClipDatas.push(MovieClipUtil.getMovieClipInfo(clazzName,getClass(clazzName)));
				}
				//按钮类型
				else if(childType == Swf.dataKey_Button)
				{
					typeData.buttonNames.push(clazzName);
					typeData.buttonDatas.push(SpriteUtil.getSpriteInfo(clazzName,getClass(clazzName)));
				}
				//9宫格
				else if(childType == Swf.dataKey_Scale9)
				{
					typeData.s9Names.push(clazzName);
					typeData.s9Datas.push(Scale9Util.getScale9Info(getClass(clazzName)));
				}
				//shape图片
				else if(childType == Swf.dataKey_ShapeImg)
				{
					typeData.shapeImgNames.push(clazzName);
					typeData.shapeImgDatas = [];
				}
				//组件
				else if(childType == Swf.dataKey_Componet)
				{
					typeData.componentNames.push(clazzName);
					typeData.componentDatas.push(SpriteUtil.getSpriteInfo(clazzName,getClass(clazzName)));
				}
				else if(childType == Swf.dataKey_MovieBatchEffect)
				{
					effectNames.push(clazzName);
					effectDatas[clazzName] = MovieBatchUtil.getMovieBatchInfo(clazzName,getClass(clazzName));
				}
			}
			exportImages = exportImages.concat(typeData.imageNames,typeData.s9Names,typeData.shapeImgNames);
		}
		
		/**
		 * 返回索引位置 
		 * @param clazzName
		 * @return 
		 */		
		public function getClassIndex(clazzName:String):int
		{
			var type:String = getChildType(clazzName);
			switch(type)
			{
				case Swf.dataKey_Image:
					return typeData.imageNames.indexOf(clazzName);
					break;
				case Swf.dataKey_Button:
					return typeData.buttonNames.indexOf(clazzName);
					break;
				case Swf.dataKey_Componet:
					return typeData.componentNames.indexOf(clazzName);
					break;
				case Swf.dataKey_MovieClip:
					return typeData.movieClipNames.indexOf(clazzName);
					break;
				case Swf.dataKey_Scale9:
					return typeData.s9Names.indexOf(clazzName);
					break;
				case Swf.dataKey_ShapeImg:
					return typeData.shapeImgNames.indexOf(clazzName);
					break;
				case Swf.dataKey_Sprite:
					return typeData.spriteNames.indexOf(clazzName);
					break;
				case Swf.dataKey_QuadBatch:
					return typeData.quadBatchNames.indexOf(clazzName);
					break;
			}
			return 0;
		}
		
		/**
		 * 获取资源类
		 * */
		public function getClass(clazzName:String):Class
		{
			return _appDomain.getDefinition(clazzName) as Class;
		}
		
		/**
		 * 获取swf数据
		 * */
		public function getSwfData():ByteArray
		{
			var swfData:ByteArray = new ByteArray();
			typeData.writeTo(swfData);
			swfData.compress();
			return swfData;
		}
		
		/**
		 * 返回子集类型
		 * */
		public static function getChildType(childName:String):String
		{
			var types:Array = 	["img","spr","mc","btn","s9","bat","flash.text::TextField",	"text","btn","s9","shapeImg","comp","mbe","qb"];//,"flash.display::Shape","flash.display::Bitmap"
			var types1:Array = 	["img","spr","mc","btn","s9","bat","text",						"text","btn","s9","shapeImg","comp","mbe","qb"];//,"img","img"
			var i:int = 0;
			var len:int = types.length;
			for (i=0; i != len; i++) 
			{
				if(childName.indexOf(types[i]) == 0)
				{
					return types1[i];
				}
			}
			return null;
		}
	}
}