/**
 *
 * 游戏中所有窗口控制的基础类，主要功能包括弹出显示与拖拽控制
 * 
 * ============================================================================
 * 
 * 添加UI互斥组和互斥ID，用于窗口排的相互排斥关闭功能。 但mGroups互斥组里面一定包含mUIMutualID的值。
 * mGroups里是包含不会被排斥掉的ID
 * 
 */

package gframeWork.uiController
{
	import com.gskinner.motion.GTween;
	import com.gskinner.motion.easing.Sine;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import gframeWork.JT_FrameWork;
	import gframeWork.JT_IDisposable;
	import gframeWork.JT_internal;
	import gframeWork.cfg.JT_Configure;
	
	import mx.core.EventPriority;
	import mx.core.FlexGlobals;
	import mx.core.FlexVersion;
	import mx.core.IUIComponent;
	import mx.core.IVisualElement;
	import mx.core.IVisualElementContainer;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	use namespace JT_internal;

	public class JT_WindowUIControllerBase extends JT_UIControllerBase implements JT_IDisposable
	{
		
		/**
		 * 默认的UI组; 
		 */		
		public static const DEFAULT_GROUP_ID:uint = 0;
		
		/**
		 * 窗口是否可以拖拽 
		 */		
		private var mCanDrag:Boolean = true;
		
		/**
		 * 可接受鼠标托动的区域 
		 */		
		protected var mDragArea:UIComponent;
		
		/**
		 * 打开窗口和半闭窗口时的动画控制
		 */		
		private var mGTween:GTween;
		
		/**
		 * 可以拖动的区域 
		 */		
		private var dragRectangel:Rectangle = null;
		
		/**
		 * 标识是否被打开 
		 */		
		private var mOpenFlag:Boolean = false;
		
		/**
		 * UI互斥组
		 */		
		protected var mUIMutualGroups:Array = [];
		
		/**
		 * UI互斥ID 
		 */		
		protected var mUIMutualID:uint = DEFAULT_GROUP_ID;
		
		/**
		 * 关闭窗口时是否从可视列表中移除 
		 */		
		protected var mCanRemove:Boolean = true;
		
		/**
		 * 置顶执行的ID 
		 */		
		private var toHotID:int = 0;
		
		public function JT_WindowUIControllerBase()
		{
			super();
			mUIMutualID = DEFAULT_GROUP_ID;
			mUIMutualGroups = [DEFAULT_GROUP_ID];
		}
		
		/**
		 * 
		 * 初始化 
		 * 
		 */		
		public override function internalInit(gui:UIComponent):void
		{
			super.internalInit(gui);
		}
		
		/**
		 * UI创建完成后处理 
		 * @param event
		 * 
		 */		
		protected override function uiCreateComplete(event:FlexEvent):void
		{
			super.uiCreateComplete(event);
			guiInternalInit();
			openRefresh();
			if(mGUI.hasOwnProperty("dragArea"))
			{
				mDragArea = Object(mGUI).dragArea as UIComponent;
				invalidteDrag();
			}
		}
		
		/**
		 * 
		 * 添加到场景显示 
		 * 
		 */		
		protected override function addToUiSpace():void
		{
			if(mGUI)
			{
				if(!mGUI.parent)
				{
					if(getSpace() is IVisualElementContainer)
					{
						IVisualElementContainer(getSpace()).addElement(mGUI);
					}
					else 
					{
						UIComponent(getSpace()).addChild(mGUI);
					}
				}
				else
				{
					mGUI.visible = true;
				}
				state = JT_UI_States.SHOW;
			}
			invalidteDrag();
			mGUI.alpha = 1;
			if(!mOpenFlag)
			{
				mOpenFlag = true;
			}
			
			if(mGUI.initialized)
			{
				openRefresh();
			}
			
			
			if(toHotID > 0)
			{
				clearTimeout(toHotID);
				toHotID = 0;
			}
			//toHotID = setTimeout(hotDisplay,1000 / 24);
		}
		
		
		/**
		 * 
		 * 窗口第一次被开启时调用 
		 * 
		 */		
		protected function guiInternalInit():void
		{
			
		}
		
		/**
		 * 
		 * 每次打开界面时都会执行的界面刷新方法，由子级窗口覆盖实现 
		 * 
		 */		
		protected function openRefresh():void
		{
			restaringDieListener();
		}
		
		/**
		 * 
		 * 关闭窗口时显示的动画效果 
		 * 
		 */		
		private function hideEffect():void
		{
			if(state == JT_UI_States.SHOW)
			{
				if(mGTween)
				{
					mGTween.paused = true;
					mGTween.target = null;
					mGTween = null;
				}
				
				mGTween = new GTween(mGUI,0.3,{alpha:0},{ease:Sine.easeOut});
				mGTween.onComplete = hideEffectEnd;
			}
			else
			{
				hideComplete();
			}
		}
		
		private function hideEffectEnd(g:GTween):void
		{
			g.paused = true;
			g.target = null;
			g = null;
			hideComplete();
		}
		
		/**
		 * 
		 * 关闭窗口完成 
		 * 
		 */		
		protected function hideComplete():void
		{
			if(mGUI)
			{
				if(mCanRemove)
				{
					var guiParent:IUIComponent = mGUI.parent as IUIComponent;
					if(guiParent)
					{
						if(guiParent is IVisualElementContainer)
						{
							IVisualElementContainer(guiParent).removeElement(mGUI);
						}
						else
						{
							UIComponent(guiParent).removeChild(mGUI);
						}
					}
				}
				else 
				{
					mGUI.visible = false;
				}
			}
//			JT_UserInterfaceManager.windowLayout();
		}
		
		/**
		 * 拖拽监听 
		 * 
		 */		
		private function invalidteDrag():void
		{
			mGUI.addEventListener(MouseEvent.MOUSE_DOWN,theMouseDownHandler,false,0,true);
			dragRectangel = new Rectangle(getSpace().x,getSpace().y,getSpace().width - mGUI.width,getSpace().height - mGUI.height);
		}
		
		/**
		 * 开始拖拽处理
		 * @param event
		 */		
		protected function theMouseDownHandler(event:MouseEvent):void
		{
			if(mCanDrag && mDragArea && mDragArea.hitTestPoint(JT_FrameWork.getInstance().mRoot.mouseX,JT_FrameWork.getInstance().mRoot.mouseY))
			{
				//拖拽
				mGUI.stage.removeEventListener(MouseEvent.MOUSE_UP,dragStop);
				mGUI.stage.addEventListener(MouseEvent.MOUSE_UP,dragStop,false,0,true);
				mGUI.startDrag(false,new Rectangle(getSpace().x,getSpace().y,getSpace().width - mGUI.width,getSpace().height - mGUI.height));
				hotDisplay();
			}
			else
			{
				hotDisplay();
			}
		}
		
		/**
		 * 置顶显示
		 */		
		public function hotDisplay():void
		{
			//container.setElementIndex(mGUI,container.numElements - 1);
		}
		
		/**
		 * 停止拖拽 
		 * @param event
		 * 
		 */		
		protected function dragStop(event:MouseEvent):void
		{
			mGUI.stopDrag();
			mPosition.x = mGUI.x;
			mPosition.y = mGUI.y;
		}
		
		/**
		 * 从显示层级中删除 
		 * 
		 */		
		protected override function removeFromeUiSpace():void
		{
			if(mDragArea)
			{
				mGUI.removeEventListener(MouseEvent.MOUSE_DOWN,theMouseDownHandler);
				if(mGUI.stage)
				{
					mGUI.stage.removeEventListener(MouseEvent.MOUSE_UP,dragStop);
				}
				else
				{
					dragStop(null);
				}
			}
			hideEffect();
		}
		
		/**
		 * 隐藏关闭窗口 
		 * 
		 */		
		public override function hide():void
		{
			super.hide();
			JT_FrameWork.getInstance().mRoot.setFocus();
		}
		
		/**
		 * 
		 * 打开显示窗口 
		 * @param isPop
		 * @param point
		 * 
		 */		
		public override function show(isPop:Boolean=false, point:Point=null):void
		{
			if(!mCanUse)
			{
				throw new Error("please call open function from JT_UserInterFaceManager");
				return;
			}
			
			if(point)
			{
				mPosition = point;
			}
			else
			{
				mPosition = new Point((getSpace().width - mGUI.width) / 2,(getSpace().height - mGUI.height) / 2);
				mGUI.move(mPosition.x,mPosition.y);
			}
			
			mPosition.x = Math.round(mPosition.x);
			mPosition.y = Math.round(mPosition.y);
			mGUI.move(mPosition.x,mPosition.y);
			addToUiSpace();
			
			if(mDieInterID > 0)
			{
				clearTimeout(mDieInterID);
				mDieInterID = 0;
			}
		}
		
		public override function dispose():void
		{
			
			if(toHotID > 0)
			{
				clearTimeout(toHotID);
				toHotID = 0;
			}
			
			if(mGTween)
			{
				mGTween.paused = true;
				mGTween.target = null;
				mGTween = null;
			}
			
			mGUI.removeEventListener(MouseEvent.MOUSE_DOWN,theMouseDownHandler);
			
			if(mGUI.stage)
			{
				mGUI.stage.removeEventListener(MouseEvent.MOUSE_UP,dragStop);
			}
			
			//可能从显示列表中删除
			mCanRemove = true;
			
			//清除可以拖拽区域
			if(mDragArea)
			{
				if(mDragArea.parent)
				{
					if(mDragArea.parent is IVisualElementContainer)
					{
						IVisualElementContainer(mDragArea.parent).removeElement(mDragArea);
					}
					else
					{
						mDragArea.parent.removeChild(mDragArea);
					}
				}
				mDragArea = null;
			}
			
			dragRectangel = null;
			
			super.dispose();
		}
		
		/**
		 * 
		 * 获取UI组 
		 * @return 
		 * 
		 */		
		public function get uiMutualGroup():Array
		{
			return mUIMutualGroups;
		}
		
		/**
		 * 获取互斥ID 
		 * @return 
		 * 
		 */		
		public function get uiMutualID():uint
		{
			return mUIMutualID;
		}
		
		public override function getSpace():UIComponent
		{
			return JT_FrameWork.getInstance().mWindowSpace;
		}
		
		private function get container():IVisualElementContainer
		{
			return getSpace() as IVisualElementContainer;
		}
		
	}
}