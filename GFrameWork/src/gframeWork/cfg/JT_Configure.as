package gframeWork.cfg
{
	public class JT_Configure
	{
		
		//------------------------------------------------------------------------------------
		/**
		 * 网络配置文件地址 
		 */		
		public static var NET_CONFIGURE_URL:String = "";
		
		/**
		 * socket断开后重新联接的时间 
		 */		
		public static const SOCKET_REPEAT_CONNECT_TIME:uint = 4000;
		
		/**
		 * socet信息的节点 
		 */		
		public static const SOCKET_JOINT:String =  "|";
		
		//----------------------------------------------------------------------------------------
		/**
		 * amf重试的次数 
		 */		
		public static var AMF_MAX_REPEAT:uint = 99;
		
		/**
		 * 默认的php服务端点 
		 */		
		public static var AMF_CHANNEL_POINT:String = "defaultChannel";
		
		/**
		 *AMF请求时间 
		 */		
		public static var AMF_TIME_OUT:int = 60;
		
		/**
		 * 当前系统的时间 
		 */		
		public static var SYS_TIME:uint = 0;
		
		/**
		 * 是否是Debug 
		 */		
		public static var DEBUG:Boolean = false;
		
		
	}
}