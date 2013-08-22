'General purpose analytics library for Monkey.

'GOOGLE ANALYTICS IMPORTS
#If TARGET="html5"
	Import "google.js"
	Extern
		Function InitGoogleAnalytics(ID:String) = "InitGoogleAnalytics"
		Function GoogleAnalyticsEvent(Category:String, Action:String, Label:StringObject = Null, Value:IntObject = Null, NoTrack:BoolObject = Null) = "GoogleAnalyticsEvent"
	Public
#Else If TARGET="flash"
	Import "google.as"
	Extern
		Function InitGoogleAnalytics(ID:String) = "InitGoogleAnalytics"
		Function GoogleAnalyticsEvent(Category:String, Action:String, Label:StringObject = Null, Value:IntObject = Null, NoTrack:BoolObject = Null) = "GoogleAnalyticsEvent"
	Public
#Else If TARGET="android"
	Import "google.java"
	Extern
		Function InitGoogleAnalytics(ID:String) = "Analytics.InitGoogleAnalytics"
		Function GoogleAnalyticsEvent(Category:String, Action:String) = "Analytics.GoogleAnalyticsEvent"
		Function GoogleAnalyticsEvent(Category:String, Action:String, Label:String) = "Analytics.GoogleAnalyticsEvent"
		Function GoogleAnalyticsEvent(Category:String, Action:String, Label:String, value:Int) = "Analytics.GoogleAnalyticsEvent"
		Function GoogleAnalyticsEvent(Category:String, Action:String, Label:String, value:Int, notrack:Bool) = "Analytics.GoogleAnalyticsEvent"
	Public
#Else If TARGET="ios"
	Import "google.ios.cpp"
	Extern
		Function InitGoogleAnalytics(ID:String) = "InitGoogleAnalytics"
		Function GoogleAnalyticsEvent(Category:String, Action:String) = "GoogleAnalyticsEvent"
		Function GoogleAnalyticsEvent(Category:String, Action:String, Label:String) = "GoogleAnalyticsEvent"
		Function GoogleAnalyticsEvent(Category:String, Action:String, Label:String, value:Int) = "GoogleAnalyticsEvent"
		Function GoogleAnalyticsEvent(Category:String, Action:String, Label:String, value:Int, notrack:Bool) = "GoogleAnalyticsEvent"
	Public
#Else
	Function InitGoogleAnalytics(ID:String)
	End
	Function GoogleAnalyticsEvent(Category:String, Action:String, Label:StringObject = Null, Value:IntObject = Null, NoTrack:BoolObject = Null)
	End
#Endif