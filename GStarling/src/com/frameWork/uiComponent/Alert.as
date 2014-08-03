package com.frameWork.uiComponent
{
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.events.Event;

	public class Alert
	{
		
		private static var background:Quad;
		private static var dialogs:Vector.<DisplayObject> = new Vector.<DisplayObject>();
		
		public static function show(display:DisplayObject):void
		{
			Starling.current.stage.addChild(display);
		}
		
		public static function alert(dialog:DisplayObject):void{
			if(dialogs.indexOf(dialog) != -1){
				return;
			}
			
			dialog.addEventListener(Event.ADDED_TO_STAGE,dialogAddToStage);
			initBackGround();
			Starling.current.stage.addChild(background);
			Starling.current.stage.addChild(dialog);
			
			var dialogRect:Rectangle = dialog.getBounds(dialog.parent);
			dialog.x = (Starling.current.stage.stageWidth - dialogRect.width) >> 1;
			dialog.y = (Starling.current.stage.height - dialogRect.height) >> 1;
		}
		
		private static function dialogAddToStage(e:Event):void{
			var dialog:DisplayObject = e.currentTarget as DisplayObject;
			dialog.removeEventListener(Event.ADDED_TO_STAGE,dialogAddToStage);
			dialog.addEventListener(Event.REMOVED_FROM_STAGE,dialogRemoveFromStage);
			
			dialogs.push(dialog);
		}
		
		private static function dialogRemoveFromStage(e:Event):void{
			var dialog:DisplayObject = e.currentTarget as DisplayObject;
			dialog.removeEventListener(Event.REMOVED_FROM_STAGE,dialogRemoveFromStage);
			
			dialogs.pop();
			
			if(dialogs.length == 0){
				background.removeFromParent();
			}else{
				dialog = dialogs[dialogs.length-1];
				try{
					Starling.current.stage.swapChildren(background,dialog);
				} catch(error:Error) {}
			}
		}
		
		private static function initBackGround():void{
			if(background) return;
			background = new Quad(Starling.current.stage.stageWidth,Starling.current.stage.height,0x000000);
			background.alpha = 0.5;
		}
		
	}
}