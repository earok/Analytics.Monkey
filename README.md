Analytics.Monkey
================

General purpose Analytics module for Monkey

Release into public domain 3-May-2013 by Erik Hogan

CURRENT ANALYTICS API SUPPORT:

Only Google Analytics

CURRENT PLATFORM SUPPORT:

- HTML5
- Flash

GENERAL INSTRUCTIONS:

Currently there's only two functions: InitGoogleAnalytics (which initializes the connection to Google Analytics, just pass your Google Analytics key to the function) and GoogleAnalyticsEvent (which logs an event with Google Analytics).

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

That's it!