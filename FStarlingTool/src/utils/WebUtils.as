package utils
{
	import lzm.util.HttpClient;
	import lzm.util.LSOManager;

	/**
	 * 一些web请求的封装 
	 * @author zmliu
	 * 
	 */	
	public class WebUtils
	{
		
		private static const apiPath:String = "http://zmliu.sinaapp.com/";
		
		public static var updateUrl:String = "http://zmliu.github.io/2013/12/17/StarlingSwfToolUpdate/";
		public static var tutorialsUrl:String = "http://zmliu.github.io/2013/11/09/StarlingSwfTool/";
		
		public static function register():void{
			var registerVersion:String = LSOManager.get("registerVersion");
			if(registerVersion == SysUtils.version) return;
			
			var params:Object = {
				api:"starlingSwf",
				c:"register",
				macAddress:SysUtils.macAddressMD5ID,
				version:SysUtils.version
			};
			
			HttpClient.send(apiPath,params,function(data:String):void{
				LSOManager.put("registerVersion",SysUtils.version);
			},null,"post");
		}
		
		public static function checkVersion(callBack:Function):void{
			var params:Object = {
				api:"starlingSwf",
				c:"version"
			};
			
			HttpClient.send(apiPath,params,function(data:String):void{
				var object:Object = JSON.parse(data);
				updateUrl = object.updateUrl;
				tutorialsUrl = object.tutorialsUrl;
				
				if(object.version != SysUtils.version && object.needUpdate){
					callBack(true);
				}else{
					callBack(false);
				}
			});
		}
		
	}
}