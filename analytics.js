var _gaq;

function InitGoogleAnalytics(ID){
	_gaq = _gaq || [];
	_gaq.push(['_setAccount', ID]);
 	_gaq.push(['_trackPageview']);
	_gaq.push(['_setDomainName', 'none']);
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
	
}

function GoogleAnalyticsEvent(Category,Action,Label,Value,NoTrack){

	if(!Label){
		_gaq.push(['_trackEvent', Category, Action]);
	}else if(!Value){
		_gaq.push(['_trackEvent', Category, Action, Label.f_value]);
	}else if(!NoTrack){
		_gaq.push(['_trackEvent', Category, Action, Label.f_value, Value.f_value]);
	}else{
		_gaq.push(['_trackEvent', Category, Action, Label.f_value, Value.f_value, NoTrack.f_value]);
	}

}