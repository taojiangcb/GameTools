/**
 *
 * UI控制管理
 *  
 */

package gframeWork.uiController
{
	import flash.geom.Point;
	
	import gframeWork.JT_internal;
	import gframeWork.collection.HashTable;
	
	import mx.core.UIComponent;

	use namespace JT_internal;
	public class JT_UserInterfaceManager
	{
		
		/**
		 * 当前打开的窗口列表 
		 */		
		private static var mOpenWindows:HashTable;
		
		private static var mInstance:UserInternalManager;
		
		/**
		 * 打开一个UI显示 
		 * @param ui_id			UI的ID
		 * @param isPop			是否是弹出显示
		 * @param position		显示的位置
		 * @return 
		 * 
		 */		
		public static function open(ui_id:uint,isPop:Boolean = false,position:Point = null):Boolean
		{
			return instance.open(ui_id,isPop,position);	
		}
		
		JT_internal static function openComplete(ui_id:uint,isPop:Boolean = false,position:Point = null):Boolean
		{
			return instance.openComplete(ui_id,isPop,position);	
		}
		
		/**
		 * 关闭的UI 
		 * @param ui_id
		 * @return 
		 * 
		 */		
		public static function close(ui_id:uint):Boolean
		{
			return instance.close(ui_id);	
		}
		
		/**
		 * 半闭所有窗口 
		 * 
		 */		
		public static function closeAllWindow():void
		{
			instance.closeAllWindow();
		}
		
		/**
		 * 添加注册一个UI 
		 * @param ui_id
		 * @param uiCls
		 * @param controlCLS
		 * 
		 */		
		public static function registerGUI(ui_id:uint,uiCls:Class,controlCLS:Class):void
		{
			instance.registerUserUI(ui_id,uiCls,controlCLS);
		}
		
		/**
		 * 销毁一个UI 
		 * @param ui_id
		 * 
		 */		
		public static function retireUI(ui_id:uint):void
		{
			instance.retireUI(ui_id);
		}
		
		/**
		 * 根据ID获取一个UI的逻辑控制 
		 * @param ui_id
		 * @return 
		 * 
		 */		
		public static function getUIByID(ui_id:uint):JT_UIControllerBase
		{
			return instance.getUIByID(ui_id);
		}
		
		/**
		 * 强制启动垃圾回收 
		 * 
		 */		
		public static function GC():void
		{
			instance.GC();
		}
		
		/**
		 * 窗口水平布局 
		 * @param args
		 * 
		 */		
		public static function windowUIHorizontal(...args):void
		{
			instance.horizontalLayout.apply(null,args);
		}
		
		
		/**
		 * 当前打开的UI 
		 * @return 
		 * 
		 */		
		public static function get openWindows():HashTable
		{
			if(!mOpenWindows)
			{
				mOpenWindows = new HashTable();
			}
			return mOpenWindows;
		}
		
		private static function get instance():UserInternalManager
		{
			if(!mInstance)
			{
				mInstance = new UserInternalManager();
			}
			return mInstance;
		}
		
		public function JT_UserInterfaceManager()
		{
			
		}
	}
}

import com.flashdynamix.utils.SWFProfiler;
import com.gskinner.motion.GTween;
import com.gskinner.motion.GTweenTimeline;
import com.gskinner.motion.easing.Sine;

import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.Dictionary;
import flash.utils.clearTimeout;
import flash.utils.setTimeout;

import gframeWork.JT_FrameWork;
import gframeWork.JT_internal;
import gframeWork.collection.HashTable;
import gframeWork.uiController.JT_UIControllerBase;
import gframeWork.uiController.JT_UI_States;
import gframeWork.uiController.JT_UserInterfaceManager;
import gframeWork.uiController.JT_WindowUIControllerBase;

import mx.core.IVisualElementContainer;
import mx.core.UIComponent;
import mx.effects.easing.Linear;

import spark.primitives.Line;

use namespace JT_internal;

class UserInternalManager
{
	
	/**
	 * 当前打开互斥的窗口ID
	 */	
	private var mCurUIMutualID:uint = uint.MAX_VALUE;
	
	/**
	 * UI的实例列表 
	 */	
	private var guiTable:Dictionary;
	
	/**
	 * ui注册表 
	 */	
	private var mUIRegister:Dictionary;
	
	/**
	 * 
	 * 窗口布局的动画过程
	 *  
	 */	
	private var mGTweenLine:GTweenTimeline = new GTweenTimeline();
	
	
	private var mHorizontalGTweenLine:GTweenTimeline;
	
	/**
	 * 启动GC的延迟时间 
	 */	
	private var mGCTimeOUTID:int = 0;
	
