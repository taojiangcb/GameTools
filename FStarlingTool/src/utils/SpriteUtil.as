package utils
{
	import application.comps.RootStage;
	
	import assets.Assets;
	
	import com.coffeebean.swf.typeData.SpriteData;
	import com.frameWork.swf.Swf;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.utils.getQualifiedClassName;

	/**
	 * 分解Sprite对像
	 * @author zmliu
	 */
	public class SpriteUtil
	{
		public static function getSpriteInfo(clazzName:String,clazz:Class):SpriteData
		{
			var mc:MovieClip = new clazz();
			RootStage.tempContent.addChild(mc);
			
			//当前Sprite的根级其中包含了所有的子级信息
			var spriteRootData:SpriteData = new SpriteData();
			var childSize:int = mc.numChildren;					//子级数量
			var childInfo:SpriteData;							//子级信息
			var child:DisplayObject;							//当前子级
			var childClassName:String;							//当前子级的名称
			var type:String;
			var i:int = 0;
			
			var isQuadBatch:Boolean = false;
			type = SwfUtil.getChildType(clazzName);
			
			//如果是QuadBatch类型则标记为true，所有的子级都是Quadbatch
			if(type == Swf.dataKey_QuadBatch)
			{
				isQuadBatch = true;
			}
			
			for (i = 0; i != childSize; i++) 
			{
				child = mc.getChildAt(i) as DisplayObject;
				childClassName = getQualifiedClassName(child);
				type = SwfUtil.getChildType(childClassName);
				//如果未定义该类型的连接，则放弃当前，继续下一下对像。
				if(type == null) continue;
				
				childInfo = new SpriteData();
				childInfo.childClassName = childClassName; 					//完全限定类名。
				childInfo.ownerName = clazzName;
				childInfo.type = type; 										//类型
				childInfo.x = Util.formatNumber(child.x * Util.swfScale);	//x坐标
				childInfo.y = Util.formatNumber(child.y * Util.swfScale);	//y坐标
				childInfo.scaleX = child.scaleX;
				childInfo.scaleY = child.scaleY;
				childInfo.sketwX = MatrixUtil.getSkewX(child.transform.matrix);
				childInfo.sketwY = MatrixUtil.getSkewY(child.transform.matrix);
				childInfo.alpha = child.alpha;
				
				if(child.name.indexOf("instance") == -1)
				{
					childInfo.childName = child.name;
				}
				else
				{
					childInfo.childName = "";
				}
				//如果是9宫格和图片
				if(type == Swf.dataKey_Scale9 || type == Swf.dataKey_ShapeImg)
				{
					childInfo.width = Util.formatNumber(child.width * Util.swfScale);		//宽
					childInfo.height = Util.formatNumber(child.height * Util.swfScale);		//高
				}
				//如果是文本
				else if(type == Swf.dataKey_TextField)
				{
					childClassName = childInfo.childClassName = type;   									//修改名称为"text"
					childInfo.width = (child as TextField).width;								//宽
					childInfo.height = (child as TextField).height;								//高
					childInfo.font = (child as TextField).defaultTextFormat.font;				//字体
					childInfo.color = (child as TextField).defaultTextFormat.color as uint;		//颜色
					childInfo.size = int((child as TextField).defaultTextFormat.size);			//大小
					childInfo.align = (child as TextField).defaultTextFormat.align;				//对齐
					childInfo.italic = Boolean((child as TextField).defaultTextFormat.italic);	//斜角
					childInfo.bold = Boolean((child as TextField).defaultTextFormat.bold);		//加粗
					childInfo.text = (child as TextField).text;
				}
				//如果是组件
				else if(type == Swf.dataKey_Componet)
				{
					childInfo.compData = JSON.stringify(Assets.getTempData(clazzName + "-" + i + childClassName));
				}
				
				if(type == Swf.dataKey_QuadBatch || isQuadBatch)
				{
					childInfo.isQuadBatch = true;
				}
				
				spriteRootData.spriteChildsData.push(childInfo);
			}
			RootStage.tempContent.removeChild(mc);
			return spriteRootData;
		}
	}
}