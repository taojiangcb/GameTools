package com.utils
{
	/**
	 * Starling版本的setTimeout函数 基于starling的游戏时间轴时间
	 * @author JiangTao
	 */	
	public function ssetTimeout(func:Function,delay:Number,...parameter):int
	{
		return TimeoutUtils.createTimeOut(func,delay,parameter);
	}
}