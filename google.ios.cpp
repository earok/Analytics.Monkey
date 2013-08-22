#import "GAI.h"
#import "GAITracker.h"
#import "GAITrackedViewController.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
#import "GAILogger.h"

id<GAITracker> tracker;

void InitGoogleAnalytics(String GoogleAnalyticsID){
  // Optional: automatically send uncaught exceptions to Google Analytics.
  [GAI sharedInstance].trackUncaughtExceptions = YES;

  // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
  [GAI sharedInstance].dispatchInterval = 20;

  // Optional: set Logger to VERBOSE for debug information.
  [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];

  // Initialize tracker.
  tracker = [[GAI sharedInstance] trackerWithTrackingId:GoogleAnalyticsID.ToNSString()];

}

void GoogleAnalyticsEvent(String Category, String Action){

	[tracker send:[[GAIDictionaryBuilder createEventWithCategory:Category.ToNSString()
															action:Action.ToNSString()
															label:@""
															value:nil] build]];

}

void GoogleAnalyticsEvent(String Category, String Action, String Label){

	[tracker send:[[GAIDictionaryBuilder createEventWithCategory:Category.ToNSString()   
                                                  action:Action.ToNSString()  
                                                   label:Label.ToNSString()   
                                                   value:nil] build]];

}

void GoogleAnalyticsEvent(String Category, String Action, String Label,int Value){

	[tracker send:[[GAIDictionaryBuilder createEventWithCategory:Category.ToNSString()    
                                                  action:Action.ToNSString()  
                                                   label:Label.ToNSString()   
                                                   value:[NSNumber numberWithInt:Value]] build]];
}

void GoogleAnalyticsEvent(String Category, String Action, String Label,int Value,Boolean noTrack){
	GoogleAnalyticsEvent(Category,Action,Label,Value);
}

