#import "GAI.h"
#import "GAITracker.h"
#import "GAITrackedViewController.h"
#import "GAITransaction.h"
#import "GAITransactionItem.h"

id<GAITracker> tracker;

void InitGoogleAnalytics(String GoogleAnalyticsID){
  // Optional: automatically send uncaught exceptions to Google Analytics.
  [GAI sharedInstance].trackUncaughtExceptions = YES;
  // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
  [GAI sharedInstance].dispatchInterval = 20;
 // Optional: set debug to YES for extra debugging information.
  [GAI sharedInstance].debug = YES;
  // Create tracker instance.
  tracker = [[GAI sharedInstance] trackerWithTrackingId:GoogleAnalyticsID.ToNSString()];
}

void GoogleAnalyticsEvent(String Category, String Action){
	[tracker sendEventWithCategory:Category.ToNSString()
                     withAction:Action.ToNSString()
                      withLabel:@""
                      withValue:NULL];
}

void GoogleAnalyticsEvent(String Category, String Action, String Label){
	[tracker sendEventWithCategory:Category.ToNSString()
                     withAction:Action.ToNSString()
                      withLabel:Label.ToNSString()
                      withValue:NULL];
}

void GoogleAnalyticsEvent(String Category, String Action, String Label,int Value){
		[tracker sendEventWithCategory:Category.ToNSString()
                     withAction:Action.ToNSString()
                      withLabel:Label.ToNSString()
                      withValue:[NSNumber numberWithInt:Value]];
}

void GoogleAnalyticsEvent(String Category, String Action, String Label,int Value,Boolean noTrack){
	GoogleAnalyticsEvent(Category,Action,Label,Value);
}

