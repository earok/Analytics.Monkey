
import com.testflightapp.lib.TestFlight;

class MonkeyTestFlight{
	public static void InitTestFlight(String ID){
		TestFlight.takeOff(BBAndroidGame.AndroidGame().GetActivity().getApplication(), ID);
	}
	public static void TestFlightCheckpoint(String Checkpoint){
		TestFlight.passCheckpoint(Checkpoint);
	}
}