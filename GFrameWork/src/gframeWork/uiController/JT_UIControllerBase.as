package gframeWork.uiController
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import gframeWork.JT_FrameWork;
	import gframeWork.JT_IDisposable;
	import gframeWork.JT_internal;
	import gframeWork.cfg.JT_Configure;
	
	import mx.core.EventPriority;
	import mx.core.IUIComponent;
	import mx.core.IVisualElement;
	import mx.core.IVisualElementContainer;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import spark.components.DataGrid;
	import spark.components.SkinnableContainer;
	import spark.components.supportClasses.SkinnableComponent;
	
	use namespace JT_internal;

	public class JT_UIControllerBase extends EventDispatcher
	{
		/**
		 * 标识ID  
		 */		
		public var mGUI_ID:uint = 0;
		
		/**
		 *  销毁清理的检测时间以毫秒为单位，如果此值为0时表示该UI不会被回收。
		 */	
		protected var mDieTime:uint = 300000;
		/**
		 * 
		 * 清理检测的ID
		 */		
		protected var mDieInterID:uint = 0;

		/**
		 * GUI组件 
		 */		
		protected var mGUI:UIComponent;
		
		/**
		 * 当前窗口的位置 
		 */		
		protected var mPosition:Point;
		
		/**
		 * 窗口当前的状态
		 */		
		public var state:uint = JT_UI_States.NORMAL;
		
		
		/**
		 * 如果重复调用show方法是否执行close函数关闭窗口 
		 */		
		public var autoClose:Boolean = true;
		
		/**
		 * 在打开当前UI界面时先下载相关的资源文件处理 
		 */		
		public var uiElementLoading:UIPreLoader;
		
		/**
		 * 是否可以使用的标识
		 */		
		JT_internal var mCanUse:Boolean = false;
		
		
		public function JT_UIControllerBase()
		{
			if(JT_Configure.DEBUG)
			{
				mDieTime = 5000;
			}
		}
		
		/**
		 * 
		 * 初始化 
		 * 
		 */		
		public function internalInit(gui:UIComponent):void
		{
			mGUI = gui;
			uiElementLoading = new UIPreLoader();
			if(mGUI)
			{
				mGUI.addEventListener(FlexEvent.CREATION_COMPLETE,uiCreateComplete);
			}
		}
		
		protected function uiCreateComplete(event:FlexEvent):void
		{
			mGUI.removeEventListener(FlexEvent.CREATION_COMPLETE,uiCreateComplete);
		}
		
		/**
		 * 添加到场景显示 
		 */		
		protected  function addToUiSpace():void
		{
			if(mGUI)
			{
				if(getSpace() is IVisualElementContainer)
				{
					IVisualElementContainer(getSpace()).addElement(mGUI);
				}
				else 
				{
					UIComponent(getSpace()).addChild(mGUI);
				}
				state = JT_UI_States.SHOW;
			}
		}
		
		/**
		 * 从场景中移动当前UI显示
		 */		
		protected function removeFromeUiSpace():void
		{
			if(mGUI)
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
		}
		
		/**
		 * 
		 * 当前UI弹出后，验之鼠标当前点中碰撞的位置是否了生在UI之上。如果不在UI之上则有关闭UI显示的处理。 
		 * @param event
		 * 
		 */		
		protected function validatePopupClick(event:MouseEvent):void
		{
			if(mGUI.stage)
			{
				if(!mGUI.hitTestPoint(event.stageX,event.stageY))
				{
					JT_UserInterfaceManager.close(mGUI_ID);
				}
			}
		}
		
		/**
		 * 
		 * 添加到ui空间层中显示，如果第一次调后则会触发uiCreateComplete函数 
		 * @param isPop
		 * @param point
		 * 
		 */		
		public function show(isPop:Boolean = false,point:Point = null):void
		{
			if(mCanUse)
			{
				
				var delayFunc:Function = function():void
				{
					getRoot().addEventListener(MouseEvent.MOUSE_DOWN,validatePopupClick,true,EventPriority.CURSOR_MANAGEMENT,true);
				}
				
				if(point)
				{
					mPosition = point;
				}
				else
				{
					if(!mPosition)
					{
						mPosition = new Point((getSpace().width - mGUI.width) / 2,(getSpace().height - mGUI.height) / 2);
					}
				}
				
				mPosition.x = Math.round(mPosition.x);
				mPosition.y = Math.round(mPosition.y);
				
				mGUI.move(mPosition.x,mPosition.y);
				addToUiSpace();
				
				if(isPop)
				{
					mGUI.callLater(delayFunc);			
				}
				
				if(mDieInterID > 0)
				{
					clearTimeout(mDieInterID);
					mDieInterID = 0;
				}
				
			}
			else
			{
				throw new Error("please call open function from JT_UserInterFaceManager");
			}
		}
		
		
		public function hide():void
		{
			if(mCanUse)
			{
				getRoot().removeEventListener(MouseEvent.CLICK,validatePopupClick);
				removeFromeUiSpace();
				restaringDieListener();
			}
			else
			{
				throw new Error("please call close function from JT_UserInterFaceManager");
			}
			
		}
		
		public function dispose():void
		{
			mGUI.removeEventListener(FlexEvent.CREATION_COMPLETE,uiCreateComplete);
			
			if(uiElementLoading)
			{
				uiElementLoading.dispose();
				uiElementLoading = null;
			}
			
			if(mGUI)
			{
				getRoot().removeEventListener(MouseEvent.MOUSE_DOWN,validatePopupClick,true);	
				removeFromeUiSpace();
				
				destoryGUI(mGUI);
				
				if(mGUI is IVisualElementContainer)
				{
					IVisualElementContainer(mGUI).removeAllElements();
				}
				else
				{
					while(mGUI.numChildren > 0)
					{
						mGUI.removeChildAt(0);
					}
				}
				
				mGUI = null;
			}
			
			mPosition = null;
			
			if(mDieInterID > 0)
			{
				clearTimeout(mDieInterID);
				mDieInterID = 0;
			}
		}
		
		/**
		 *
		 *  检测是否销毁此UI 
		 * 
		 */		
		private function validateDieUI():void
		{
			if(state == JT_UI_States.HIDE)
			{
				JT_UserInterfaceManager.retireUI(mGUI_ID);
			}
		}
		
		
		/**
		 * 启动回收监听 
		 * @return 
		 */		
		protected function restaringDieListener():void
		{
			//启动回收检查
			if(mDieTime > 0)
			{
				if(mDieInterID > 0)
				{
					clearTimeout(mDieInterID);
					mDieInterID = 0;
				}
				mDieInterID = setTimeout(validateDieUI,mDieTime);
			}
		}
		
		
		/**
		 * 销毁GUI界面 
		 * @param child
		 * 
		 */		
		private function destoryGUI(child:DisplayObject):void
		{
			var elementContent:IVisualElementContainer;
			if(child)
			{
				var displayObject:DisplayObject = null;
				if(child is JT_IDisposable)
				{
					try
					{
						JT_IDisposable(child).dispose();
					}
					catch(e:Error){}
				}
				
				if(child is SkinnableContainer)
				{
					elementContent = IVisualElementContainer(child);
					while(elementContent.numElements > 0)
					{
						displayObject = elementContent.getElementAt(0) as DisplayObject; 
						elementContent.removeElementAt(0);
						destoryGUI(displayObject);
					}
				}
					
				else if(child is SkinnableComponent)
				{
					if(child.parent is IVisualElementContainer)
					{
						IVisualElementContainer(child.parent).removeElement(child as IVisualElement);
					}
					else
					{
						try
						{
							child.parent.removeChild(child);
						}
						catch(e:Error){};
					}
				}
				else if(child is DataGrid)
				{
					if(child.parent is IVisualElementContainer)
					{
						IVisualElementContainer(child.parent).removeElement(child as IVisualElement);
					}
					else
					{
						try
						{
							child.parent.removeChild(child);
						}
						catch(e:Error){};
					}
				}
				else if(child is IVisualElementContainer)
				{
					elementContent = IVisualElementContainer(child);
					while(elementContent.numElements > 0)
					{
						displayObject = elementContent.getElementAt(0) as DisplayObject; 
						elementContent.removeElementAt(0);
						destoryGUI(displayObject);
					}
				}
				else if(child is UIComponent)
				{
					var ui:UIComponent = UIComponent(child);
					while(ui.numChildren > 0)
					{
						displayObject = ui.getChildAt(0) as DisplayObject;
						ui.removeChildAt(0);
						destoryGUI(displayObject);
					}
				}
				else if(child is Loader)
				{
					if(child.parent is IVisualElementContainer)
					{
						IVisualElementContainer(child.parent).removeElement(child as IVisualElement);
					}
					else
					{
						try
						{
							child.parent.removeChild(child);
						}
						catch(e:Error){};
					}
				}
				else if(child is DisplayObjectContainer)
				{
					var displayContent:DisplayObjectContainer = DisplayObjectContainer(child);
					while(displayContent.numChildren > 0)
					{
						displayObject = displayContent.getChildAt(0); 
						try
						{
							displayContent.removeChildAt(0);
						}
						catch(e:Error){};
						destoryGUI(displayObject);
					}
				}
				else if(child.parent)
				{
					if(child.parent is IVisualElementContainer)
					{
						IVisualElementContainer(child.parent).removeElement(child as IVisualElement);
					}
					else
					{
						try
						{
							child.parent.removeChild(child);
						}
						catch(e:Error){};
					}
				}
			}
		}
		
		
		public function getGui():UIComponent
		{
			return mGUI;
		}
		
		public function getSpace():UIComponent
		{
			return JT_FrameWork.getInstance().mRoot;	
		}
		
		protected function getRoot():UIComponent
		{
			return JT_FrameWork.getInstance().mRoot;
		}
	}
}