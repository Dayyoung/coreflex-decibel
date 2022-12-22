
if (document.createElement) {


	var action = "HOME";
	var name = "Samsung Electronics France";
	var category = "VIDE";
	var product = "VIDE";
	var reference = "0";
	var amount = "0";

	var ads = document.createElement('script');
	var refer = (window != window.top) ? document.referrer : document.location.href;
	var refer2 = (window != window.top) ? document.location.href : '';
	var re = document.referrer;
	if (ads) {
		ads.setAttribute("src", ('https:' == document.location.protocol ? 'https://' : 'http://') + "sv.ciblelink.com/profiling/dd.php?type=" + action + "&boutique=" + name + "&category_id=" + category + "&produit_id=" + product + "&transaction_amount=" + amount + "&transaction_id=" + reference +  '&refer=' + escape(refer) + "&refer2=" + escape(refer2) + "&re="+escape(re)+"&r=" + Math.round(Math.random() * 1000000000));
		ads.type = 'text/javascript';
		ads.async = "async";
		ads.defer = "defer";
		document.getElementsByTagName("head")[0].appendChild(ads);
	}
}