	public function UserInternalManager():void
	{
		guiTable = new Dictionary(true);
		mUIRegister = new Dictionary();
	}
	
	public function registerUserUI(ui_id:uint,uiCLS:Class,controlCLS:Class):void
	{
		
		if(!mUIRegister[ui_id])
		{
			var uiRegister:UIRegister = new UIRegister();
			uiRegister.mUI_ID = ui_id;
			uiRegister.mUI_CLS = uiCLS;
			uiRegister.mUI_Control = controlCLS;
			mUIRegister[ui_id] = uiRegister;
		}
		
		/*if(!guiTable[ui_id])
		{
			var gui:GUI = new GUI();
			gui.mUI_ID = ui_id;
			gui.mUI_Control = control;
			gui.mUI_Control.internalInit(ui);
			gui.mUI_Control.mGUI_ID = ui_id;
			guiTable[ui_id] = gui; 
		}*/
	}
	
	/**
	 * 
	 * 销毁此UI 
	 * @param ui_id
	 * 
	 */	
	public function retireUI(ui_id:uint):void
	{
		var gui:GUI = guiTable[ui_id];
		if(gui)
		{
			gui.mUI_Control.dispose();
			delete guiTable[ui_id];
		}
		
		GC();
		
		//内存回收
		//SWFProfiler.gc();
	}
	
	
	public function GC():void
	{
		if(mGCTimeOUTID > 0)
		{
			clearTimeout(mGCTimeOUTID);
			mGCTimeOUTID = 0;
		}
		mGCTimeOUTID = setTimeout(SWFProfiler.gc,3000);
	}
	
	/**
	 *
	 *  
	 * 开启某个UI显示，如果开启成功则返加 true 否则返回 false; 
	 * 
	 * 
	 * @param ui_id		ui的id
	 * @param isPop		如果为true则表示弹出显示
	 * @param point		显示的位置
	 * @return 
	 * 
	 */	
	public function open(ui_id:uint,isPop:Boolean = false,point:Point=null):Boolean
	{
		var gui:GUI = retrievUIControlByID(ui_id);
		if(gui)
		{
			if(gui.mUI_Control.uiElementLoading.loadCount > 0)
			{
				gui.mUI_Control.uiElementLoading.beginLoad();
			}
			else
			{
				return openComplete(ui_id,isPop,point);
			}
		}
		return false;
	}
	
	/**
	 * 打开界面 
	 * @param ui_id
	 * @param isPop
	 * @param point
	 * 
	 */	
	JT_internal function openComplete(ui_id:int,isPop:Boolean = false,point:Point=null):Boolean
	{
		var gui:GUI = retrievUIControlByID(ui_id);
		if(gui.mUI_Control.state != JT_UI_States.SHOW)
		{
			//排斥关闭不相关的窗口
			if(gui.mUI_Control is JT_WindowUIControllerBase)
			{
				var index:int = JT_WindowUIControllerBase(gui.mUI_Control).uiMutualGroup.indexOf(mCurUIMutualID);
				if(index <= -1)
				{
					closeByMutualID(mCurUIMutualID);
					mCurUIMutualID =  JT_WindowUIControllerBase(gui.mUI_Control).uiMutualID;
				}
				
				if(!JT_UserInterfaceManager.openWindows[gui.mUI_ID])
				{
					JT_UserInterfaceManager.openWindows.add(gui.mUI_ID,gui.mUI_Control)
				}
			}
			
			gui.mUI_Control.mCanUse = true;
			gui.mUI_Control.show(isPop,point);
			gui.mUI_Control.state = JT_UI_States.SHOW;
			gui.mUI_Control.mCanUse = false;
			
			//windowLayout();
			return true;
		}
		else 
		{
			if(gui.mUI_Control.autoClose)
			{
				close(ui_id);
			}
			if(gui.mUI_Control is JT_WindowUIControllerBase)
			{
				JT_WindowUIControllerBase(gui.mUI_Control).hotDisplay();
			}
			return false;
		}
	}
	
	/**
	 * 
	 * 关闭某个ui功能的显示 
	 * @param ui_id
	 * @return 
	 * 
	 */	
	public function close(ui_id:uint):Boolean
	{
		var gui:GUI = guiTable[ui_id];
		if(gui)
		{
			if(gui.mUI_Control.state == JT_UI_States.SHOW)
			{
				gui.mUI_Control.mCanUse = true;
				gui.mUI_Control.hide();
				gui.mUI_Control.state = JT_UI_States.HIDE;
				gui.mUI_Control.mCanUse = false;
			}
			
			if(JT_UserInterfaceManager.openWindows[gui.mUI_ID])
			{
				JT_UserInterfaceManager.openWindows.remove(gui.mUI_ID)
			}
			
			return true;
		}
		return false;
	}
	
