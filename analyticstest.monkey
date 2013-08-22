Import google
Import mojo

#If TARGET="html5"
Global target:String = "html5"
#Elseif TARGET="flash"
Global target:String = "flash"
#Elseif TARGET="android"
Global target:String = "android"
#Elseif TARGET="ios"
Global target:String = "ios"
#Elseif
Global target:String = "unknown"
#Endif	

Const GoogleAnalyticsID:String = "UA-41034489-1" 'Replace this with your own analytics ID

Function Main()
	New AnalyticsTest()
End

Class AnalyticsTest Extends App
	
	Field PrintBuffer:=New List<String>
	
	Method AddToPrintBuffer(S:String)
		PrintBuffer.AddLast(S)
		Print S
	End	
	
	Method OnCreate()
		InitGoogleAnalytics(GoogleAnalyticsID)
		GoogleAnalyticsEvent("Test", "Test Ran", target, 1337, True)
		AddToPrintBuffer("Ran Google Analytics test successfully")
		SetUpdateRate 60
	End
	
	Method OnRender()
		Cls
		Local index = 0
		For Local pb:= Eachin PrintBuffer
			DrawText pb, 0, index * 16
			index += 1
		Next
	End
End