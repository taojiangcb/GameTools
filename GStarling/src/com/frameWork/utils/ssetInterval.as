package com.frameWork.utils
{
	/**
	 * Starling版本的setInterval基于游戏的时间轴 
	 */	
	public function ssetInterval(func:Function,delay:Number,...parameter):int
	{
		return TimeoutUtils.createInterval(func,delay,parameter);
	}
}