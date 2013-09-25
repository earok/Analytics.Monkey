Analytics.Monkey
================

General purpose Analytics module for Monkey

Release into public domain 3-May-2013 by Erik Hogan

CURRENT ANALYTICS API AND PLATFORM SUPPORT:

Google Analytics: iOS, Android, HTML5, Flash
Test Flight: iOS, Android

================
GOOGLE ANALYTICS 
================
GENERAL INSTRUCTIONS:

Currently there's only two functions: 

- InitGoogleAnalytics(GoogleAnalyticsID:string) (initialises the connection to Google Analytics)
- GoogleAnalyticsEvent(Category:string,Action:string,Label:string,Value:int,NoTrack:bool) (which logs an event with Google Analytics).

The arguments of the GoogleAnalyticsEvents are:
- CATEGORY, Mandatory, the category of Event
- ACTION, Mandatory, the type of action that triggered this Event
- LABEL, Optional, an optional label for the Event
- VALUE, Optional, an integer value linked to this Event
- NOTRACK, Optional, simply means don't count this Event other statistics (Bounce etc). HTML5 only.


HTML5:

Nothing special needs to be done to get this to work on the HTML5 target. Just include the analytics module and you're set.


FLASH:

You need to download the Google Analytics for flash source from https://code.google.com/p/gaforflash/downloads/list, and put the lib/analytics.swc file into flex/frameworks/libs. Next edit the flex/frameworks/flex-config.xml file, add a reference to the library in the libraries section:

<runtime-shared-library-path>
<path-element>libs/analytics.swc</path-element>
</runtime-shared-library-path>


ANDROID:

Download Google Analytics for Android V3 (https://developers.google.com/analytics/devguides/collection/android/resources), and put libGoogleAnalyticsServices.jar in the /libs path in your Monkey Android build.

Next, create /res/values/analytics.xml and insert this as the contents (replace stand in analytics ID with your own):

<?xml version="1.0" encoding="utf-8" ?>

<resources>
  <!--Replace placeholder ID with your tracking ID-->
  <string name="ga_trackingId">UA-XXXX-Y</string>

  <!--Enable automatic activity tracking-->
  <bool name="ga_autoActivityTracking">true</bool>

  <!--Enable automatic exception tracking-->
  <bool name="ga_reportUncaughtExceptions">true</bool>
</resources>


iOS:

Download Google Analytics for iOS 3.0 from https://developers.google.com/analytics/devguides/collection/ios/resources.

Add all of the files from the Library folder (seven) into your Build folder, as well as libGoogleAnalyticsServices.a.

Add the following libraries to your XCode project (Linked Frameworks and Libraries section)

- AdSupport.framework
- libz.dylib
- libGoogleAnalyticsServices.a
- SystemConfiguration.framework
- CoreData.framework

===========
TEST FLIGHT
===========
GENERAL INSTRUCTIONS:

There are only two Functions:

- InitTestFlight(id:string), this initialises your TestFlight connection
- TestFlightCheckpoint(checkpoint:string), this records a TestFlight checkpoint

Once Test Flight has been initialised, it should record crash details automatically.

ANDROID:

Download the testflight APK, extract TestFlightLib to the libs folder in your Android build folder.

Go into your templates/AndroidManifest.xml file and make sure the SDK versions are 8 at the very minimum, ie:
<uses-sdk android:minSdkVersion="8" android:targetSdkVersion="8" />


iOS:

Download the testflight APK, extract the contents to the build folder.

Add the following libraries to your XCode project (Linked Frameworks and Libraries section)
(Unsure if all are necessary other than the last one)

- AdSupport.framework
- libz.dylib
- SystemConfiguration.framework
- CoreData.framework
- libTestFlight.a