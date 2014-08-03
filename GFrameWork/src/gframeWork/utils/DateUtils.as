package gframeWork.utils
{
	import gframeWork.utils.StringUtils;
	
	import mx.formatters.DateFormatter;
	import mx.utils.StringUtil;
	
	public class DateUtils
	{
		public static const MonthAndDay:String  	 		= "MM月DD日 J时N分";
		public static const YearMonthDayAmdTime:String		= "YYYY年MM月DD日 J时N分S秒"
		public static const HoursMinute:String		 		= "HH时NN分SS秒";
		public static const YearMonthDay:String		 		= "YYYY年MM月DD日";
		public static const NumberYearMonthDayTime:String	= "YYYY-MM-DD JJ:NN:SS";
		public static const YEAR_MONTH_DAY_HOUR_MINUTE:String = "YYYY-MM-DD JJ:NN";
		public static const MAIL_YEAR_MONTH_DAY:String = "YYYY/MM/DD";
		public static const MONTH_DAY_HOUR_MINUTE:String = "MM-DD JJ:NN";
		public static const MONTH_DAY:String = "MM-DD";
		public static const FONT_MONTH_DAY:String = "MM月DD日";
		public static const HOUR_MINUTE:String = "JJ:NN";
		public static const HOUR_STRING:String = "JJ";
		public static const DayTime : String				= "JJ:NN:SS";
		public static const MINUTE:uint = 60;
		public static const HOUR:uint = 60* 60;
		public static const DAY:uint = 24 * 60 * 60;
		
		/**
		 * 获取某一时间戳内的天数 
		 * @param unix
		 * @return 
		 * 
		 */		
		public static function getDays(unix:uint):uint
		{
			return unix / DAY;
		}
		
		/**
		 * 获取当前时间的星期值 
		 * @return 
		 * 
		 */
		public static function getWeek():String
		{
			var weekDayLabels:Array = new Array("周日",
				"周一",
				"周二",
				"周三",
				"周四",
				"周五",
				"周六");
			
			var localDate:Date = new Date();
			return (weekDayLabels[localDate.day]);
		}
		
		
		/**
		 * 获取最小的时间单位 
		 * @param val
		 * @return 
		 * 
		 */		
		public static function getMinTimeUint(val:Number):String
		{
			var tempTime:Number = val < 0 ? 0 : val;
			var timeH:int = tempTime/3600;
			var timeD:int = tempTime/86400;
			if(timeH<24)
				return timeH == 0 ? "1小时内" : timeH + "小时";
			else
				return timeD + "天";
			return "";
		}
		
		/**
		 * 获取大约时间
		 * @param val
		 * @return 
		 * 
		 */
		public static function getRemindTimeDes(val:Number):String
		{
			var tempTime:Number = val < 0 ? 0 : val;
			var tempTimeLimit:Number = (GetCurrentTime() - tempTime) < 0 ? 0 : (GetCurrentTime() - tempTime);
			var timeM:int = tempTimeLimit/60;
			var timeH:int = tempTimeLimit/3600;
			var timeD:int = tempTimeLimit/86400;
			if(timeM < 60)
			{
				return timeM + "分钟前";
			}
			else if(timeH<24)
			{
				return timeH + "小时前";
			}
			else
			{
				return timeD + "天前";
			}
			return "";
		}
		
		/**
		 * 返回当前本地的系统时间，以秒为单位 
		 * @return 
		 * 
		 */		
		public static function GetCurrentTime():uint
		{
			var localDate:Date = new Date();
			return (localDate.getTime() / 1000);
		}
		
		//### 返回距当前时间m个月的总秒数
		public static function GetMouthLaterTime(m:int):int
		{
		   var localDate:Date = new Date();
		   var mouth:Number =localDate.getMonth();
		   var year:Number =  localDate.getFullYear();
		   var day:Number = localDate.getDate();
		  
		   if((mouth + m) > 11)
		   {
		      mouth = mouth + m -11;
		      year  = year +1;
		   }
		   else
		   {
		     mouth = mouth + m;
		   }
		   var date:Date = new Date(year,mouth,day);
		   return (date.getTime()/1000 - localDate.getTime()/1000 );
		   
		}
		//### 计算以秒为单位的期限时间  返回字符串
		public static function GetMouthCount(limit:int):String
		{
			var count:int;
			var initdate:Date = new Date();
		    var enddate:Date  = new Date(limit*1000 + initdate.time);
		    if(enddate.getFullYear()>initdate.getFullYear())
		       {
		          count =  enddate.getMonth()+11 - initdate.getMonth();
		       
		       }
		       else
		       {
		        count = enddate.getMonth() - initdate.getMonth();
		   
		       }
		       switch(count)
		       {
		        case 1:
		           return "一个月";
		           break;
		        case 3:
		           return "三个月";
		            break;
		        case 6:
		           return "六个月";
		            break;
		        case 12:
		           return "一年";
		          break;
		       
		       }
		       
		       return "";
		}
		
		
		// 对以秒为单位的时间戳进行格式化
		public static function TimeStampFormat(timeStamp:uint):String
		{
			if(timeStamp<0) timeStamp = 0;
			
			var day:uint = Math.floor(timeStamp/3600/24);
			var hour:uint = Math.floor((timeStamp%(3600*24))/3600);
			var minute:uint = Math.floor(timeStamp%3600/60);
			var second:uint = Math.floor(timeStamp%60) >>0;
			hour += day*24;
			var str:String = StringUtil.substitute("{0}{1}{2}:{3}",
				//day>0?iString.Format("{0}天",day):
				"",
				hour > 0 ? StringUtils.padLeft(hour.toString(),"0",2) + ":" : "",
				StringUtils.padLeft(minute.toString(),"0",2),
				StringUtils.padLeft(second.toString(),"0",2)
			);
			return str;
		}
		
		// 对以秒为单位的时间戳进行格式化 00:00:00全格式
		public static function FullTimeStampFormat(timeStamp:uint):String
		{
			if(timeStamp<0) timeStamp = 0;
			
			var day:uint = Math.floor(timeStamp/3600/24);
			var hour:uint = Math.floor((timeStamp%(3600*24))/3600);
			var minute:uint = Math.floor(timeStamp%3600/60);
			var second:uint = Math.floor(timeStamp%60);
			hour += day*24;
			var str:String = StringUtil.substitute("{0}{1}:{2}:{3}",
				//day>0?iString.Format("{0}天",day):
				"",
				StringUtils.padLeft(hour.toString(),"0",2),
				StringUtils.padLeft(minute.toString(),"0",2),
				StringUtils.padLeft(second.toString(),"0",2)
			);
			return str;
		}
		
		
		// 对以秒为单位的时间戳进行格式化 00:00:00全格式
		public static function DayTimeStampFormat(timeStamp:uint):String
		{
			if(timeStamp<0) timeStamp = 0;
			
			var day:uint = Math.floor(timeStamp/3600/24);
			var hour:uint = Math.floor((timeStamp%(3600*24))/3600);
			var minute:uint = Math.floor(timeStamp%3600/60);
			var second:uint = Math.floor(timeStamp%60);
			var str:String = StringUtil.substitute("{0} {1}:{2}:{3}",
				day > 0 ? StringUtil.substitute("{0}天",day) : "",
				StringUtils.padLeft(hour.toString(),"0",2),
				StringUtils.padLeft(minute.toString(),"0",2),
				StringUtils.padLeft(second.toString(),"0",2)
			);
			return str;
		}
		
		//对时间戳进行时限格式化
		public static function TimeStampExpFormat(timeStamp:uint):String
		{
			if(timeStamp<0) timeStamp = 0;
			
			var day:uint = Math.floor(timeStamp/3600/24);
			var hour:uint = Math.floor((timeStamp%(3600*24))/3600);
			var minute:uint = Math.floor(timeStamp%3600/60);
			var second:uint = Math.floor(timeStamp%60);
			
			var str:String = StringUtil.substitute("{0}{1}{2}{3}",
				day>0?StringUtil.substitute("{0}天",day):"",
				hour>0?StringUtil.substitute("{0}小时",hour):"",
				hour>0?"":StringUtil.substitute("{0}分",minute),
				hour>0?"":StringUtil.substitute("{0}秒",second)
			);
			return str;
		}
		
        // 对日期进行的格式化
        // 默认YYYY-MM-DD
        public static function DateFormat(date:Date,format:String="YYYY-MM-DD"):String
        {
        	var dateFormat:DateFormatter = new DateFormatter();
        	dateFormat.formatString = format;
        	return dateFormat.format(date);
        }
		
		public static function MonDayFormat(date:Date,format:String = MONTH_DAY):String
		{
			var dateFormat:DateFormatter = new DateFormatter();
			dateFormat.formatString = format;
			return dateFormat.format(date);
		}
		
		public static function HourMinuteFormat(date:Date,format:String = HOUR_MINUTE):String
		{
			var dateFormat:DateFormatter = new DateFormatter();
			dateFormat.formatString = format;
			return dateFormat.format(date);
		}
		
		public static function GetTitleDateStringByTimeStamp(unix:uint):String
		{
			var returnString:String;
			var date:Date = new Date(unix * 1000);
			var curDate:Date = new Date();	
			var dayNum:uint = unix / DAY;
			var curDayNum:uint = curDate.getTime() / (DAY * 1000);
			if(curDayNum < dayNum) 
			{
				return null;	
			}
			if(curDayNum == dayNum) {
				returnString = DateFormat(date,HOUR_MINUTE);
			}else if(curDayNum == dayNum + 1)
			{
				if(date.getDate() != curDate.getDate())
				returnString = "昨日";
			}else if(curDayNum == dayNum+2)
			{
				returnString = "前日";
			}else
			{
				returnString = DateFormat(date,MONTH_DAY);
			}
			return returnString;
		}
		
		public static function GetBattleFieldDateByTimeStamp(unix:uint):String
		{
			var returnString:String;
			var date:Date = new Date(unix * 1000);
			var curDate:Date = new Date();	
			var dayNum:uint = unix / DAY;
			var curDayNum:uint = curDate.getTime() / (DAY * 1000);
			if(curDayNum < dayNum) 
			{
				return null;	
			}
			if(curDayNum == dayNum) {
				returnString = DateFormat(date,HOUR_MINUTE);
			}else if(curDayNum == dayNum + 1)
			{
				if(date.getDate() != curDate.getDate())
				returnString = "昨日 " + DateFormat(date,HOUR_MINUTE);
				else
				returnString =  DateFormat(date,HOUR_MINUTE);
			}else if(curDayNum == dayNum+2)
			{
				if(date.getDate() != (curDate.getDate()-1))
				returnString = "前日 "+ DateFormat(date,HOUR_MINUTE);
				else
				returnString = "昨日 " + DateFormat(date,HOUR_MINUTE);
			}else
			{
				returnString = DateFormat(date,"MM-DD JJ:NN");
			}
			return returnString;
		}
		
		public static function GetMailDateByTimeStamp(unix:uint):String
		{
			//获取书信列表里的时间格式
			var returnString:String;
			var date:Date = new Date(unix * 1000);
			var curDate:Date = new Date();
			var curDayNum:uint = curDate.getTime() / (DAY * 1000);
			var dayNum:uint = unix / DAY;
			if(curDayNum < dayNum)
			{
				return null;
			}
			if(curDayNum == dayNum) {
				returnString = DateFormat(date,HOUR_MINUTE);
			}else if(DateFormat(date,"YYYY") != DateFormat(curDate,"YYYY"))
			{
				returnString = DateFormat(date,MAIL_YEAR_MONTH_DAY)
			}else
			{
				returnString = DateFormat(date,FONT_MONTH_DAY);
			}
			return returnString;
		}
		
		
		public static function GetInfoDateStringByTimeStamp(unix:uint):String
		{
			var date:Date = new Date(unix * 1000);
			var returnString:String = DateFormat(date,YEAR_MONTH_DAY_HOUR_MINUTE);
			return returnString;
		}

		public static function GetMailInfoDateByTimeStamp(unix:uint):String
		{
			var date:Date = new Date(unix * 1000);
			var returnString:String = DateFormat(date,MONTH_DAY_HOUR_MINUTE);
			return returnString;
		}
		
		/**
		 * 聊天系统时间 HH:MM
		 * @return 
		 * 
		 */
		public static function GetChatDateByTimeStamp():String
		{
			var localDate:Date = new Date();
			var returnString:String = DateFormat(localDate,HOUR_MINUTE);
			return returnString;
		}
		
		/**
		 * 根据时间戳返回聊天系统时间 HH:MM
		 * @return 
		 * 
		 */
		public static function GetChatTimeByTimeStamp(value:uint):String
		{
			var date:Date = new Date(value * 1000);
			var returnString:String = DateFormat(date,HOUR_MINUTE);
			return returnString;
		}
		
		/**
		 * 获取时间格式
		 * @param unix 
		 * @return (HH:NN:SS)
		 * 
		 */		
		public static function GetDayTimeByTimeStamp(unix:uint):String
		{
			var date:Date = new Date(unix * 1000);
			var returnString:String = DateFormat(date,DayTime);
			return returnString;
		}
		
		/**
		 * 获取剩余时间格式 
		 * @param unix 时间戳差值
		 * @return (xx天xx小时xx分)
		 * 
		 */		
		public static function GetTimeByTimeInterval(time:Number):String
		{
			var day:int = time / DAY;
			var hour:int = time % DAY / HOUR;
			var minute:int = time % HOUR / MINUTE;
			var str:String = StringUtil.substitute("{0}{1}{2}",
				day > 0 ? StringUtil.substitute("{0}天",day) : "",
				hour > 0 ? StringUtil.substitute("{0}小时",hour) : "",
				StringUtil.substitute("{0}分",minute));
				
			if(int(time) == 0)
			{
				str = "已过期";
			}
			return str;
		}
	}
}