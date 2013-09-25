import com.google.analytics.tracking.android.EasyTracker;
import com.google.analytics.tracking.android.MapBuilder;

class Analytics{

	static EasyTracker easyTracker;

	public static void InitGoogleAnalytics(String ID){		
		EasyTracker.getInstance(BBAndroidGame.AndroidGame().GetActivity()).activityStart(BBAndroidGame.AndroidGame().GetActivity());
		easyTracker = EasyTracker.getInstance(BBAndroidGame.AndroidGame().GetActivity());
	}
	
	public static void GoogleAnalyticsEvent(String category,String action){
		easyTracker.send(MapBuilder.createEvent(category,action,null,null).build());
	}
	
	public static void GoogleAnalyticsEvent(String category,String action,String label){
		easyTracker.send(MapBuilder.createEvent(category,action,label,null).build());
	}	
	
	public static void GoogleAnalyticsEvent(String category,String action,String label,long number){
		easyTracker.send(MapBuilder.createEvent(category,action,label,number).build());
	}
	
	public static void GoogleAnalyticsEvent(String category,String action,String label,long number,Boolean noTrack){
		easyTracker.send(MapBuilder.createEvent(category,action,label,number).build());
	}		
				
}