package de.liersch.util
{
	public final class Times
	{
		
		public static function secToTime(length:uint):String {
			var time:String = 
				(length % 60 > 9)  
				? (""  + length % 60) 
				: ("0" + length % 60); 
			
			time = uint(length / 60) + ":" + time;
			return time;
		}

	}
}