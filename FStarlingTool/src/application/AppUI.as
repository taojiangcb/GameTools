package application
{
	import application.controls.MainUIControler;
	import application.controls.RootUIPanelControler;
	import application.ui.MainUIPanel;
	import application.ui.RootStateUIPanel;
	import application.comps.RootStage;
	
	import gframeWork.FrameWork;
	import gframeWork.uiController.UserInterfaceManager;

	public class AppUI
	{
		/**
		 * 上面的菜单区 
		 */		
		public static const APP_UI_MAIN:int = 1;
		public static const APP_ROOT_PANE:int = 2;
		
		public function AppUI()
		{
			UserInterfaceManager.registerGUI(APP_UI_MAIN,MainUIPanel,MainUIControler);
			UserInterfaceManager.registerGUI(APP_ROOT_PANE,RootStateUIPanel,RootUIPanelControler);
		}
	}
}