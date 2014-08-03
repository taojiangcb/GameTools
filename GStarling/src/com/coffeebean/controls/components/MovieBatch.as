package com.coffeebean.controls.components
{
	import com.coffeebean.swf.typeData.FrameLabelData;
	import com.gameabc.ipad.proto.movie.BatchFrameLabelVO;
	import com.gameabc.ipad.proto.movie.BatchFrameVO;
	import com.gameabc.ipad.proto.movie.BatchImageVO;
	import com.gameabc.ipad.proto.movie.BatchVO;
	import com.gameabc.ipad.proto.movie.MovieBatchVO;
	
	import starling.animation.IAnimatable;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.QuadBatch;
	import starling.textures.TextureAtlas;
	
	public class MovieBatch extends QuadBatch implements IAnimatable
	{
		public static const ANGLE_TO_RADIAN:Number = Math.PI / 180;
		private var mDefaultFrameDuration:Number;
		private var mTotalTime:Number=0.08;
		private var mCurrentTime:Number;
		private var mCurrentFrame:int;
		private var mStartFrame:int;
		private var mCurrentLabel:String;
		private var mEndFrame:int;
		private var mCurrentFrameVO:BatchFrameVO;
		private var mLoop:Boolean;
		private var mPlaying:Boolean;
		private var mtextureAtlas:TextureAtlas;
		private var mVO:BatchVO;
		protected var mIsComplete:Boolean;
		private var mdelayTime:Number=0;//延迟时间 秒
		private var mIsNext:Boolean;
		private var maddStarling:Boolean;
		
		public function MovieBatch(vo:MovieBatchVO,addStarling:Boolean=false)
		{
			super();
			mCurrentTime = 0;
			mStartFrame = mCurrentFrame = 0;			
			mVO = vo.movieClipVO;
			mEndFrame = mVO.frames.length
			if(mVO.fps!=0)
			mTotalTime = 1/mVO.fps
			mtextureAtlas = vo.textureAtlas
			if(mVO.hasScale)
			  this.scaleY = this.scaleX = Number(mVO.scale)
			setFrame();
			mIsNext = true;
			mPlaying = true;
			maddStarling = addStarling;
			if(addStarling)
			{
				Starling.juggler.add(this);
			}
		}

		

		public function advanceTime(passedTime:Number):void
		{
			
			if(!mPlaying)
				return;
			if(mdelayTime>0)
			{
				mdelayTime-=passedTime;
				if(mdelayTime<=0)
				{
					mdelayTime = 0;
					visible = true;
				}
			}else			  
			{
				mCurrentTime+=passedTime;
				if(mCurrentTime >= mTotalTime)
				{
					mCurrentTime -= mTotalTime //m_TimeSpan%m_RepeatTime;
					mCurrentFrame++;
					if(mCurrentFrame >= mEndFrame)
					{
						if(mLoop)
						  mCurrentFrame = mStartFrame;
						else
							stop();						
					}else
						setFrame();
					mIsNext = true;
				}else
					mIsNext = false;
			}
			
		}
		/**
		 *延迟播放时间 
		 * @param value
		 * 
		 */		
		public function set delayTime(value:Number):void
		{
			mdelayTime = value;
			if(value>0)
				visible = false;
		}
		
		public function get delayTime():Number
		{
			return mdelayTime;
		}
		public function play():void
		{
			mPlaying = true;
		}
		public function stop():void
		{
			mPlaying = false;
			mIsComplete = true;
			mCurrentFrame =  mVO.frames.length;
//			reset();
		}
		public function pasue():void
		{
			mPlaying = false;
		}
		public function gotoFrame(frame:*):void
		{
			mIsComplete = false;
			mPlaying = true;
			if(frame is String)
			{
				var label:BatchFrameLabelVO = getLabelVO(frame);				
				if(label)
				{
					mCurrentLabel = label.label;
					mCurrentFrame = mStartFrame = label.beginFrame;
					mEndFrame = label.endFrame;
				}
				
			}
			else if(frame is int)
			{
				mCurrentFrame = mStartFrame = frame;
				mEndFrame = mVO.frames.length;
			}
			mCurrentTime = 0;
			setFrame();
		}
		/**
		 * 根据帧标签来获取一个关建帧 
		 * @param label
		 * @return 
		 * 
		 */		
		private function getLabelVO(label:String):BatchFrameLabelVO
		{
			var length:int = mVO.frameLabels.length;
			var labelVO:BatchFrameLabelVO;
			for (var i:int = 0; i < length; i++) 
			{
				labelVO = mVO.frameLabels[i];
				if(labelVO.label == label)
				{
					return labelVO;
				}
			}
			return null;
		}
		/**
		 *是否跳到下一帧 
		 * @return 
		 * 
		 */		
		public function get isNext():Boolean
		{
			return mIsNext;
		}
		public function set loop(value:Boolean):void
		{
			mLoop = value;
		}
		public function get loop():Boolean
		{
			return mLoop;
		}
		public function get isComplete():Boolean 
		{
			return mIsComplete;
		}
		public function get currentLabel():String
		{
			return mCurrentLabel;
		}
		public function get currentFrameVO():BatchFrameVO
		{
			return mCurrentFrameVO;
		}
		public function get batchVO():BatchVO
		{
			return mVO;
		}
		private function setFrame():void
		{
			this.reset();
			
			mCurrentFrameVO = mVO.frames[mCurrentFrame]
			var len:int = mCurrentFrameVO.image.length;
			
			
			for(var i:int = 0;i<len;i++)
			{
				var imagevo:BatchImageVO = mCurrentFrameVO.image[i]
				if(imagevo.hasAlpha&&propertyTovalue("alpha",imagevo.alpha)!=1)
				{
//					var image:Image = new Image(Texture.fromTexture(mtextureAtlas.texture,new Rectangle(0, 0, 1, 1), null, false));
					addQuad(new Quad(1,1),0.1,mtextureAtlas.texture);
//					addImage(image);
					break;
				}
			}
			var image:Image  = new Image(mtextureAtlas.texture)
			for(i = 0;i<len;i++)
			{
				imagevo = mCurrentFrameVO.image[i]
//				var image:Image  = new Image(mtextureAtlas.getTexture(imagevo.name))
				image.texture = mtextureAtlas.getTexture(imagevo.name);
				image.readjustSize();
				setImageproperty(image,imagevo,true)	
				addImage(image);
			}
		    
		}
		override public function dispose():void
		{
			super.dispose();
			if(maddStarling)
				Starling.juggler.remove(this);
		}
		/**
		 * 
		 * @param image
		 * @param vo
		 * @param setdefault 是否设置默认值
		 * 
		 */		
		public static function setImageproperty(image:Image,vo:BatchImageVO,setdefault:Boolean = false):void
		{
			if(vo.hasHeight)
				image.height = propertyTovalue("height",vo.height)
			else if(setdefault)
				image.height = image.texture.height;
			if(vo.hasWidth)
				image.width = propertyTovalue("width",vo.width)
			else if(setdefault)
				image.width = image.texture.width;
			if(vo.hasAlpha)
				image.alpha = propertyTovalue("alpha",vo.alpha)
			else if(setdefault)
				image.alpha = 1;
			if(vo.hasPivotX)
				image.pivotX = propertyTovalue("pivotX",vo.pivotX)
			else if(setdefault)
				image.pivotX = 0
			if(vo.hasPivotY)
				image.pivotY = propertyTovalue("pivotY",vo.pivotY)
			else if(setdefault)
				image.pivotY = 0;
			if(vo.hasScaleX)
				image.scaleX = propertyTovalue("scaleX",vo.scaleX)
			else if(setdefault)
				image.scaleX = 1
			if(vo.hasScaleY)
				image.scaleY = propertyTovalue("scaleY",vo.scaleY)
			else if(setdefault)
			    image.scaleY =	1
			if(vo.hasSkewX)
				image.skewX = propertyTovalue("skewX",vo.skewX)
			else if(setdefault)
				image.skewX =0
			if(vo.hasSkewY)
				image.skewY = propertyTovalue("skewY",vo.skewY)
			else if(setdefault)
				image.skewY = 0
			if(vo.hasRotation)
				image.rotation = propertyTovalue("rotation",vo.rotation)
			else  if(setdefault)
				image.rotation = 0;
//			if(vo.hasColor)
//				image.color = propertyTovalue("color",vo.color)
		
			if(vo.hasX)
				image.x = propertyTovalue("x",vo.x)
			if(vo.hasY)
				image.y = propertyTovalue("y",vo.y)
			
		}
		public static function propertyTovalue(property:String,value:*):Number
		{
			switch (property)
			{
				
//				case "alpha":// 2;//透明度 /100 0-100					
//				case "scaleX"://10;//显示对象水平方向的缩放参数。 '1' 表示没有缩放, 负值在缩放的同时会翻转对象。 
//				case "scaleY"://11;//显示对象垂直方向的缩放参数。 '1' 表示没有缩放, 负值在缩放的同时会翻转对象。					
//				case "rotation"://14;//显示对象的旋转弧度。 /100 0-100	
//				case "x"://=6;
//				case "y"://=7;
//				case "pivotX"://8;//显示对象在自己的坐标系的起始x坐标（默认：0） 
//				case "pivotY"://9;//显示对象在自己的坐标系的起始y坐标（默认：0）
//					return 	Number(value)
//					break;
				case "skewX"://12;//显示对象水平方向的倾斜弧度。
				case "skewY"://13;//显示对象垂直方向的倾斜弧度。
					return 	Number(value)* ANGLE_TO_RADIAN;
					break;				
				case "color"://	=3;//四边形的颜色，如果四边形存在多个颜色，返回第一个顶点的颜色
				case "height":// =4;//图片高
				case "width":// =5;//图片宽
				case "alpha":// 2;//透明度 /100 0-100					
				case "scaleX"://10;//显示对象水平方向的缩放参数。 '1' 表示没有缩放, 负值在缩放的同时会翻转对象。 
				case "scaleY"://11;//显示对象垂直方向的缩放参数。 '1' 表示没有缩放, 负值在缩放的同时会翻转对象。					
				case "rotation"://14;//显示对象的旋转弧度。 /100 0-100	
				case "x"://=6;
				case "y"://=7;
				case "pivotX"://8;//显示对象在自己的坐标系的起始x坐标（默认：0） 
				case "pivotY"://9;//显示对象在自己的坐标系的起始y坐标（默认：0）
					return 	value;
				break	;
				
			}
			return NaN;
		}
		public static function clearProperty(vo:BatchImageVO,property:String):void
		{
			switch (property)
			{
				
				case "alpha":// 2;//透明度 /100 0-100
					vo.clearAlpha();
					break;
				case "scaleX"://10;//显示对象水平方向的缩放参数。 '1' 表示没有缩放, 负值在缩放的同时会翻转对象。 
					vo.clearScaleX()
					break;
				case "scaleY"://11;//显示对象垂直方向的缩放参数。 '1' 表示没有缩放, 负值在缩放的同时会翻转对象。
					vo.clearScaleY()
					break;
				case "skewX"://12;//显示对象水平方向的倾斜弧度。 /100 0-100
					vo.clearSkewX()
					break;
				case "skewY"://13;//显示对象垂直方向的倾斜弧度。/100 0-100
					vo.clearSkewY()
					break;
				case "rotation"://14;//显示对象的旋转弧度。 /100 0-100			
					vo.clearRotation()
					break;
				case "pivotX"://8;//显示对象在自己的坐标系的起始x坐标（默认：0） 
					vo.clearPivotX()
					break;
				case "pivotY"://9;//显示对象在自己的坐标系的起始y坐标（默认：0）				
					vo.clearPivotY()
					break;
				case "color"://	=3;//四边形的颜色，如果四边形存在多个颜色，返回第一个顶点的颜色
					vo.clearColor()
					break;
				case "height":// =4;//图片高
					vo.clearHeight()
					break;
				case "width":// =5;//图片宽
					vo.clearWidth()
					break;
				case "x"://=6;
					vo.clearX()
					break;
				case "y"://=7;
					vo.clearY()
					break;					
			}
		}
	}
}