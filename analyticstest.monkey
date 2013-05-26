Import analytics
Import mojo

#If TARGET="html5"
Global target:String = "html5"
#ElseIf TARGET="flash"
Global target:String = "flash"
#elseIF TARGET="android"
Global target:String = "android"
#Elseif TARGET="ios"
Global target:String = "ios"
#Elseif
Global target:String = "unknown"
#endif	

Const GoogleAnalyticsID:String = "UA-41034489-1" 'Replace this with your own analytics ID

Function Main()
	New AnalyticsTest()
End

Class AnalyticsTest Extends App
	Method OnCreate()
		InitGoogleAnalytics(GoogleAnalyticsID)
		GoogleAnalyticsEvent("Test", "Test Ran", target, 1337, True)
	End
End