	/**
	 * 
	 * 关闭当前已打开的所有窗口 
	 * 
	 */	
	public function closeAllWindow():void
	{
		var ids:Array = [];
		var win:JT_WindowUIControllerBase;
		for each(win in JT_UserInterfaceManager.openWindows)
		{
			win.mCanUse = true;
			win.hide();
			win.state = JT_UI_States.HIDE;
			win.mCanUse = false;
			ids.push(win.mGUI_ID);
		}
		
		while(ids.length > 0)
		{
			JT_UserInterfaceManager.openWindows.remove(ids[0]);
			ids.shift();
		}
	}
	

	/**
	 * 
	 * 窗口水平布局
	 * 
	 */	
	public function horizontalLayout(...args):void
	{
		var rect:Rectangle = new Rectangle();
		var i:int = 0;
		if(args.length > 0)
		{
			for(i = 0; i < args.length; i++)
			{
				var window:JT_UIControllerBase = args[i] as JT_UIControllerBase;
				rect.width += window.getGui().width;
				rect.height = window.getGui().height > rect.height ? window.getGui().height : rect.height;
			}
			
			var sp:Point = new Point(Math.round((getSpace().width - rect.width) / 2),Math.round((getSpace().height - rect.height) / 2));
			var growth:Number = 0;
			
			if(mGTweenLine)
			{
				mGTweenLine.paused = true;
				mGTweenLine = new GTweenTimeline();
			}
			
			for(i = 0; i < args.length; i++)
			{
				if(i == 0)
				{
					mGTweenLine.addTween(0,new GTween(args[i].getGui(),0.3,{x:sp.x,y:sp.y},{ease:Sine.easeOut}));
				}
				else
				{
					mGTweenLine.addTween(0,new GTween(args[i].getGui(),0.3,{x:sp.x + growth,y:sp.y},{ease:Sine.easeOut}));
				}
				growth += args[i].getGui().width;
			}
			
			mGTweenLine.calculateDuration();
		}
	}
	
	
	/**
	 * 
	 * 返回UI 
	 * @param ui_id
	 * @return 
	 * 
	 */
	public function getUIByID(ui_id:uint):JT_UIControllerBase
	{
		var gui:GUI = retrievUIControlByID(ui_id);
		if(gui)
		{
			return retrievUIControlByID(ui_id).mUI_Control;
		}
		else
		{
			return null;
		}
	}
	
	/**
	 * 
	 * 按照互斥ID关闭相关的窗口界面 
	 * @param id
	 * 
	 */	
	private function closeByMutualID(id:uint):void
	{
		var gui:GUI;
		for each(gui in guiTable)
		{
			if(gui.mUI_Control is JT_WindowUIControllerBase)
			{
				var index:int = JT_WindowUIControllerBase(gui.mUI_Control).uiMutualGroup.indexOf(id);
				if(index > -1)
				{
					close(gui.mUI_ID);
				}
			}
		}
	}
	
	/**
	 * 
	 * 按照ID取出UI 
	 * @param id
	 * 
	 */	
	private function retrievUIControlByID(id:uint):GUI
	{
		if(guiTable[id])
		{
			return guiTable[id];
		}
		else
		{
			return initGUI(id);
		}
	}
	
	/**
	 * 
	 * 构建一个GUI 
	 * @param id
	 * @return 
	 * 
	 */	
	private function initGUI(id:uint):GUI
	{
		if(mUIRegister[id])
		{
			var theRegister:UIRegister = mUIRegister[id] as UIRegister;
			var gui:GUI = new GUI();
			gui.mUI_ID = id;
			gui.mUI_Control = new theRegister.mUI_Control();
			gui.mUI_Control.internalInit(new theRegister.mUI_CLS());
			gui.mUI_Control.mGUI_ID = id;
			guiTable[id] = gui;
			return gui;
			
		}
		else
		{
			return null;
		}
	}
	
	/**
	 * 
	 * 获取窗口的父级容器
	 * @return 
	 * 
	 */	
	private function getSpace():UIComponent
	{
		return JT_FrameWork.getInstance().mWindowSpace;
	}
}

class GUI
{
	public var mUI_ID:uint = 0;
	public var mUI_Control:JT_UIControllerBase;
}

class UIRegister
{
	public var mUI_ID:uint = 0;
	public var mUI_CLS:Class = null;
	public var mUI_Control:Class = null;
}
