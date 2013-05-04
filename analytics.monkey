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
#else
	Function InitGoogleAnalytics(ID:string)
	End
	Function GoogleAnalyticsEvent(Category:String, Action:String, Label:StringObject = Null, Value:IntObject = Null, NoTrack:BoolObject = Null)
	End
#endif
