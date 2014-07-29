package application
{
	import gframeWork.JT_FrameWork;
	import gframeWork.uiController.JT_UserInterfaceManager;

	public class AppUI
	{
		public static const APP_UI_MAIN:int = 0;
		
		public function AppUI()
		{
			JT_UserInterfaceManager.registerGUI(APP_UI_MAIN,MainUIPanel,MainUIControler);
		}
	}
}