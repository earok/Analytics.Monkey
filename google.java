import com.google.analytics.tracking.android.GoogleAnalytics;
import com.google.analytics.tracking.android.Tracker;
import com.google.analytics.tracking.android.EasyTracker;

class Analytics{

	static Tracker GATracker;

	public static void InitGoogleAnalytics(String ID){
		EasyTracker.getInstance().activityStart(BBAndroidGame.AndroidGame().GetActivity());
		GATracker = GoogleAnalytics.getInstance(BBAndroidGame.AndroidGame().GetActivity()).getTracker(ID);
	}
	
	public static void GoogleAnalyticsEvent(String category,String action){
		GATracker.sendEvent(category, action, "", null);
	}
	
	public static void GoogleAnalyticsEvent(String category,String action,String label){
		GATracker.sendEvent(category, action, label, null);
	}	
	
	public static void GoogleAnalyticsEvent(String category,String action,String label,long number){
		GATracker.sendEvent(category, action, label,number);
	}
	
	public static void GoogleAnalyticsEvent(String category,String action,String label,long number,Boolean noTrack){
		GATracker.sendEvent(category, action, label,number);
	}		
				
}