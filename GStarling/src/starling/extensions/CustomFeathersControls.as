package starling.extensions
{
	import flash.geom.Rectangle;
	
	import feathers.core.FeathersControl;
	import feathers.events.FeathersEventType;
	
	import starling.events.Event;
	
	/**
	 * 如果需要按外边距计算布局,那元件的锚点必须是左上顶角 0 的位置，也就是说 pivotX和pivotY为0 
	 * @author JiangTao
	 * 
	 */	
	
	public class CustomFeathersControls extends FeathersControl
	{
		
		private var maringRight:Number = NaN;
		private var maringTop:Number = NaN;
		private var maringBottom:Number = NaN;
		private var maringleft:Number = NaN;
		private var maringHCenter:Number = NaN;
		private var maringVCenter:Number = NaN;
		
		private var measureWidth:Number = NaN;
		private var measureHeight:Number = NaN;
		
		private var oldX:Number = 0;
		private var oldY:Number = 0;
		
		public function CustomFeathersControls(listenCreateComplete:Boolean = false)
		{
			super();
			if(listenCreateComplete)
			{
				addEventListener(FeathersEventType.CREATION_COMPLETE,createCompleteHandler);
			}
		}
		
		protected override function draw():void
		{
			if(isInvalid(FeathersControl.INVALIDATION_FLAG_DATA))
			{
				commitProperties();
			}
			if(isInvalid(FeathersControl.INVALIDATION_FLAG_LAYOUT))
			{
				layout();
			}
			super.draw();
		}
		
		protected override function initialize():void
		{
			super.initialize();
			listenerParentResize();
		}
		
		/**
		 * 此组件创建完成之后产生的事件监听回调,此回调由构造函数的listenCreateComplete参数决定
		 * @param event
		 * 
		 */		
		protected function createCompleteHandler(event:Event):void
		{
			removeEventListener(FeathersEventType.CREATION_COMPLETE,createCompleteHandler)
		}
		
		/**
		 * 各种数值属性计算 
		 */		
		protected function commitProperties():void
		{
		}
		
		/**
		 * 显示列表布局处理 
		 */		
		protected function layout():void
		{
			 layoutMarign();
		}
		
		/**
		 * 按外边距开始计算布局显示 
		 */		
		protected function layoutMarign():void
		{
			/*如果需要按外边距计算布局,那元件的锚点必须是左上顶角 0 的位置*/
			if(pivotX > 0 || pivotY > 0) return;
			if(!parent) return;
			if(width == 0 && height == 0) return;
			//如果没有外边距值则不会往下执行
			if(validateMaringX() && validateMaringY()) return;
			var parentSize:Rectangle = parent.getBounds(stage);
			var selfSize:Rectangle = getBounds(parent);
			
			var parentArea:Number = parentSize.width * parentSize.height;
			var area:Number = selfSize.width * selfSize.height;
			if(area > parentArea) return; //如果面积大于父级容器则什么都不干
			
			measureWidth = explicitWidth;
			measureHeight = explicitHeight;
			
			var measureX:Number = oldX;
			var measureY:Number = oldY;
			
			if(!isNaN(maringleft) && !isNaN(maringRight))
			{
				measureWidth = parentSize.width - maringleft - maringRight;
			}
			if(!isNaN(maringTop) && !isNaN(maringRight))
			{
				measureHeight = parentSize.height - maringTop - parentSize.height;
			}
			
			setSizeInternal(measureWidth,measureHeight,false);
			
			if(!isNaN(maringHCenter))
			{
				measureX = (parentSize.width - selfSize.width) / 2 + maringHCenter;
				if(!isNaN(maringTop))			measureY = maringTop;
				else if(!isNaN(maringBottom))	measureY = parentSize.height - measureHeight - maringBottom;
			}
			
			if(!isNaN(maringVCenter))
			{
				measureY = (parentSize.height - selfSize.height) / 2 + maringVCenter;
				if(!isNaN(maringleft))			measureX = maringleft;
				else if(!isNaN(maringRight))	measureX = parentSize.width - measureWidth - maringRight;
			}
			
			if(isNaN(maringHCenter) && isNaN(maringVCenter))
			{
				if(!isNaN(maringleft)) 			measureX = maringleft;
				else if(!isNaN(maringRight))	measureX = parentSize.width - measureWidth - maringRight;
				
				if(!isNaN(maringTop))			measureY = maringTop;
				else if(!isNaN(maringBottom))	measureY = parentSize.height - measureHeight - maringBottom;
			}
			
			super.x = measureX;
			super.y = measureY;
		}
		
		/**
		 * 验证水平外边距布局 
		 * @return 
		 * 
		 */		
		private function validateMaringX():Boolean
		{
			return isNaN(maringRight) && isNaN(maringleft) && isNaN(maringHCenter);
		}
		
		/**
		 * 验证垂直外边距布局 
		 * @return 
		 * 
		 */		
		private function validateMaringY():Boolean
		{
			return isNaN(maringTop) && isNaN(maringBottom)  && isNaN(maringVCenter);
		}
		
		private function listenerParentResize():void
		{
			if(parent) parent.addEventListener(Event.RESIZE,parentResizeHandler);
		}
		
		private function removeListenerParentResize():void
		{
			if(parent) parent.removeEventListener(Event.RESIZE,parentResizeHandler);
		}
		
		private function parentResizeHandler(event:Event):void
		{
			invalidateUpdateList();
		}
		
		public function invalidateProperties():void
		{
			invalidate(FeathersControl.INVALIDATION_FLAG_DATA);
		}
		
		public function invalidateUpdateList():void
		{
			invalidate(FeathersControl.INVALIDATION_FLAG_LAYOUT);
		}
		
		public override function dispose():void
		{
			removeEventListener(FeathersEventType.CREATION_COMPLETE,createCompleteHandler)
			removeListenerParentResize();
			super.dispose();
		}
		
		public override function set width(value:Number):void
		{
			if(super.width == value) return;
			super.width = value;
			invalidateUpdateList();
		}
		
		public override function set height(value:Number):void
		{
			if(super.height == value) return;
			super.height = value;
			invalidateUpdateList();
		}
		
		public override function setSize(width:Number, height:Number):void
		{
			if(width != super.width || height != super.height)
			{
				invalidateUpdateList();
			}
			super.setSize(width,height);
		}
		
		protected override function setSizeInternal(width:Number, height:Number, canInvalidate:Boolean):Boolean
		{
			if(width != super.width || height != super.height)
			{
				invalidateUpdateList();
			}
			return super.setSizeInternal(width,height,canInvalidate);
		}
		
		public function set left(val:Number):void
		{
			if(maringleft == val) return;
			maringleft = val;
			invalidateUpdateList();
		}
		
		public function get left():Number
		{
			return maringleft;
		}
		
		public function set right(val:Number):void
		{
			if(maringRight == val) return;
			maringRight = val;
			invalidateUpdateList();
		}
		
		public function set top(val:Number):void
		{
			if(maringTop == val) return;
			maringTop = val;
			invalidateUpdateList();
		}
		
		public function get top():Number
		{
			return maringTop;
		}
		
		public function set bottom(val:Number):void
		{
			if(maringBottom == val) return;
			maringBottom = val;
			invalidateUpdateList();
		}
		
		public function get bottom():Number
		{
			return maringBottom;
		}
		
		public function set horizontalCenter(val:Number):void
		{
			if(maringHCenter == val) return;
			maringHCenter = val;
			invalidateUpdateList();
		}
		
		public function get horizontalCenter():Number
		{
			return maringHCenter;
		}
		
		public function set verticalCenter(val:Number):void
		{
			if(maringVCenter == val) return;
			maringVCenter = val;
			invalidateUpdateList();
		}
		
		public function get verticalCenter():Number
		{
			return maringVCenter;
		}
		
		public override function set x(value:Number):void
		{
			oldX = value;
			if(validateMaringX())
			{
				super.x = value;
			}
		}
		
		public override function get x():Number
		{
			return oldX;
		}
		
		public override function set y(value:Number):void
		{
			oldY = value;
			if(validateMaringY())
			{
				super.y = value;
			}
		}
		
		public override function get y():Number
		{
			return oldY;
		}
	}
}