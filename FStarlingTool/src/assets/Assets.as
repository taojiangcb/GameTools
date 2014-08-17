package assets
{
	import com.frameWork.swf.Swf;
	import com.frameWork.utils.HttpClient;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import starling.utils.AssetManager;
	
	import utils.SwfUtil;
	
	/**
	 * 
	 * @author zmliu
	 * 
	 */
	public class Assets
	{
		public static var swfUtil:SwfUtil
		
		public static var swf:Swf;
		public static var asset:AssetManager;
		private static var tempFileUrl:String;
		private static var tempMovieClipData:Object;
		
		public static function init():void{
			swfUtil = new SwfUtil();
			if(asset){
				asset.purge();
			}
			asset = new AssetManager(1,false);
		}
		
		/**
		 * 打开记录临时数据的文件
		 * */
		public static function openTempFile(fileName:String,callBack:Function):void{
			var file:File = new File(fileName.replace(".swf",".data"));
			tempFileUrl = file.url;
			if(file.exists){
				HttpClient.send(tempFileUrl,{},function(data:String):void{
					tempMovieClipData = JSON.parse(data);
					callBack();
				});
			}else{
				tempMovieClipData = {};
				callBack();
			}
		}
		
		public static function putTempData(key:String,value:Object):void{
			tempMovieClipData[key] = value;
			writeTempFile();
		}
		
		public static function getTempData(key:String):Object{
			return tempMovieClipData[key];
		}
		
		private static function writeTempFile():void{
			var data:ByteArray = new ByteArray();
			data.writeUTFBytes(JSON.stringify(tempMovieClipData));
			
			var file:File = new File(tempFileUrl);
			var fs:FileStream = new FileStream();
			fs.open(file,FileMode.WRITE);
			fs.writeBytes(data);
			fs.close();
		}
		
	}
}