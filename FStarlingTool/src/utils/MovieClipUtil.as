package utils
{
	import application.comps.RootStage;
	
	import assets.Assets;
	
	import com.coffeebean.swf.typeData.FrameChildData;
	import com.coffeebean.swf.typeData.FrameLabelData;
	import com.coffeebean.swf.typeData.MovieClipData;
	import com.coffeebean.swf.typeData.SpriteData;
	import com.frameWork.swf.Swf;
	import com.netease.protobuf.Int64;
	
	import flash.display.DisplayObject;
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * movieclip分解
	 * @author zmliu
	 * 
	 */
	public class MovieClipUtil
	{
		public static function getMovieClipInfo(clazzName:String,clazz:Class):MovieClipData
		{
			var mc:MovieClip = new clazz();
			
			RootStage.tempContent.addChild(mc);
			
			//动画数据
			var movieData:MovieClipData = new MovieClipData();
			movieData.frameSize = mc.totalFrames;							//总帧数
			
			//子级的临时统计缓存
			var childs:Object = {};
			
			var i:int = 0;
			var len:int = 0;
			
			for (var j:int = 1; j <= movieData.frameSize; j++) 
			{
				mc.gotoAndStop(j);
				
				//所有帧信息
				var frameInfos:FrameChildData = new FrameChildData();
				
				var childSize:int = mc.numChildren;							//所有的子级数量
				//var childrenRoot:SpriteData = new SpriteData();   			//所有子级的信息
				var childInfo:SpriteData;								 	//当前子级的信息
				var child:DisplayObject;									//当前的子级
				var childClassName:String;									//当前子级名称
				var type:String;											//类型
				for (i = 0; i < childSize; i++) 
				{
					child = mc.getChildAt(i) as DisplayObject;
					childClassName = getQualifiedClassName(child);
					type = SwfUtil.getChildType(childClassName);
					
					//创建一个子级信息
					childInfo = new SpriteData();
					
					//组件类型
					if(type == null || type == Swf.dataKey_Componet)
					{
						continue;
					}
					//文本类型
					if(type == "text")
					{
						childClassName = type;
					}
					
					//统计子级的数量
					var nameIndex:int = movieData.childClassNames.indexOf(childClassName); 
					if(nameIndex == -1)
					{
						movieData.childClassNames.push(childClassName);		//子级对象类名称
						movieData.childClassNameCount.push(1);				//子级对象数量
					}
					else
					{
						movieData.childClassNameCount[nameIndex] += 1;		//数量累+
					}
					
					if(childs[childClassName])
					{
						if((childs[childClassName] as Array).indexOf(child) == -1)
							(childs[childClassName] as Array).push(child);
					}
					else
					{
						childs[childClassName] = [child];
					}
					
					childInfo.childClassName = childClassName;
					childInfo.type = type;
					childInfo.x = child.x * Util.swfScale;
					childInfo.y = child.y * Util.swfScale;
					childInfo.scaleX = child.scaleX;
					childInfo.scaleY = child.scaleY;
					childInfo.sketwX = MatrixUtil.getSkewX(child.transform.matrix);
					childInfo.sketwY = MatrixUtil.getSkewY(child.transform.matrix);
					childInfo.alpha = child.alpha;
					
					//单例唯一的
					if(child.name.indexOf("instance") == -1)
						childInfo.childName = child.name;
					else
						childInfo.childName = "";

					//使用自对象的下标
					childInfo.index = (childs[childClassName] as Array).indexOf(child);
					
					if(type == Swf.dataKey_Scale9 || type == Swf.dataKey_ShapeImg)
					{
						childInfo.width = Util.formatNumber(child.width * Util.swfScale);
						childInfo.height = Util.formatNumber(child.height * Util.swfScale);
					}
					else if(type == "text")
					{
						childInfo.width = (child as TextField).width;					//宽
						childInfo.height = (child as TextField).height;					//高
						childInfo.font = (child as TextField).defaultTextFormat.font;	//字体
						childInfo.color = (child as TextField).defaultTextFormat.color as uint;	//颜色
						childInfo.size = int((child as TextField).defaultTextFormat.size);	//大小
						childInfo.align = (child as TextField).defaultTextFormat.align;	//对齐
						childInfo.italic = Boolean((child as TextField).defaultTextFormat.italic);	//斜角
						childInfo.bold = Boolean((child as TextField).defaultTextFormat.bold);		//加粗
						childInfo.text = (child as TextField).text;
					}
					//加载入帧信息
					frameInfos.spriteChildsData.push(childInfo);
				}
				
				movieData.frames.push(frameInfos);
				//确定子级数量
				for(i = 0; i != movieData.childClassNames.length; i++)
				{
					childClassName = movieData.childClassNames[i];
					movieData.childClassNameCount[i] = childs[childClassName].length;
				}
			}
			
			i = 0;
			len = movieData.childClassNames.length;
			for(i = 0; i != len; i++)
			{
				var typeKey:String = SwfUtil.getChildType(movieData.childClassNames[i]);
				var exist:int = movieData.typeNames.indexOf(typeKey);
				if(exist == -1)
				{
					movieData.typeNames.push(typeKey);
					movieData.typeCount.push(1);
				}
				else
				{
					movieData.typeCount[exist] += 1;
				}
			}
			
			var frameLabels:Array = mc.currentLabels;			//所有的labels
			var labelSize:int = frameLabels.length;				
			var frameLabel:FrameLabelData;
			
			for (i = 0; i != labelSize; i++) 
			{
				frameLabel = new FrameLabelData();
				frameLabel.frame = frameLabels[i].frame;
				frameLabel.name = frameLabels[i].name;
				mc.gotoAndStop(frameLabel.name);
				movieData.labels.push(frameLabel);
				
				if(i > 0) //不是第一帧
				{
					movieData.labels[i-1].endFrame = frameLabel.frame - 2;
				}
				
				//最后一帧
				if(i == (labelSize-1))
				{
					movieData.labels[i].endFrame = mc.totalFrames-1;
				}
			}
			
			RootStage.tempContent.removeChild(mc);
			
			//是否循环
			movieData.loop = Assets.getTempData(clazzName) == null 
				? true 
				: Assets.getTempData(clazzName);
			
			return movieData;
		}
	}
}