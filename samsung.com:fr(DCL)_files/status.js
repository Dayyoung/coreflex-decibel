(function(e,f){try{var b={};b.o=e;b.status=f;b.g=null;b.l=function(a){try{document.readyState&&"loading"!==document.readyState?a():document.addEventListener?document.addEventListener("DOMContentLoaded",a):document.attachEvent("onreadystatechange",function(){"complete"===document.readyState&&a()})}catch(c){a()}};b.m=function(a){try{if(/^https:\/\/trk.datnova.com/.test(a.origin)||/^https:\/\/trck.datnova.com/.test(a.origin)){var c=JSON.parse(a.data),g=a.source||window.parent;if(c.message&&c.token)if(!c.url)b.s=
c.token,g.postMessage(JSON.stringify({message:"TCF Consent Check Script Request",token:c.token,type:b.status,pid:b.o}),a.origin);else if(b.s==c.token){c.referer&&(window.actualReferer=c.referer);var d=document.createElement("script");d.src=c.url;(document.head||document.getElementsByTagName("head")[0]).appendChild(d)}}}catch(h){}};b.i=function(){return ((window.self==window.top&&("undefined"==typeof window.toplevel||window.self == window.toplevel))?"prod":"preprod")};b.h=function(){if("undefined"!==typeof window.__tcfapi&&(window.__tcfapi("ping",2,function(){b.g=!0}),b.g)){window.__tcfapi("addEventListener",
2,function(a,c){if(c&&a){if(!a.gdprApplies||"tcloaded"===a.eventStatus||"useractioncomplete"===a.eventStatus||"cmpuishown"===a.eventStatus)if(!a.gdprApplies||a.tcString&&a.purpose&&a.purpose.consents&&a.purpose.consents[1])return window.cookielessAds={isTCF:!0,tcfConsent:!0,tcString:a.tcString},!0;window.cookielessAds={isTCF:!0,tcfConsent:!1,tcString:a.tcString}}});return}window.cookielessAds={isTCF:!1,tcfConsent:!1,tcString:null}};b.j=function(){"preprod"==b.i()?(window.addEventListener("message",
b.m,!1),window.parent.postMessage(JSON.stringify({tcfApiLocator:!0}),"*")):b.l(b.h)};b.j()}catch(a){}})("23079","cookiebased");