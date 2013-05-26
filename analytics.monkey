'General purpose analytics library for Monkey.

#if TARGET="html5"
	Import "analytics.js"
	Extern
		Function InitGoogleAnalytics(ID:string) = "InitGoogleAnalytics"
		Function GoogleAnalyticsEvent(Category:String, Action:String, Label:StringObject = Null, Value:IntObject = Null, NoTrack:BoolObject = Null) = "GoogleAnalyticsEvent"
	Public
#else if TARGET="flash"
	Import "analytics.as"
	Extern
		Function InitGoogleAnalytics(ID:string) = "InitGoogleAnalytics"
		Function GoogleAnalyticsEvent(Category:String, Action:String, Label:StringObject = Null, Value:IntObject = Null, NoTrack:BoolObject = Null) = "GoogleAnalyticsEvent"
	Public
#else if TARGET="android"
	Import "analytics.java"
	Extern
		Function InitGoogleAnalytics(ID:string) = "Analytics.InitGoogleAnalytics"
		Function GoogleAnalyticsEvent(Category:String, Action:String) = "Analytics.GoogleAnalyticsEvent"
		Function GoogleAnalyticsEvent(Category:String, Action:String, Label:String) = "Analytics.GoogleAnalyticsEvent"
		Function GoogleAnalyticsEvent(Category:String, Action:String, Label:String, value:int) = "Analytics.GoogleAnalyticsEvent"
		Function GoogleAnalyticsEvent(Category:String, Action:String, Label:String, value:Int, notrack:Bool) = "Analytics.GoogleAnalyticsEvent"
	Public
#Else If TARGET="ios"
	Import "analytics.ios.cpp"
	Extern
		Function InitGoogleAnalytics(ID:string) = "InitGoogleAnalytics"
		Function GoogleAnalyticsEvent(Category:String, Action:String) = "GoogleAnalyticsEvent"
		Function GoogleAnalyticsEvent(Category:String, Action:String, Label:String) = "GoogleAnalyticsEvent"
		Function GoogleAnalyticsEvent(Category:String, Action:String, Label:String, value:int) = "GoogleAnalyticsEvent"
		Function GoogleAnalyticsEvent(Category:String, Action:String, Label:String, value:Int, notrack:Bool) = "GoogleAnalyticsEvent"
	Public
#Else
	Function InitGoogleAnalytics(ID:String)
	End
	Function GoogleAnalyticsEvent(Category:String, Action:String, Label:StringObject = Null, Value:IntObject = Null, NoTrack:BoolObject = Null)
	End
#endif
