#If TARGET="ios"
	Import "testflight.ios.cpp"
	Extern		
	Function InitTestFlight(ID:String) = "InitTestFlight"
	Function TestFlightCheckpoint(Checkpoint:String) = "TestFlightCheckpoint"
#Else
Public
	Function InitTestFlight(ID:String)
	End
	Function TestFlightCheckpoint(Checkpoint:String)
	End
#Endif