
package zero{
	import starling.extensions.ColorArgb;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;

	public function updatePDParticleSystem(exhaust:PDParticleSystem,config:XML,texture:Texture=null):void{
		if(texture){
			if(exhaust.texture==texture){
			}else{
				exhaust.texture=texture;
			}
		}
		for each(var node:XML in config.children()){
			switch(node.name().toString()){
				case "maxParticles":
					exhaust.maxNumParticles=int(node.@value.toString());
				break;
				case "particleLifeSpan":
					exhaust.lifespan=Number(node.@value.toString());
				break;
				case "particleLifespanVariance":
					exhaust.lifespanVariance=Number(node.@value.toString());
				break;
				case "startParticleSize":
					exhaust.startSize=Number(node.@value.toString());
				break;
				case "startParticleSizeVariance":
					exhaust.startSizeVariance=Number(node.@value.toString());
				break;
				case "finishParticleSize":
					exhaust.endSize=Number(node.@value.toString());
				break;
				case "FinishParticleSizeVariance":
					exhaust.endSizeVariance=Number(node.@value.toString());
				break;
				case "angle":
					exhaust.emitAngle=Number(node.@value.toString())*(Math.PI/180);
				break;
				case "angleVariance":
					exhaust.emitAngleVariance=Number(node.@value.toString())*(Math.PI/180);
				break;
				case "rotationStart":
					exhaust.startRotation=Number(node.@value.toString())*(Math.PI/180);
				break;
				case "rotationStartVariance":
					exhaust.startRotationVariance=Number(node.@value.toString())*(Math.PI/180);
				break;
				case "rotationEnd":
					exhaust.endRotation=Number(node.@value.toString())*(Math.PI/180);
				break;
				case "rotationEndVariance":
					exhaust.endRotationVariance=Number(node.@value.toString())*(Math.PI/180);
				break;
				case "startColor":
					exhaust.startColor=new ColorArgb(Number(node.@red.toString()),Number(node.@green.toString()),Number(node.@blue.toString()),Number(node.@alpha.toString()));
				break;
				case "startColorVariance":
					exhaust.startColorVariance=new ColorArgb(Number(node.@red.toString()),Number(node.@green.toString()),Number(node.@blue.toString()),Number(node.@alpha.toString()));
				break;
				case "finishColor":
					exhaust.endColor=new ColorArgb(Number(node.@red.toString()),Number(node.@green.toString()),Number(node.@blue.toString()),Number(node.@alpha.toString()));
				break;
				case "finishColorVariance":
					exhaust.endColorVariance=new ColorArgb(Number(node.@red.toString()),Number(node.@green.toString()),Number(node.@blue.toString()),Number(node.@alpha.toString()));
				break;
				case "emitterType":
					exhaust.emitterType=int(node.@value.toString());
				break;
				case "sourcePositionVariance":
					exhaust.emitterXVariance=Number(node.@x.toString());
					exhaust.emitterYVariance=Number(node.@y.toString());
				break;
				case "speed":
					exhaust.speed=Number(node.@value.toString());
				break;
				case "speedVariance":
					exhaust.speedVariance=Number(node.@value.toString());
				break;
				case "gravity":
					exhaust.gravityX=Number(node.@x.toString());
					exhaust.gravityY=Number(node.@y.toString());
				break;
				case "radialAcceleration":
					exhaust.radialAcceleration=Number(node.@value.toString());
				break;
				case "radialAccelVariance":
					exhaust.radialAccelerationVariance=Number(node.@value.toString());
				break;
				case "tangentialAcceleration":
					exhaust.tangentialAcceleration=Number(node.@value.toString());
				break;
				case "tangentialAccelVariance":
					exhaust.tangentialAccelerationVariance=Number(node.@value.toString());
				break;
				case "maxRadius":
					exhaust.maxRadius=Number(node.@value.toString());
				break;
				case "maxRadiusVariance":
					exhaust.maxRadiusVariance=Number(node.@value.toString());
				break;
				case "minRadius":
					exhaust.minRadius=Number(node.@value.toString());
				break;
				case "rotatePerSecond":
					exhaust.rotatePerSecond=Number(node.@value.toString())*(Math.PI/180);
				break;
				case "rotatePerSecondVariance":
					exhaust.rotatePerSecondVariance=Number(node.@value.toString())*(Math.PI/180);
				break;
				case "blendFuncSource":
					exhaust.blendFactorSource=getBlendFunc(int(node.@value.toString()));
				break;
				case "blendFuncDestination":
					exhaust.blendFactorDestination=getBlendFunc(int(node.@value.toString()));
				break;
				//case "duration":
				//	<duration value="-1.00"/>
				//break;
				default:
					throw "未知 node："+node.toXMLString();
				break;
			}
		}
	}
}
import flash.display3D.Context3DBlendFactor;

function getBlendFunc(value:int):String
{
	switch (value)
	{
		case 0:     return Context3DBlendFactor.ZERO; break;
		case 1:     return Context3DBlendFactor.ONE; break;
		case 0x300: return Context3DBlendFactor.SOURCE_COLOR; break;
		case 0x301: return Context3DBlendFactor.ONE_MINUS_SOURCE_COLOR; break;
		case 0x302: return Context3DBlendFactor.SOURCE_ALPHA; break;
		case 0x303: return Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA; break;
		case 0x304: return Context3DBlendFactor.DESTINATION_ALPHA; break;
		case 0x305: return Context3DBlendFactor.ONE_MINUS_DESTINATION_ALPHA; break;
		case 0x306: return Context3DBlendFactor.DESTINATION_COLOR; break;
		case 0x307: return Context3DBlendFactor.ONE_MINUS_DESTINATION_COLOR; break;
		default:    throw new ArgumentError("unsupported blending function: " + value);
	}
}