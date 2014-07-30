package com.frameWork.swf.display
{
	import com.coffeebean.swf.typeData.FrameChildData;
	import com.coffeebean.swf.typeData.FrameLabelData;
	import com.coffeebean.swf.typeData.SpriteData;
	import com.frameWork.swf.Swf;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	[Event(name="complete", type="starling.events.Event")]
	
	/**
	 * @author zmliu
	 */	
	public class SwfMovieClip extends SwfSprite
	{
		public static const ANGLE_TO_RADIAN:Number = Math.PI / 180;
		
		private var _ownerSwf:Swf;							//所属swf
		
		private var _frames:Array;							//所有的帧信息
		private var _labels:Array;							//所有的label信息
		private var __frameInfos:FrameChildData;			//当前帧信息			
		private var _displayObjects:Object;				//子级对象集
		
		private var _startFrame:int;						//开始帧数
		private var _endFrame:int;							//结束帧数
		private var _currentFrame:int;						//当前帧
		private var _currentLabel:String;					//当前标签
		
		private var _isPlay:Boolean = false;
		private var _loop:Boolean = true;
		private var _autoUpdate:Boolean = true;//是否自动更新
		
		private var _completeFunction:Function = null;//播放完毕的回调
		private var _hasCompleteListener:Boolean = false;//是否监听过播放完毕的事件
		
		public function SwfMovieClip(frames:Array,labels:Array,displayObjects:Object,ownerSwf:Swf)
		{
			super();
			
			_frames = frames;
			_labels = labels;
			_displayObjects = displayObjects;
			
			_startFrame = 0;
			_endFrame = _frames.length - 1;
			_ownerSwf = ownerSwf;
			
			currentFrame = 0;
			
			play();
		}
		
		public function update():void
		{
			if (!_isPlay) return;
			
			_currentFrame += 1;
			if(_currentFrame > _endFrame)
			{
				if(_completeFunction) _completeFunction(this);
				if(_hasCompleteListener) dispatchEventWith(Event.COMPLETE);
				
				_currentFrame = _startFrame - 1;
				
				if(!_loop)
				{
					stop(false);
					return;
				}
				
				if(_startFrame == _endFrame) //只有一帧就不要循环下去了
				{
					stop(false);
					return;
				}
			}
			else
			{
				currentFrame = _currentFrame;
			}
		}
		
		public function set currentFrame(frame:int):void
		{
			removeChildren();
			
			_currentFrame = frame;
			__frameInfos = _frames[_currentFrame];
			
			var name:String;												//名称
			var type:String;												//类型
			var data:SpriteData;											//Sprite数据
			var display:DisplayObject;
			var useIndex:int;
			var length:int = __frameInfos.spriteChildsData.length;
			for (var i:int = 0; i < length; i++) 
			{
				data = __frameInfos.spriteChildsData[i];
				useIndex = data.index;
				display = _displayObjects[data.childClassName][useIndex];
				
				display.x = data.x;
				display.y = data.y;
				
				if(data.type == Swf.dataKey_Scale9)
				{
					display.width = data.width;
					display.height = data.height;
				}
				else
				{
					display.scaleX = data.scaleX;
					display.scaleY = data.scaleY;
				}
				display.skewX = data.sketwX * ANGLE_TO_RADIAN;
				display.skewY = data.sketwY * ANGLE_TO_RADIAN;
				display.alpha = data.alpha;
				display.name = data.childName;
				addChild(display);
				
				if(data.type == Swf.dataKey_TextField)
				{
					display["width"] = data.width;
					display["height"] = data.height;
					display["fontName"] = data.font;
					display["color"] = data.color;
					display["fontSize"] = data.size;
					display["hAlign"] = data.align;
					display["italic"] = data.italic;
					display["bold"] = data.bold;
					if(data.text && data.text != "\r" && data[19] != "")
					{
						display["text"] = data.text;
					}
				}
			}
		}
		
		public function get currentFrame():int
		{
			return _currentFrame;
		}
		
		/**
		 * 播放
		 * */
		public function play():void
		{
			_isPlay = true;
			
			if(_autoUpdate) _ownerSwf.swfUpdateManager.addSwfMovieClip(this);
			
			var k:String;
			var arr:Array;
			var len:int;
			for(k in _displayObjects)
			{
				if(k.indexOf(Swf.dataKey_MovieClip) == 0)
				{
					arr = _displayObjects[k];
					len = arr.length;
					for (var i:int = 0; i < len; i++) 
					{
						(arr[i] as SwfMovieClip).play();
					}
				}
			}
		}
		
		/**
		 * 停止
		 * @param	stopChild	是否停止子动画
		 * */
		public function stop(stopChild:Boolean = true):void
		{
			_isPlay = false;
			_ownerSwf.swfUpdateManager.removeSwfMovieClip(this);
			
			if(!stopChild) return;
			
			var k:String;
			var arr:Array;
			var len:int;
			for(k in _displayObjects){
				if(k.indexOf(Swf.dataKey_MovieClip) == 0)
				{
					arr = _displayObjects[k];
					len = arr.length;
					for (var i:int = 0; i < len; i++) 
					{
						(arr[i] as SwfMovieClip).stop(stopChild);
					}
				}
			}
		}
		
		public function gotoAndStop(frame:Object,stopChild:Boolean = true):void
		{
			goTo(frame);
			stop(stopChild);
		}
		
		public function gotoAndPlay(frame:Object):void
		{
			goTo(frame);
			play();
		}
		
		private function goTo(frame:*):void
		{
			if((frame is String))
			{
				var labelData:FrameLabelData = getLabelData(frame);
				_currentLabel = labelData.name;
				_currentFrame = _startFrame = labelData.frame;
				_endFrame = labelData.endFrame;
			}
			else if(frame is int)
			{
				_currentFrame = _startFrame = frame;
				_endFrame = _frames.length - 1;
			}
			currentFrame = _currentFrame;
		}
		
		/**
		 * 根据帧标签来获取一个关建帧 
		 * @param label
		 * @return 
		 * 
		 */		
		private function getLabelData(label:String):FrameLabelData
		{
			var length:int = _labels.length;
			var labelData:FrameLabelData;
			for (var i:int = 0; i < length; i++) 
			{
				labelData = _labels[i];
				if(labelData.name == label)
				{
					return labelData;
				}
			}
			return null;
		}
		
		/**
		 * 是否再播放
		 * */
		public function get isPlay():Boolean
		{
			return _isPlay;
		}
		
		/**
		 * 设置/获取 是否循环播放
		 * */
		public function get loop():Boolean
		{
			return _loop;
		}
		
		public function set loop(value:Boolean):void
		{
			_loop = value;
		}
		
		/**
		 * 设置播放完毕的回调
		 */		
		public function set completeFunction(value:Function):void
		{
			_completeFunction = value;
		}
		
		public function get completeFunction():Function
		{
			return _completeFunction;
		}
		
		/**
		 * 总共有多少帧
		 * */
		public function get totalFrames():int
		{
			return _frames.length;
		}
		
		/**
		 * 返回当前播放的是哪一个标签
		 * */
		public function get currentLabel():String
		{
			return _currentLabel;
		}
		
		/**
		 * 获取所有标签
		 * */
		public function get labels():Array
		{
			var length:int = _labels.length;
			var returnLabels:Array = [];
			for (var i:int = 0; i < length; i++) 
			{
				returnLabels.push(_labels[i].name);
			}
			return returnLabels;
		}
		
		/**
		 * 是否包含某个标签
		 * */
		public function hasLabel(label:String):Boolean
		{
			var ls:Array = labels;
			var i:int = 0;
			var len:int = ls.length;
			for(i; i != len; i++)
			{
				if(ls[i].name == label)
				{
					return true;
				}
			}
			return false;
		}
		
		/**
		 * 设置 / 获取 动画是否自动更新
		 * */
		public function get autoUpdate():Boolean
		{
			return _autoUpdate;
		}
		
		public function set autoUpdate(value:Boolean):void
		{
			_autoUpdate = value;
			if(_autoUpdate && _isPlay)
			{
				_ownerSwf.swfUpdateManager.addSwfMovieClip(this);
			}
			else if(!_autoUpdate && _isPlay)
			{
				_ownerSwf.swfUpdateManager.removeSwfMovieClip(this);
			}
		}
		
		public override function addEventListener(type:String, listener:Function):void
		{
			super.addEventListener(type,listener);
			_hasCompleteListener = hasEventListener(Event.COMPLETE);
		}
		
		public override function removeEventListener(type:String, listener:Function):void
		{
			super.removeEventListener(type,listener);
			_hasCompleteListener = hasEventListener(Event.COMPLETE);
		}
		
		public override function removeEventListeners(type:String=null):void
		{
			super.removeEventListeners(type);
			_hasCompleteListener = hasEventListener(Event.COMPLETE);
		}
		
		public override function dispose():void
		{
			_ownerSwf.swfUpdateManager.removeSwfMovieClip(this);
			_ownerSwf = null;
			super.dispose();
		}
	}
}