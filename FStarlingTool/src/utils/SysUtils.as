package utils
{
	import com.adobe.crypto.MD5;
	
	import flash.desktop.NativeApplication;
	import flash.net.NetworkInfo;
	import flash.net.NetworkInterface;

	/**
	 * 系统工具
	 * @author zmliu
	 * 
	 */	
	public class SysUtils
	{
		
		/**
		 * 获取网卡的md5值
		 * */
		public static function get macAddressMD5ID():String{
			var interfaces:Vector.<NetworkInterface> = NetworkInfo.networkInfo.findInterfaces();
			var address:String = "";
			for each (var item:NetworkInterface in interfaces)
			{
				address += item.hardwareAddress;
			}
			return MD5.hash(address);
		}
		
		/**
		 * 获取工具版本号
		 * */
		public static function get version():String
		{
			return NativeApplication.nativeApplication.applicationDescriptor.children()[3];
		}
		
	}
}