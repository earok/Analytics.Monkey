import com.google.analytics.AnalyticsTracker;
import com.google.analytics.GATracker;
var tracker:AnalyticsTracker;

function InitGoogleAnalytics(ID:String):void{
	tracker = new GATracker( BBFlashGame.FlashGame().GetDisplayObjectContainer(), ID, "AS3", false );
	tracker.setDomainName("none");
}

function GoogleAnalyticsEvent(category:String,action:String,label:c_StringObject=null,number:c_IntObject=null,notrack:c_BoolObject=null):void{
	
	if(label==null){
		tracker.trackEvent(category, action);
	}else if(number==null){
		tracker.trackEvent(category,action,label.m_value);
	}else{
		tracker.trackEvent(category,action,label.m_value,number.m_value);
	}
}