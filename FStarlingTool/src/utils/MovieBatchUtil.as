package utils
{
	import com.coffeebean.swf.typeData.ImgData;
	import com.gameabc.ipad.proto.movie.BatchFrameLabelVO;
	import com.gameabc.ipad.proto.movie.BatchFrameVO;
	import com.gameabc.ipad.proto.movie.BatchImageVO;
	import com.gameabc.ipad.proto.movie.BatchVO;
	
	import flash.display.DisplayObject;
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.utils.getQualifiedClassName;
	
	import lzm.starling.swf.Swf;
	import lzm.starling.swf.tool.Starup;
	import lzm.starling.swf.tool.asset.Assets;

	public class MovieBatchUtil
	{
		public function MovieBatchUtil()
		{
			
		}
		public static function getMovieBatchInfo(clazzName:String,clazz:Class):BatchVO{
			var mc:MovieClip = new clazz();
			
			Starup.tempContent.addChild(mc);
			
			//总帧数
			var frameSize:int = mc.totalFrames;
			//所有帧信息
			var frameInfos:Array = [];
			var objectCount:Object = {};
			var childs:Object = {};
			
			for (var j:int = 1; j <= frameSize; j++) 
			{
				mc.gotoAndStop(j);
				
				var childSize:int = mc.numChildren;			//所有的子级数量
				var childInfos:BatchFrameVO = new BatchFrameVO();					//所有子级的信息
				var childInfo:BatchImageVO;						//当前子级的信息
				var child:DisplayObject;					//当前的子级
				var childName:String;						//当前子级名称
				var type:String;							//类型
				var childCount:Object = {};
				
				for (var i:int = 0; i < childSize; i++) 
				{
					child = mc.getChildAt(i) as DisplayObject;
					childName = getQualifiedClassName(child);
					var imageinfo:ImgData = ImageUtil.getImageInfo(Assets.swfUtil.getClass(childName))
					type = SwfUtil.getChildType(childName);
					//组件类型
					if(type == null || type != Swf.dataKey_Image)
					{
						continue;
					}
					
					
//					if(childCount[childName])
//						childCount[childName] += 1;
//					else
//						childCount[childName] = 1;
//					
//					if(childs[childName])
//					{
//						if((childs[childName] as Array).indexOf(child) == -1)
//						{
//							(childs[childName] as Array).push(child);
//						}
//					}
//					else
//					{
//						childs[childName] = [child];
//					}
					
					//子级的详细信息
					childInfo =new BatchImageVO();
					childInfo.name = childName;
					childInfo.x = child.x ;
					childInfo.y = child.y;
					if(imageinfo.pivotX!=0)
					  childInfo.pivotX = imageinfo.pivotX;
					if(imageinfo.pivotY!=0)
					  childInfo.pivotY = imageinfo.pivotY;
					if(child.scaleX!=1)
					 childInfo.scaleX = child.scaleX;
					if(child.scaleY!=1)
					 childInfo.scaleY = child.scaleY;
					var skew:Number = MatrixUtil.getSkewX(child.transform.matrix)
					if(skew!=0)	
					 childInfo.skewX = skew;
					skew = MatrixUtil.getSkewY(child.transform.matrix)
					if(skew!=0)	
					 childInfo.skewY = skew;
					if(child.alpha!=1)
					 childInfo.alpha = child.alpha;
//						[
//						childName,
//						type,
//						child.x * Util.swfScale,
//						child.y * Util.swfScale,
//						child.scaleX,
//						child.scaleY,
//						MatrixUtil.getSkewX(child.transform.matrix),
//						MatrixUtil.getSkewY(child.transform.matrix),
//						child.alpha
//					];
					
//					//单例唯一的
//					if(child.name.indexOf("instance") == -1){
//						childInfo.push(child.name);
//					}else{
//						childInfo.push("");
//					}
					
					//使用自对象的下标
//					childInfo.push((childs[childName] as Array).indexOf(child));
//					
//					if(type == Swf.dataKey_Scale9 || type == Swf.dataKey_ShapeImg)
//					{
//						childInfo.push(Util.formatNumber(child.width * Util.swfScale));
//						childInfo.push(Util.formatNumber(child.height * Util.swfScale));
//					}
//					else if(type == "text")
//					{
//						childInfo.push((child as TextField).width);
//						childInfo.push((child as TextField).height);
//						childInfo.push((child as TextField).defaultTextFormat.font);
//						childInfo.push((child as TextField).defaultTextFormat.color);
//						childInfo.push((child as TextField).defaultTextFormat.size);
//						childInfo.push((child as TextField).defaultTextFormat.align);
//						childInfo.push((child as TextField).defaultTextFormat.italic);
//						childInfo.push((child as TextField).defaultTextFormat.bold);
//						childInfo.push((child as TextField).text);
//					}
//					
					//加入子级信息
					childInfos.image.push(childInfo);
				}
				
				//加载入帧信息
				frameInfos.push(childInfos);
				
//				for(childName in childCount)
//				{
//					objectCount[childName] = childs[childName].length;
//				}
			}
			
//			for(var key:String in objectCount)
//			{
//				objectCount[key] = [SwfUtil.getChildType(key),objectCount[key]];
//			}
			
			var frameLabels:Array = mc.currentLabels;			//所有的labels
			var labelSize:int = frameLabels.length;				
			
			var frameLabel:FrameLabel;
			var batchFrameLabel:BatchFrameLabelVO;
			var labels:Array = [];
			for (var k:int = 0; k < labelSize; k++) 
			{
				frameLabel = frameLabels[k];
				batchFrameLabel = new BatchFrameLabelVO();
				mc.gotoAndStop(frameLabel.name);
				batchFrameLabel.beginFrame = frameLabel.frame-1;
				batchFrameLabel.label = frameLabel.name
				labels.push(batchFrameLabel);
				if(k > 0) //不是第一帧
				{
					labels[k-1].endFrame = frameLabel.frame-2;
				}
				
				//最后一帧
				if(k == (labelSize-1))
				{
					batchFrameLabel.endFrame = mc.totalFrames-1;
				}
			}
			
			
		  var movieClipVO:BatchVO = new BatchVO();
		  movieClipVO.fps = 24;
		  movieClipVO.frames = frameInfos;
		  movieClipVO.scale = Util.swfScale.toString();
		  movieClipVO.frameLabels = labels;
		  Starup.tempContent.removeChild(mc);
			return movieClipVO;
//			{
//				frames:frameInfos,
//				labels:labels,
//				objCount:objectCount,
//				loop:((Assets.getTempData(clazzName) == null) ? true : Assets.getTempData(clazzName))
//			};
		}
		public static function getMovieBatchImageNames(movieClipVO:BatchVO):Array
		{
			var arr:Array = [];
			for(var i:int=0;i<movieClipVO.frames.length;i++)
			{
				var frameInfos:BatchFrameVO = movieClipVO.frames[i]
				for(var j:int=0;j<frameInfos.image.length;j++)
				{
					var imagevo:BatchImageVO = frameInfos.image[j];
					if(arr.indexOf(imagevo.name)==-1)
					{
						arr.push(imagevo.name);
					}
				}
			}
			return arr;
		}
	}
}