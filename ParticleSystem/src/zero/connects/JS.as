/***
JS
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年07月18日 18:44:10
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.connects{
	import flash.external.ExternalInterface;
	
	public class JS{
		
		private var onUpdateConfig:Function;
		
		public function JS(callbackMethodName:String,_onUpdateConfig:Function){
			if(ExternalInterface.available){
				ExternalInterface.addCallback(callbackMethodName,updateConfig);
			}
			onUpdateConfig=_onUpdateConfig;
		}
		private function updateConfig(configStr:String):void{
			if(onUpdateConfig==null){
			}else{
				onUpdateConfig(new XML(configStr));
			}
		}
	}
}