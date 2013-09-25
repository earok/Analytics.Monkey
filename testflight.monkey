#If TARGET="ios"
	Import "testflight.ios.cpp"
	Extern		
	Function InitTestFlight(ID:String) = "InitTestFlight"
	Function TestFlightCheckpoint(Checkpoint:String) = "TestFlightCheckpoint"
#ElseIf TARGET="android"
	Import "testflight.java"
	Extern
	Function InitTestFlight(ID:String) = "MonkeyTestFlight.InitTestFlight"
	Function TestFlightCheckpoint(Checkpoint:String) = "MonkeyTestFlight.TestFlightCheckpoint"
#Else
Public
	Function InitTestFlight(ID:String)
	End
	Function TestFlightCheckpoint(Checkpoint:String)
	End
#Endif