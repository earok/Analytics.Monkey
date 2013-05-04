Import analytics

#If TARGET="html5"
Global target:String = "html5"
#ElseIf TARGET="flash"
Global target:String = "flash"
#else
Global target:String = "unknown"
#endif	

Const GoogleAnalyticsID:String = "UA-40621768-1" 'Replace this with your own analytics ID

Function Main()
	InitGoogleAnalytics(GoogleAnalyticsID)
	GoogleAnalyticsEvent("Test", "Test Ran", target, 1337, True)
End