/***
SLArea
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年07月17日 17:06:37
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero{
	import flash.display.Stage;
	import flash.utils.Dictionary;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;

	public class SLArea extends Sprite{
		
		private static var sl:Starling;
		private static var instance:SLArea;
		private static var onInitComplete:Function;
		
		public static function init(stage:Stage,_onInitComplete:Function):void{
			onInitComplete=_onInitComplete;
			sl=new Starling(SLArea,stage,null);
			sl.start();
		}
		public static function changeBgColor(bgColor:int):void{
			sl.stage.color=bgColor;
		}
		public static function update(particleEmitterConfigXML:XML,x:int,y:int,image:Array):void{
			instance.update(particleEmitterConfigXML,x,y,image);
		}
		
		private var textures:Dictionary;
		private var exhaust:PDParticleSystem;
		
		public function SLArea(){
			this.addEventListener(Event.ADDED_TO_STAGE,added);
		}
		private function added(...args):void{
			instance=this;
			textures=new Dictionary();
			if(onInitComplete==null){
			}else{
				onInitComplete();
				onInitComplete=null;
			}
		}
		private function update(particleEmitterConfigXML:XML,x:int,y:int,image:Array):void{
			//particleEmitterConfigXML.duration=<duration value="-1"/>;
			var texture:Texture=textures[image[1]];
			if(texture){
			}else{
				textures[image[1]]=texture=Texture.fromBitmapData(image[1]);
				//trace("新建纹理");
			}
			
			if(exhaust){
				updatePDParticleSystem(exhaust,particleEmitterConfigXML,texture);
			}else{
				exhaust = new PDParticleSystem(particleEmitterConfigXML,texture);
				this.addChild(exhaust);
				exhaust.start();
				Starling.juggler.add(exhaust);
			}
			exhaust.emitterX=x;
			exhaust.emitterY=y;
		} 
		
	}
}