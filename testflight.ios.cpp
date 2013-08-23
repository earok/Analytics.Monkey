#import "TestFlight.h"

void InitTestFlight(String TestFlightID){
	[TestFlight setOptions:@{ TFOptionDisableInAppUpdates : @YES }];
	[TestFlight takeOff:TestFlightID.ToNSString()];
}

void TestFlightCheckpoint(String Checkpoint){
	[TestFlight passCheckpoint:Checkpoint.ToNSString()];
}