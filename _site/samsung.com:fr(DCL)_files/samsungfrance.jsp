Array.prototype.filter||(Array.prototype.filter=function(t,e){"use strict";if("Function"!=typeof t&&"function"!=typeof t||!this)throw new TypeError;var r=this.length>>>0,o=new Array(r),n=this,l=0,i=-1;if(void 0===e)for(;++i!==r;)i in this&&t(n[i],i,n)&&(o[l++]=n[i]);else for(;++i!==r;)i in this&&t.call(e,n[i],i,n)&&(o[l++]=n[i]);return o.length=l,o}),Array.prototype.forEach||(Array.prototype.forEach=function(t){var e,r;if(null==this)throw new TypeError('"this" is null or not defined');var o=Object(this),n=o.length>>>0;if("function"!=typeof t)throw new TypeError(t+" is not a function");for(arguments.length>1&&(e=arguments[1]),r=0;r<n;){var l;r in o&&(l=o[r],t.call(e,l,r,o)),r++}}),window.NodeList&&!NodeList.prototype.forEach&&(NodeList.prototype.forEach=Array.prototype.forEach),Array.prototype.indexOf||(Array.prototype.indexOf=function(t,e){var r;if(null==this)throw new TypeError('"this" is null or not defined');var o=Object(this),n=o.length>>>0;if(0===n)return-1;var l=0|e;if(l>=n)return-1;for(r=Math.max(l>=0?l:n-Math.abs(l),0);r<n;){if(r in o&&o[r]===t)return r;r++}return-1}),document.getElementsByClassName||(document.getElementsByClassName=function(t){var e,r,o,n=document,l=[];if(n.querySelectorAll)return n.querySelectorAll("."+t);if(n.evaluate)for(r=".//*[contains(concat(' ', @class, ' '), ' "+t+" ')]",e=n.evaluate(r,n,null,0,null);o=e.iterateNext();)l.push(o);else for(e=n.getElementsByTagName("*"),r=new RegExp("(^|\\s)"+t+"(\\s|$)"),o=0;o<e.length;o++)r.test(e[o].className)&&l.push(e[o]);return l}),document.querySelectorAll||(document.querySelectorAll=function(t){var e,r=document.createElement("style"),o=[];for(document.documentElement.firstChild.appendChild(r),document._qsa=[],r.styleSheet.cssText=t+"{x-qsa:expression(document._qsa && document._qsa.push(this))}",window.scrollBy(0,0),r.parentNode.removeChild(r);document._qsa.length;)(e=document._qsa.shift()).style.removeAttribute("x-qsa"),o.push(e);return document._qsa=null,o}),document.querySelector||(document.querySelector=function(t){var e=document.querySelectorAll(t);return e.length?e[0]:null}),Object.keys||(Object.keys=function(){"use strict";var t=Object.prototype.hasOwnProperty,e=!{toString:null}.propertyIsEnumerable("toString"),r=["toString","toLocaleString","valueOf","hasOwnProperty","isPrototypeOf","propertyIsEnumerable","constructor"],o=r.length;return function(n){if("function"!=typeof n&&("object"!=typeof n||null===n))throw new TypeError("Object.keys called on non-object");var l,i,s=[];for(l in n)t.call(n,l)&&s.push(l);if(e)for(i=0;i<o;i++)t.call(n,r[i])&&s.push(r[i]);return s}}()),"function"!=typeof String.prototype.trim&&(String.prototype.trim=function(){return this.replace(/^\s+|\s+$/g,"")}),String.prototype.replaceAll||(String.prototype.replaceAll=function(t,e){return"[object regexp]"===Object.prototype.toString.call(t).toLowerCase()?this.replace(t,e):this.replace(new RegExp(t,"g"),e)}),window.hasOwnProperty=window.hasOwnProperty||Object.prototype.hasOwnProperty;
if (typeof usi_commons === 'undefined') {
	usi_commons = {
		
		debug: location.href.indexOf("usidebug") != -1 || location.href.indexOf("usi_debug") != -1,
		
		log:function(msg) {
			if (usi_commons.debug) {
				try {
					if (msg instanceof Error) {
						console.log(msg.name + ': ' + msg.message);
					} else {
						console.log.apply(console, arguments);
					}
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		log_error: function(msg) {
			if (usi_commons.debug) {
				try {
					if (msg instanceof Error) {
						console.log('%c USI Error:', usi_commons.log_styles.error, msg.name + ': ' + msg.message);
					} else {
						console.log('%c USI Error:', usi_commons.log_styles.error, msg);
					}
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		log_success: function(msg) {
			if (usi_commons.debug) {
				try {
					console.log('%c USI Success:', usi_commons.log_styles.success, msg);
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		dir:function(obj) {
			if (usi_commons.debug) {
				try {
					console.dir(obj);
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		log_styles: {
			error: 'color: red; font-weight: bold;',
			success: 'color: green; font-weight: bold;'
		},
		domain: "https://app.upsellit.com",
		cdn: "https://www.upsellit.com",
		is_mobile: (/iphone|ipod|ipad|android|blackberry|mobi/i).test(navigator.userAgent.toLowerCase()),
		device: (/iphone|ipod|ipad|android|blackberry|mobi/i).test(navigator.userAgent.toLowerCase()) ? 'mobile' : 'desktop',
		gup:function(name) {
			try {
				name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
				var regexS = "[\\?&]" + name + "=([^&#\\?]*)";
				var regex = new RegExp(regexS);
				var results = regex.exec(window.location.href);
				if (results == null) return "";
				else return results[1];
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_script:function(source, callback, nocache) {
			try {
				if (source.indexOf("//www.upsellit.com") == 0) source = "https:"+source; //upgrade non-secure requests
				var docHead = document.getElementsByTagName("head")[0];
				if (top.location != location) docHead = parent.document.getElementsByTagName("head")[0];
				var newScript = document.createElement('script');
				newScript.type = 'text/javascript';
				var usi_appender = "";
				if (!nocache && source.indexOf("/active/") == -1 && source.indexOf("_pixel.jsp") == -1 && source.indexOf("_throttle.jsp") == -1 && source.indexOf("metro") == -1 && source.indexOf("_suppress") == -1 && source.indexOf("product_recommendations.jsp") == -1 && source.indexOf("_pid.jsp") == -1 && source.indexOf("_zips") == -1) {
					usi_appender = (source.indexOf("?")==-1?"?":"&");
					if (source.indexOf("pv2.js") != -1) usi_appender = "%7C";
					usi_appender += "si=" + usi_commons.get_sess();
				}
				newScript.src = source + usi_appender;
				if (typeof callback == "function") {
					newScript.onload = function() {
						try {
							callback();
						} catch (e) {
							usi_commons.report_error(e);
						}
					};
				}
				docHead.appendChild(newScript);
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_display:function(usiQS, usiSiteID, usiKey, callback) {
			try {
				usiKey = usiKey || "";
				var source = usi_commons.domain + "/launch.jsp?qs=" + usiQS + "&siteID=" + usiSiteID + "&keys=" + usiKey;
				usi_commons.load_script(source, callback);
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_view:function(usiHash, usiSiteID, usiKey, callback) {
			try {
				if (typeof(usi_force) != "undefined" || location.href.indexOf("usi_force") != -1 || (usi_cookies.get("usi_sale") == null && usi_cookies.get("usi_launched") == null && usi_cookies.get("usi_launched"+usiSiteID) == null)) {
					usiKey = usiKey || "";
					var usi_append = "";
					if (usi_commons.gup("usi_force_date") != "") usi_append = "&usi_force_date=" + usi_commons.gup("usi_force_date");
					else if (typeof usi_cookies !== 'undefined' && usi_cookies.get("usi_force_date") != null) usi_append = "&usi_force_date=" + usi_cookies.get("usi_force_date");
					if (usi_commons.debug) usi_append += "&usi_referrer="+encodeURIComponent(location.href);
					var source = usi_commons.domain + "/view.jsp?hash=" + usiHash + "&siteID=" + usiSiteID + "&keys=" + usiKey + usi_append;
					if (typeof(usi_commons.last_view) !== "undefined" && usi_commons.last_view == usiSiteID+"_"+usiKey) return;
					usi_commons.last_view = usiSiteID+"_"+usiKey;
					if (typeof usi_js !== 'undefined' && typeof usi_js.cleanup === 'function') usi_js.cleanup();
					usi_commons.load_script(source, callback);
				}
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		remove_loads:function() {
			try {
				if (document.getElementById("usi_obj") != null) {
					document.getElementById("usi_obj").parentNode.parentNode.removeChild(document.getElementById("usi_obj").parentNode);
				}
				if (typeof(usi_commons.usi_loads) !== "undefined") {
					for (var i in usi_commons.usi_loads) {
						if (document.getElementById("usi_"+i) != null) {
							document.getElementById("usi_"+i).parentNode.parentNode.removeChild(document.getElementById("usi_"+i).parentNode);
						}
					}
				}
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load:function(usiHash, usiSiteID, usiKey, callback){
			try {
				if (typeof(window["usi_" + usiSiteID]) !== "undefined") return;
				usiKey = usiKey || "";
				var usi_append = "";
				if (usi_commons.gup("usi_force_date") != "") usi_append = "&usi_force_date=" + usi_commons.gup("usi_force_date");
				else if (typeof usi_cookies !== 'undefined' && usi_cookies.get("usi_force_date") != null) usi_append = "&usi_force_date=" + usi_cookies.get("usi_force_date");
				if (usi_commons.debug) usi_append += "&usi_referrer="+encodeURIComponent(location.href);
				var source = usi_commons.domain + "/usi_load.jsp?hash=" + usiHash + "&siteID=" + usiSiteID + "&keys=" + usiKey + usi_append;
				usi_commons.load_script(source, callback);
				if (typeof(usi_commons.usi_loads) === "undefined") {
					usi_commons.usi_loads = {};
				}
				usi_commons.usi_loads[usiSiteID] = usiSiteID;
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_precapture:function(usiQS, usiSiteID, callback) {
			try {
				var source = usi_commons.domain + "/hound/monitor.jsp?qs=" + usiQS + "&siteID=" + usiSiteID;
				usi_commons.load_script(source, callback);
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_mail:function(qs, siteID, callback) {
			try {
				var source = usi_commons.domain + "/mail.jsp?qs=" + qs + "&siteID=" + siteID + "&domain=" + encodeURIComponent(usi_commons.domain);
				usi_commons.load_script(source, callback);
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		send_prod_rec:function(siteID, info, real_time) {
			var result = false;
			try {
				if (document.getElementsByTagName("html").length > 0 && document.getElementsByTagName("html")[0].className != null && document.getElementsByTagName("html")[0].className.indexOf("translated") != -1) {
					//Ignore translated pages
					return false;
				}
				var data = [siteID, info.name, info.link, info.pid, info.price, info.image];
				if (data.indexOf(undefined) == -1) {
					var queryString = [siteID, info.name.replace(/\|/g, "&#124;"), info.link, info.pid, info.price, info.image].join("|") + "|";
					if (info.extra) queryString += info.extra + "|";
					var filetype = real_time ? "jsp" : "js";
					usi_commons.load_script(usi_commons.domain + "/utility/pv2." + filetype + "?" + encodeURIComponent(queryString));
					result = true;
				}
			} catch (e) {
				usi_commons.report_error(e);
				result = false;
			}
			return result;
		},
		report_error:function(err) {
			if (err == null) return;
			if (typeof err === 'string') err = new Error(err);
			if (!(err instanceof Error)) return;
			if (typeof(usi_commons.error_reported) !== "undefined") {
				return;
			}
			usi_commons.error_reported = true;
			if (location.href.indexOf('usishowerrors') !== -1) throw err;
			else usi_commons.load_script(usi_commons.domain + '/err.jsp?oops=' + encodeURIComponent(err.message) + '-' + encodeURIComponent(err.stack) + "&url=" + encodeURIComponent(location.href));
			usi_commons.log_error(err.message);
			usi_commons.dir(err);
		},
		report_error_no_console:function(err) {
			if (err == null) return;
			if (typeof err === 'string') err = new Error(err);
			if (!(err instanceof Error)) return;
			if (typeof(usi_commons.error_reported) !== "undefined") {
				return;
			}
			usi_commons.error_reported = true;
			if (location.href.indexOf('usishowerrors') !== -1) throw err;
			else usi_commons.load_script(usi_commons.domain + '/err.jsp?oops=' + encodeURIComponent(err.message) + '-' + encodeURIComponent(err.stack) + "&url=" + encodeURIComponent(location.href));
		},
		gup_or_get_cookie: function(name, expireSeconds, forceCookie) {
			try {
				if (typeof usi_cookies === 'undefined') {
					usi_commons.log_error('usi_cookies is not defined');
					return;
				}
				expireSeconds = (expireSeconds || usi_cookies.expire_time.day);
				if (name == "usi_enable") expireSeconds = usi_cookies.expire_time.hour;
				var value = null;
				var qsValue = usi_commons.gup(name);
				if (qsValue !== '') {
					value = qsValue;
					usi_cookies.set(name, value, expireSeconds, forceCookie);
				} else {
					value = usi_cookies.get(name);
				}
				return (value || '');
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		get_sess: function() {
			var usi_si = null;
			if (typeof(usi_cookies) === "undefined") return "";
			try {
				if (usi_cookies.get('usi_si') == null) {
					var usi_rand_str = Math.random().toString(36).substring(2);
					if (usi_rand_str.length > 6) usi_rand_str = usi_rand_str.substring(0, 6);
					usi_si = usi_rand_str + "_" + Math.round((new Date()).getTime() / 1000);
					usi_cookies.set('usi_si', usi_si, 24*60*60);
					return usi_si;
				}
				if (usi_cookies.get('usi_si') != null) usi_si = usi_cookies.get('usi_si');
				usi_cookies.set('usi_si', usi_si, 24*60*60);
			} catch(err) {
				usi_commons.report_error(err);
			}
			return usi_si;
		},
		get_id: function(usi_append) {
			if (!usi_append) usi_append = "";
			var usi_id = null;
			try {
				if (usi_cookies.get('usi_v') == null && usi_cookies.get('usi_id'+usi_append) == null) {
					var usi_rand_str = Math.random().toString(36).substring(2);
					if (usi_rand_str.length > 6) usi_rand_str = usi_rand_str.substring(0, 6);
					usi_id = usi_rand_str + "_" + Math.round((new Date()).getTime() / 1000);
					usi_cookies.set('usi_id'+usi_append, usi_id, 30 * 86400, true);
					return usi_id;
				}
				if (usi_cookies.get('usi_v') != null) usi_id = usi_cookies.get('usi_v');
				if (usi_cookies.get('usi_id'+usi_append) != null) usi_id = usi_cookies.get('usi_id'+usi_append);
				usi_cookies.set('usi_id'+usi_append, usi_id, 30 * 86400, true);
			} catch(err) {
				usi_commons.report_error(err);
			}
			return usi_id;
		},
		load_session_data: function(extended) {
			try {
				if (usi_cookies.get_json("usi_session_data") == null) {
					usi_commons.load_script(usi_commons.domain + '/utility/session_data.jsp?extended=' + (extended?"true":"false"));
				} else {
					usi_app.session_data = usi_cookies.get_json("usi_session_data");
					if (typeof(usi_app.session_data_callback) !== "undefined") {
						usi_app.session_data_callback();
					}
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
		}
	};
	setTimeout(function() {
		try {
			if (usi_commons.gup_or_get_cookie("usi_debug") != "") usi_commons.debug = true;
			if (usi_commons.gup_or_get_cookie("usi_qa") != "") {
				usi_commons.domain = usi_commons.cdn = "https://prod.upsellit.com";
			}
		} catch(err) {
			usi_commons.report_error(err);
		}
	}, 1000);
}

usi_cookieless = "1";
usi_session_storage = "1";
if (typeof (usi_app) == "undefined") {
	if("undefined"==typeof usi_cookies&&(usi_cookies={expire_time:{minute:60,hour:3600,two_hours:7200,four_hours:14400,day:86400,week:604800,two_weeks:1209600,month:2592e3,year:31536e3,never:31536e4},max_cookies_count:15,max_cookie_length:1e3,update_window_name:function(e,o,i){try{var n=-1;if(-1!=i){var t=new Date;t.setTime(t.getTime()+1e3*i),n=t.getTime()}var r=window.top||window,s=0;null!=o&&-1!=o.indexOf("=")&&(o=o.replace(new RegExp("=","g"),"USIEQLS")),null!=o&&-1!=o.indexOf(";")&&(o=o.replace(new RegExp(";","g"),"USIPRNS"));for(var a=r.name.split(";"),u="",c=0;c<a.length;c++){var l=a[c].split("=");3==l.length?(l[0]==e&&(l[1]=o,l[2]=n,s=1),null!=l[1]&&"null"!=l[1]&&(u+=l[0]+"="+l[1]+"="+l[2]+";")):""!=a[c]&&(u+=a[c]+";")}0==s&&(u+=e+"="+o+"="+n+";"),r.name=u}catch(e){}},flush_window_name:function(e){try{for(var o=window.top||window,i=o.name.split(";"),n="",t=0;t<i.length;t++){var r=i[t].split("=");3==r.length&&(0==r[0].indexOf(e)||(n+=i[t]+";"))}o.name=n}catch(e){}},get_from_window_name:function(e){try{for(var o,i=(window.top||window).name.split(";"),n=0;n<i.length;n++){var t=i[n].split("=");if(3==t.length){if(t[0]==e&&(-1!=(o=t[1]).indexOf("USIEQLS")&&(o=o.replace(new RegExp("USIEQLS","g"),"=")),-1!=o.indexOf("USIPRNS")&&(o=o.replace(new RegExp("USIPRNS","g"),";")),!("-1"!=t[2]&&usi_cookies.datediff(t[2])<0)))return[o,t[2]]}else if(2==t.length&&t[0]==e)return-1!=(o=t[1]).indexOf("USIEQLS")&&(o=o.replace(new RegExp("USIEQLS","g"),"=")),-1!=o.indexOf("USIPRNS")&&(o=o.replace(new RegExp("USIPRNS","g"),";")),[o,(new Date).getTime()+6048e5]}}catch(e){}return null},datediff:function(e){return e-(new Date).getTime()},count_cookies:function(e){return e=e||"usi_",usi_cookies.search_cookies(e).length},root_domain:function(){try{var e=document.domain.split("."),o=e[e.length-1];if("com"==o||"net"==o||"org"==o||"us"==o||"co"==o||"ca"==o)return e[e.length-2]+"."+e[e.length-1]}catch(e){}return document.domain},create_cookie:function(e,o,i){if(!1!==navigator.cookieEnabled){var n="";if(-1!=i){var t=new Date;t.setTime(t.getTime()+1e3*i),n="; expires="+t.toGMTString()}var r="samesite=none;";0==location.href.indexOf("https://")&&(r+="secure;");var s=usi_cookies.root_domain();"undefined"!=typeof usi_parent_domain&&-1!=document.domain.indexOf(usi_parent_domain)&&(s=usi_parent_domain),document.cookie=e+"="+encodeURIComponent(o)+n+"; path=/;domain="+s+"; "+r}},create_nonencoded_cookie:function(e,o,i){if(!1!==navigator.cookieEnabled){var n="";if(-1!=i){var t=new Date;t.setTime(t.getTime()+1e3*i),n="; expires="+t.toGMTString()}var r="samesite=none;";0==location.href.indexOf("https://")&&(r+="secure;");var s=usi_cookies.root_domain();"undefined"!=typeof usi_parent_domain&&-1!=document.domain.indexOf(usi_parent_domain)&&(s=usi_parent_domain),document.cookie=e+"="+o+n+"; path=/;domain="+s+"; "+r}},read_cookie:function(e){if(!1===navigator.cookieEnabled)return null;var o=e+"=",i=[];try{i=document.cookie.split(";")}catch(e){}for(var n=0;n<i.length;n++){for(var t=i[n];" "==t.charAt(0);)t=t.substring(1,t.length);if(0==t.indexOf(o))return decodeURIComponent(t.substring(o.length,t.length))}return null},del:function(e){usi_cookies.set(e,null,-100);try{null!=localStorage&&localStorage.removeItem(e),null!=sessionStorage&&sessionStorage.removeItem(e)}catch(e){}},get_ls:function(e){try{var o=localStorage.getItem(e);if(null!=o){if(0==o.indexOf("{")&&-1!=o.indexOf("usi_expires")){var i=JSON.parse(o);if((new Date).getTime()>i.usi_expires)return localStorage.removeItem(e),null;o=i.value}return decodeURIComponent(o)}}catch(e){}return null},get:function(e){var o=usi_cookies.read_cookie(e);if(null!=o)return o;try{if(null!=localStorage&&null!=(o=usi_cookies.get_ls(e)))return o;if(null!=sessionStorage&&null!=(o=sessionStorage.getItem(e)))return decodeURIComponent(o)}catch(e){}var i=usi_cookies.get_from_window_name(e);if(null!=i&&i.length>1)try{o=decodeURIComponent(i[0])}catch(e){return i[0]}return o},get_json:function(e){var o=null,i=usi_cookies.get(e);if(null==i)return null;try{o=JSON.parse(i)}catch(e){i=i.replace(/\\"/g,'"');try{o=JSON.parse(JSON.parse(i))}catch(e){try{o=JSON.parse(i)}catch(e){}}}return o},search_cookies:function(e){e=e||"";var o=[];return document.cookie.split(";").forEach((function(i){var n=i.split("=")[0].trim();""!==e&&0!==n.indexOf(e)||o.push(n)})),o},set:function(e,o,i,n){"undefined"!=typeof usi_nevercookie&&(n=!1),void 0===i&&(i=-1);try{o=o.replace(/(\r\n|\n|\r)/gm,"")}catch(e){}"undefined"==typeof usi_windownameless&&usi_cookies.update_window_name(e+"",o+"",i);try{if(i>0&&null!=localStorage){var t={value:o,usi_expires:(new Date).getTime()+1e3*i};localStorage.setItem(e,JSON.stringify(t))}else null!=sessionStorage&&sessionStorage.setItem(e,o)}catch(e){}if(n||null==o){if(null!=o){if(null==usi_cookies.read_cookie(e))if(!n)if(usi_cookies.search_cookies("usi_").length+1>usi_cookies.max_cookies_count)return void usi_cookies.report_error('Set cookie "'+e+'" failed. Max cookies count is '+usi_cookies.max_cookies_count);if(o.length>usi_cookies.max_cookie_length)return void usi_cookies.report_error('Cookie "'+e+'" truncated ('+o.length+"). Max single-cookie length is "+usi_cookies.max_cookie_length)}usi_cookies.create_cookie(e,o,i)}},set_json:function(e,o,i,n){var t=JSON.stringify(o).replace(/^"/,"").replace(/"$/,"");usi_cookies.set(e,t,i,n)},flush:function(e){e=e||"usi_";var o,i,n,t=document.cookie.split(";");for(o=0;o<t.length;o++)0==(i=t[o]).trim().toLowerCase().indexOf(e)&&(n=i.trim().split("=")[0],usi_cookies.del(n));usi_cookies.flush_window_name(e);try{if(null!=localStorage)for(var r in localStorage)0==r.indexOf("usi_")&&localStorage.removeItem(r);if(null!=sessionStorage)for(var r in sessionStorage)0==r.indexOf("usi_")&&sessionStorage.removeItem(r)}catch(e){}},print:function(){for(var e=document.cookie.split(";"),o="",i=0;i<e.length;i++){var n=e[i];0==n.trim().toLowerCase().indexOf("usi_")&&(console.log(decodeURIComponent(n.trim())+" (cookie)"),o+=","+n.trim().toLowerCase().split("=")[0]+",")}try{if(null!=localStorage)for(var t in localStorage)0==t.indexOf("usi_")&&"string"==typeof localStorage[t]&&-1==o.indexOf(","+t+",")&&(console.log(t+"="+usi_cookies.get_ls(t)+" (localStorage)"),o+=","+t+",");if(null!=sessionStorage)for(var t in sessionStorage)0==t.indexOf("usi_")&&"string"==typeof sessionStorage[t]&&-1==o.indexOf(","+t+",")&&(console.log(t+"="+sessionStorage[t]+" (sessionStorage)"),o+=","+t+",")}catch(e){}for(var r=(window.top||window).name.split(";"),s=0;s<r.length;s++){var a=r[s].split("=");if(3==a.length&&0==a[0].indexOf("usi_")&&-1==o.indexOf(","+a[0]+",")){var u=a[1];-1!=u.indexOf("USIEQLS")&&(u=u.replace(new RegExp("USIEQLS","g"),"=")),-1!=u.indexOf("USIPRNS")&&(u=u.replace(new RegExp("USIPRNS","g"),";")),console.log(a[0]+"="+u+" (window.name)"),o+=","+n.trim().toLowerCase().split("=")[0]+","}}},value_exists:function(){var e,o;for(e=0;e<arguments.length;e++)if(""===(o=usi_cookies.get(arguments[e]))||null===o||"null"===o||"undefined"===o)return!1;return!0},report_error:function(e){"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error(e)}},"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.gup&&"function"==typeof usi_commons.gup_or_get_cookie))try{""!=usi_commons.gup("usi_email_id")?usi_cookies.set("usi_email_id",usi_commons.gup("usi_email_id").split(".")[0],Number(usi_commons.gup("usi_email_id").split(".")[1]),!0):null==usi_cookies.read_cookie("usi_email_id")&&null!=usi_cookies.get_from_window_name("usi_email_id")&&(usi_commons.load_script("https://www.upsellit.com/launch/blank.jsp?usi_email_id_fix="+encodeURIComponent(usi_cookies.get_from_window_name("usi_email_id")[0])),usi_cookies.set("usi_email_id",usi_cookies.get_from_window_name("usi_email_id")[0],(usi_cookies.get_from_window_name("usi_email_id")[1]-(new Date).getTime())/1e3,!0)),""!=usi_commons.gup_or_get_cookie("usi_debug")&&(usi_commons.debug=!0),""!=usi_commons.gup_or_get_cookie("usi_qa")&&(usi_commons.domain=usi_commons.cdn="https://prod.upsellit.com")}catch(e){usi_commons.report_error(e)}
"undefined"==typeof usi_split_test&&(usi_split_test={split_test_name:"usi_dice_roll",split_group:"-1",split_siteID:"-1",split_test_cookie_length:3,get_split_var:function(t){if(t=t||"",null==usi_cookies.get("usi_visitor_id"+t)){var i=Math.random().toString(36).substring(2);i.length>6&&(i=i.substring(0,6));var s="v_"+i+"_"+Math.round((new Date).getTime()/1e3)+"_"+t;return usi_cookies.set("usi_visitor_id"+t,s,86400*this.split_test_cookie_length,!0),s}return usi_cookies.get("usi_visitor_id"+t)},report_test:function(t,i){usi_commons.load_script(usi_commons.domain+"/utility/split_test.jsp?siteID="+t+"&group="+i+"&usi_visitor_id="+this.get_split_var(t)),void 0!==usi_split_test.set_verification&&setTimeout("usi_split_test.set_verification("+i+");",1e3)},get_group:function(t){return usi_cookies.get(this.split_test_name+t)},instantiate:function(t,i,s){null==usi_cookies.get(this.split_test_name+t)||s?(0===i||i&&""!=i?this.split_group=i:Math.random()>.5?this.split_group="0":this.split_group="1",this.report_test(t,this.split_group),usi_cookies.set(this.split_test_name+t,this.split_group,86400*this.split_test_cookie_length,!0)):this.split_group=usi_cookies.get(this.split_test_name+t)}});

if (typeof usi_samsung === 'undefined') {
	usi_samsung = {};
	usi_samsung.scrape_sku = function () {
		try {
			if (document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted").length > 0 && document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted")[0].getAttribute("data-modelcode") != null) {
				return document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted")[0].getAttribute("data-modelcode");
			} else if (document.getElementById("shopSKU") != null) {
				return document.getElementById("shopSKU").value;
			} else if (document.getElementsByClassName("s-product-sku").length > 0) {
				return document.getElementsByClassName("s-product-sku")[0].innerText;
			} else if (document.querySelector("[data-bv-productid]") != null) {
				return document.querySelector("[data-bv-productid]").getAttribute("data-bv-productid");
			} else if (document.getElementsByClassName("hubble-pd-radio s-type-color js-radio-wrap is-checked").length > 0) {
				return document.getElementsByClassName("hubble-pd-radio s-type-color js-radio-wrap is-checked")[0].getElementsByTagName("input")[0].getAttribute("data-modelcode");
			} else if (document.querySelector('.w-product-model [itemprop="model"]') != null) {
				return document.querySelector('.w-product-model [itemprop="model"]').textContent;
			} else if (usi_samsung.grab_ecomm_datalayer() != null) {
				var usi_data_layer = usi_samsung.grab_ecomm_datalayer();
				if (typeof (usi_data_layer.pageCategory) !== "undefined" && usi_data_layer.pageCategory == "product") {
					return usi_data_layer.ecommerce.detail.products[0].id;
				}
			} else if (document.getElementsByClassName("product-sku ng-binding").length > 0) {
				return document.getElementsByClassName("product-sku ng-binding")[0].innerText;
			}
		} catch (err) {
			usi_commons.report_error(err);
		}
		return "";
	};

	usi_samsung.grab_category_restrictions = function(cat) {
		if (cat == "01") {
			return  "category2\":\"01,"
		} else if (cat == "02") {
			return  "category2\":\"01,category2\":\"02,category2\":\"09,"
		} else if (cat == "03") {
			return  "category2\":\"03,category2\":\"07,category2\":\"0104,category2\":\"0102,"
		} else if (cat == "04") {
			return  "category2\":\"05,category2\":\"06,"
		} else if (cat == "05") {
			return  "category2\":\"05,category2\":\"04,"
		} else if (cat == "06") {
			return  "category2\":\"06,category2\":\"04,"
		} else if (cat == "07") {
			return  "category2\":\"07,category2\":\"03,"
		} else if (cat == "08") {
			return  "category2\":\"08,"
		} else if (cat == "09") {
			return  "category2\":\"09,category2\":\"03,category2\":\"02,"
		}
		return "";
	};

	usi_samsung.product_img_matches = function (product) {
		usi_commons.log('product_img_matches: START');

		try {
			var img = product.image;
			var extra = {};
			if (product.hasOwnProperty("extra")) {
				extra = JSON.parse(product.extra);
			}

			var colour = "no color";
			var customizable = extra.hasOwnProperty("customizable") ? extra.customizable : "";
			if (customizable.indexOf("colour:") !== -1) {
				var colorString = customizable.substring(customizable.indexOf("colour:") + 7, customizable.length);
				var colorSections = colorString.split("~");
				if (colorSections.length > 1) {
					var colorName = colorSections[0];
					colour = colorName.indexOf(" ") == -1 ? colorName : colorName.substring(colorName.lastIndexOf(" ") + 1, colorName.length);
				}
			}

			usi_commons.log('product_img_matches: img = ' + img);
			usi_commons.log('product_img_matches: colour = ' + colour);

			return img.indexOf(colour) !== -1;
		} catch (err) {
			usi_commons.log("product_img_matches:  ERR - " + err);
		}

		//If there's an error here, assume true to retain previous behavior
		return true;
	};

	usi_samsung.check_for_consistency = function (product) {
		try {
			if (typeof (usi_app.last_product) === "undefined" || (usi_app.last_product != JSON.stringify(product))) {
				usi_commons.log("usi_app.check_for_consistency: product changed, let's see if it holds.");
				usi_app.last_product = JSON.stringify(product);
				usi_app.first_check = true;
				return false;
			} else if (usi_app.last_product == JSON.stringify(product) && !usi_app.first_check) {
				usi_commons.log("usi_app.check_for_consistency: already returned true for this product");
				return false;
			} else if (usi_app.last_product == JSON.stringify(product)) {
				usi_commons.log("usi_app.check_for_consistency: it held!");
				usi_app.last_product = JSON.stringify(product);
				usi_app.first_check = false;
				return true;
			}
		} catch (err) {
			usi_commons.report_error(err);
		}
		return false
	};
	usi_samsung.scrape_details = function() {
		try {
			var usi_base_name = usi_samsung.scrape_name();
			var usi_details = "";
			for (var i=0; i<document.getElementsByClassName("s-product-opiton").length; i++) {
				if (usi_base_name.indexOf(document.getElementsByClassName("s-product-opiton")[i].innerText) == -1 && document.getElementsByClassName("s-product-opiton")[i].innerText.indexOf(usi_base_name) == -1) {
					if (usi_details != "") usi_details += " ";
					usi_details += document.getElementsByClassName("s-product-opiton")[i].innerText;
				}
			}
			if (usi_details == "") {
				for (var i = 0; i < document.getElementsByClassName("summary__select-option").length; i++) {
					if (usi_base_name.indexOf(document.getElementsByClassName("summary__select-option")[i].innerText) == -1 && document.getElementsByClassName("summary__select-option")[i].innerText.indexOf(usi_base_name) == -1) {
						if (usi_details != "") usi_details += " ";
						usi_details += document.getElementsByClassName("summary__select-option")[i].innerText;
					}
				}
			}
			return usi_details.replace(/ \| /g, ' ').replace(/\|/g, '').replace(/"/g, ' inch');
		} catch (err) {
			usi_commons.report_error(err);
		}
		return ""
	};

	usi_samsung.scrape_name  = function () {
		try {
			var usi_name = "";
			if (document.getElementById("deviceName") != null && document.getElementById("deviceName").getAttribute("content") != null) {
				usi_name =  document.getElementById("deviceName").getAttribute("content");
			} else if (document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted").length > 0 &&  document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted")[0].getAttribute("data-modeldisplay") != null) {
				usi_name =  document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted")[0].getAttribute("data-modeldisplay");
			} else if (document.getElementsByClassName("pd-info__title").length > 0) {
				var usi_name = document.getElementsByClassName("pd-info__title")[0].innerText;
				if (usi_name.indexOf("|") != -1) usi_name = usi_name.substring(0, usi_name.indexOf("|")).trim();
				usi_name =  usi_name;
			} else if (document.getElementsByClassName("s-product-name").length > 0) {
				var usi_name = document.getElementsByClassName("s-product-name")[0].innerText;
				if (usi_name.indexOf("|") != -1) usi_name = usi_name.substring(0, usi_name.indexOf("|")).trim();
				usi_name =  usi_name;
			} else if (document.getElementsByClassName("hubble-product__summary-product-inner").length > 0 && document.getElementsByClassName("hubble-product__summary-product-inner")[0].innerText != "") {
				var usi_name = document.getElementsByClassName("hubble-product__summary-product-inner")[0].innerText;
				if (usi_name.indexOf("|") != -1) usi_name = usi_name.substring(0, usi_name.indexOf("|")).trim();
				usi_name =  usi_name;
			} else if (document.getElementsByClassName("hubble-price-bar__detail-title").length > 0) {
				var usi_name = document.getElementsByClassName("hubble-price-bar__detail-title")[0].innerText;
				if (usi_name.indexOf("|") != -1) usi_name = usi_name.substring(0, usi_name.indexOf("|")).trim();
				usi_name =  usi_name;
			} else if (document.getElementsByClassName("pd-header-navigation__headline-text").length > 0) {
				var usi_name = document.getElementsByClassName("pd-header-navigation__headline-text")[0].innerText;
				if (usi_name.indexOf("|") != -1) usi_name = usi_name.substring(0, usi_name.indexOf("|")).trim();
				usi_name =  usi_name;
			} else if (usi_samsung.grab_ecomm_datalayer() != null) {
				var usi_data_layer = usi_samsung.grab_ecomm_datalayer();
				if (typeof (usi_data_layer.pageCategory) !== "undefined" && usi_data_layer.pageCategory == "product") {
					usi_name =  usi_data_layer.ecommerce.detail.products[0].name;
				}
			} else if (document.getElementsByClassName("product-label ng-star-inserted").length > 2) {
				usi_name =  document.getElementsByClassName("product-label ng-star-inserted")[2].innerText;
			} else if (document.getElementsByClassName("configurator-buying-tool__info-product").length > 0) {
				usi_name =  document.getElementsByClassName("configurator-buying-tool__info-product")[0].innerText;
			} else if (document.getElementsByClassName("primary-image ng-scope").length > 0) {
				usi_name = document.getElementsByClassName("primary-image ng-scope")[0].alt;
			}
		} catch (err) {
			usi_commons.report_error(err);
		}
		return usi_name.replace(/Black|Bronze|Blue|Sky|Red|Burgundy|Cream|Graphite|Green|Lavender|Mint|Olive|Peach|Silver|Violet|White|Phantom|Awesome|Mystic|Pink|Gold|Grey|Purple|Bora|Sapphire| 5G/g,'').trim();
	};
	usi_samsung.scrape_link = function () {
		try {
			var usi_link = location.protocol + '//' + location.host + location.pathname;
			if (usi_link.indexOf("?") != -1) usi_link = usi_link.substring(0, usi_link.indexOf("?"));
			if (usi_link.indexOf("#") != -1) usi_link = usi_link.substring(0, usi_link.indexOf("#"));
			return usi_link;
		} catch (err) {
			usi_commons.report_error(err);
		}
		return "";
	};
	usi_samsung.scrape_model_name = function () {
		try {
			if (document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted").length > 0) {
				return document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted")[0].getAttribute("data-modelname");
			} else if (document.getElementById("modelName") != null) {
				return document.getElementById("modelName").value;
			} else if (document.getElementsByClassName("hubble-pd-radio s-type-color js-radio-wrap is-checked").length > 0 && document.getElementsByClassName("hubble-pd-radio s-type-color js-radio-wrap is-checked")[0].getElementsByTagName("input").length > 0 && document.getElementsByClassName("hubble-pd-radio s-type-color js-radio-wrap is-checked")[0].getElementsByTagName("input")[0].getAttribute("data-modelname") != null) {
				return document.getElementsByClassName("hubble-pd-radio s-type-color js-radio-wrap is-checked")[0].getElementsByTagName("input")[0].getAttribute("data-modelname");
			} else if (typeof (digitalData) !== "undefined" && typeof (digitalData.product) !== "undefined" && typeof (digitalData.product.model_name) !== "undefined" && digitalData.product.model_name != "") {
				return digitalData.product.model_name.split(',')[0];
			} else if (usi_samsung.grab_ecomm_datalayer() != null) {
				var usi_data_layer = usi_samsung.grab_ecomm_datalayer();
				if (typeof (usi_data_layer.pageCategory) !== "undefined" && usi_data_layer.pageCategory == "product") {
					return usi_data_layer.ecommerce.detail.products[0].id;
				}
			} else if (document.getElementsByClassName("product-item-color product-item-color-p6 ng-scope active-color").length == 1) {
				return document.getElementsByClassName("product-item-color product-item-color-p6 ng-scope active-color")[0].getAttribute("data-modelname");
			}
		} catch (err) {
			usi_commons.report_error(err);
		}
		return "";
	};
	usi_samsung.scrape_image = function () {
		var usi_img = "";
		try {
			var usi_found = 0;
			if (document.querySelector("link[rel='preload']") != null && document.querySelector("link[rel='preload']").href) {
				usi_found = 0;
				usi_img = document.querySelector("link[rel='preload']").href;
			} else if (typeof BC_GROUP != "undefined" && typeof BC_GROUP.products != "undefined" && typeof(BC_GROUP.products[usi_samsung.scrape_sku()]) !== "undefined") {
				usi_found = 1;
				usi_img = BC_GROUP.products[usi_samsung.scrape_sku()].smallImage;
			} else if (document.getElementsByClassName("hubble-product__options-color-img").length > 0 && document.getElementsByClassName("hubble-product__options-color-img")[0].getElementsByTagName("img").length > 0) {
				usi_found = 2;
				usi_img = document.getElementsByClassName("hubble-product__options-color-img")[0].getElementsByTagName("img")[0].src;
			} else if (document.getElementsByClassName("product-details-simple__product").length > 0 && document.getElementsByClassName("product-details-simple__product")[0].getElementsByTagName("img").length > 0) {
				usi_found = 3;
				usi_img = document.getElementsByClassName("product-details-simple__product")[0].getElementsByTagName("img")[0].src;
			} else if (document.getElementById("wtbSrc") != null && document.getElementById("wtbSrc").value != null && document.getElementById("wtbSrc").value.indexOf("thumb") != -1) {
				usi_found = 4;
				usi_img = document.getElementById("wtbSrc").value;
			} else if (document.getElementsByClassName("pd-header-gallery__item-wrap").length > 0 && document.getElementsByClassName("pd-header-gallery__item-wrap")[0].getElementsByTagName("img").length > 0) {
				usi_found = 5;
				if (document.getElementsByClassName("pd-header-gallery__item-wrap")[0].getElementsByTagName("img")[0].getAttribute("data-desktop-src")) {
					usi_img = document.getElementsByClassName("pd-header-gallery__item-wrap")[0].getElementsByTagName("img")[0].getAttribute("data-desktop-src");
				} else{
					usi_img = document.getElementsByClassName("pd-header-gallery__item-wrap")[0].getElementsByTagName("img")[0].src;
				}
			} else if (document.querySelector('meta[property="og:image"]') != null && document.querySelector('meta[property="og:image"]').content.indexOf("logo-square-letter.png") == -1) {
				usi_found = 6;
				usi_img = document.querySelector('meta[property="og:image"]').content;
			} else if (document.querySelector(".image-carousel__mobile") != null && document.querySelector(".image-carousel__mobile").src != "") {
				usi_found = 8;
				usi_img = document.querySelector(".image-carousel__mobile").src;
			} else if (document.getElementsByClassName("carousel-item").length > 0 && document.getElementsByClassName("carousel-item")[0].getElementsByTagName("img").length > 0) {
				usi_found = 9;
				usi_img = document.getElementsByClassName("carousel-item")[0].getElementsByTagName("img")[0].src;
			} else if (document.querySelector(".configurator-buying-tool__product [data-custom-lazy]") != null) {
				usi_found = 10;
				usi_img = document.querySelector(".configurator-buying-tool__product [data-custom-lazy]").getAttribute("data-custom-lazy");
			} else if (document.getElementById("repSmallImgPath") != null) {
				usi_found = 11;
				usi_img = document.getElementById("repSmallImgPath").value ;
			} else if (document.getElementsByClassName("primary-image ng-scope").length > 0) {
				usi_found = 12;
				usi_img = document.getElementsByClassName("primary-image ng-scope")[0].src;
			} else if (document.querySelector(".slick-active img") != null && document.querySelector(".slick-active img").src != "") {
				usi_found = 7;
				usi_img = document.querySelector(".slick-active img").getAttribute("data-srcset") ? document.querySelector(".slick-active img").getAttribute("data-srcset") : document.querySelector(".slick-active img").src;
			}
		} catch (err) {
			usi_commons.report_error(err);
		}
		if (usi_img == null) return "";
		if (usi_img.indexOf("/icons/Delivery.png") != -1) {
			usi_commons.load_script("https://www.upsellit.com/launch/blank.jsp?samsung_image_issue="+usi_found);
			return "";
		}
		if (usi_img.indexOf("$") != -1) {
			usi_img = usi_img.substring(0, usi_img.indexOf("$")) + "$THUB_SHOP_L$";
		}
		if (usi_img.indexOf("//") == 0) usi_img = "https:" + usi_img;
		return usi_img;
	};
	usi_samsung.scrape_price = function () {
		try {
			var usi_price = "";
			var usi_buttons = document.getElementsByClassName("cta cta--contained cta--emphasis add-special-tagging js-buy-now");
			if (usi_buttons.length > 0 && usi_buttons[0].getAttribute("data-discountprice") != null) {
				usi_price = usi_buttons[0].getAttribute("data-discountprice");
				usi_price = usi_price.split(",")[0];
			} else if (usi_buttons.length > 1 && usi_buttons[1].getAttribute("data-discountprice") != null) {
				usi_price = usi_buttons[1].getAttribute("data-discountprice");
				usi_price = usi_price.split(",")[0];
			} else if (document.getElementById("promotionPrice") != null) {
				usi_price = document.getElementById("promotionPrice").value;
			} else if (document.getElementsByClassName("hubble-product__summary-product-price").length > 0) {
				usi_price = document.getElementsByClassName("hubble-product__summary-product-price")[0].innerHTML.trim();
			} else if (document.getElementsByClassName("cost-box__price-now").length > 0) {
				usi_price = document.getElementsByClassName("cost-box__price-now")[0].innerHTML.trim();
			} else if (document.getElementsByClassName("s-price").length > 0) {
				usi_price = document.getElementsByClassName("s-price")[0].innerHTML.trim();
			} else if (usi_samsung.grab_ecomm_datalayer() != null) {
				var usi_data_layer = usi_samsung.grab_ecomm_datalayer();
				if (typeof (usi_data_layer.pageCategory) !== "undefined" && usi_data_layer.pageCategory == "product") {
					return usi_data_layer.ecommerce.detail.products[0].price;
				}
			} else if (document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted").length > 0) {
				usi_price =  document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted")[0].getAttribute("data-modelrevenue");
			} else if (document.querySelector(".s-price-total .s-price-num") != null) {
				usi_price = document.querySelector(".s-price-total .s-price-num").textContent;
			} else if (document.getElementsByClassName("product-item-color product-item-color-p6 ng-scope active-color").length > 0 &&  document.getElementsByClassName("product-item-color product-item-color-p6 ng-scope active-color")[0].getAttribute("data-modelrevenue") != null) {
				usi_price = document.getElementsByClassName("product-item-color product-item-color-p6 ng-scope active-color")[0].getAttribute("data-modelrevenue");
			} else if (document.getElementsByClassName("price ng-binding ng-scope").length > 0) {
				usi_price = document.getElementsByClassName("price ng-binding ng-scope")[0].innerText;
			}
			usi_price = usi_price + "";
			if (usi_price.indexOf("hubble-block-text") != -1)	usi_price = usi_price.substring(usi_price.lastIndexOf('">') + 2, usi_price.length).split("\u20AC")[0].trim().replace(/[^0-9.,]+/g, "");
			if (usi_price.indexOf("lei") != -1) usi_price = usi_price.split(" lei")[0];
			if (usi_price.indexOf(">") != -1) usi_price = usi_price.substring(usi_price.lastIndexOf(">") + 1, usi_price.length);
			if (usi_price.indexOf(" or ") != -1) usi_price = usi_price.substring(usi_price.lastIndexOf(" or ") + 4, usi_price.length);
			if (usi_price.indexOf(" oder ") != -1) usi_price = usi_price.substring(usi_price.lastIndexOf(" oder ") + 6, usi_price.length);
			if (usi_price.indexOf(" ou ") != -1) usi_price = usi_price.substring(usi_price.lastIndexOf(" ou ") + 4, usi_price.length);
			if (usi_price.indexOf(" z\u0142") != -1) usi_price = usi_price.substring(0, usi_price.indexOf(" z\u0142"));
			if (usi_price.indexOf(" Ft") != -1) usi_price = usi_price.substring(0, usi_price.indexOf(" Ft"));
			if (usi_price.indexOf("{{") != -1) return "";
 			if (/[A-Za-z]/.test(usi_price)) return ""; //alpha in the price = bad
			if (usi_price != "") {
				return usi_samsung.standardize_currency(usi_price)
			}
		} catch (err) {
			usi_commons.report_error(err);
		}
		return "";
	};
	usi_samsung.scrape_stock = function () {
		try {
			if (document.getElementById("apiChangeStockStatus") != null && document.getElementById("apiChangeStockStatus").value == 'OUTOFSTOCK') {
				return "OUTOFSTOCK";
			} else if (document.getElementsByClassName("s-btn-encased s-blue js-buy-now").length > 0 && document.getElementsByClassName("s-btn-encased s-blue js-buy-now")[0].innerText.indexOf("PRE ORDER") != -1) {
				return "PREORDER";
			} else if (document.getElementById("btn-notify") != null && document.getElementById("btn-notify").style.display != "none") {
				return "OUTOFSTOCK";
			} else if (document.getElementsByClassName("tg-out-stock").length > 0 ) {
				return "OUTOFSTOCK";
			} else if (document.getElementsByClassName("tg-pre-order").length > 0) {
				return "PREORDER";
			} else if (document.getElementsByClassName("s-hubble-total-cta").length > 0 &&
				(document.getElementsByClassName("s-hubble-total-cta")[0].innerText.indexOf("Not for Sale") != -1 || document.getElementsByClassName("s-hubble-total-cta")[0].innerText.indexOf("Receive stock alerts") != -1)) {
				return "OUTOFSTOCK";
			} else if (document.getElementsByClassName("add-to-cart-btn").length > 0 && document.getElementsByClassName("add-to-cart-btn")[0].getAttribute("an-ac") != null && document.getElementsByClassName("add-to-cart-btn")[0].getAttribute("an-ac").indexOf("stock alert") != -1) {
				return "OUTOFSTOCK";
			} else if (document.getElementsByClassName("btn-2 add-to-cart").length > 0 ) {
				//Removed: || document.getElementsByClassName("js-buy-now").length > 0 ||
				return "INSTOCK";
			} else if (document.getElementsByClassName("add-to-cart-btn").length > 0 && document.getElementsByClassName("add-to-cart-btn")[0].className.indexOf("usi_") == -1 && document.getElementsByClassName("add-to-cart-btn")[0].getAttribute("an-ca") !== "stock alert" && document.getElementsByClassName("add-to-cart-btn")[0].className.indexOf("is-cta-disabled") == -1) {
				return "INSTOCK";
			} else if (document.getElementsByClassName("cta cta--contained cta--emphasis add-special-tagging js-buy-now tg-add-to-cart").length > 0) {
				return "INSTOCK";
			} else if (document.getElementsByClassName("cta cta--contained cta--emphasis add-special-tagging tg-add-to-cart").length > 0) {
				return "INSTOCK";
			} else if (document.getElementsByClassName("cta cta--contained cta--emphasis add-special-tagging js-buy-now tg-continue").length > 0) {
				return "INSTOCK";
			} else if (document.querySelector(".product-details-simple.js-buy-now") != null) {
				return "INSTOCK";
			} else if (document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted").length > 0 && document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted")[0].getAttribute("data-an-la") == "secondary navi:add to cart") {
				return "INSTOCK";
			} else if (document.querySelector('.product-basket [data-an-tr="stock-alert"]') != null) {
				return "OUTOFSTOCK";
			} else if (document.querySelector('[data-an-tr="add-to-cart"]') != null) {
				return "INSTOCK";
			} else if (document.getElementsByClassName("cta cta--contained cta--emphasis add-special-tagging tg-bespoke").length > 0) {
				return "INSTOCK";
			} else if (document.getElementsByClassName("btn-add-to-basket").length > 0 && document.getElementsByClassName("btn-add-to-basket")[0].getAttribute("data-stock-level") == 'inStock') {
				return "INSTOCK";
			}
		} catch (err) {
			usi_commons.report_error(err);
		}
		return "OUTOFSTOCK";
	};
	usi_samsung.scrape_category = function (how_deep) {
		try {
			if (typeof (digitalData) !== "undefined" && typeof (digitalData.page) !== "undefined" && typeof (digitalData.page.pathIndicator) !== "undefined") {
				if (digitalData.page.pathIndicator.depth_4 == "" && how_deep >= 3) how_deep = 2;
				if (digitalData.page.pathIndicator.depth_3 == "" && how_deep >= 2) how_deep = 1;
				if (how_deep == 3) {
					return digitalData.page.pathIndicator.depth_2 + "~" + digitalData.page.pathIndicator.depth_3 + "~" + digitalData.page.pathIndicator.depth_4;
				} else if (how_deep == 2) {
					return digitalData.page.pathIndicator.depth_2 + "~" + digitalData.page.pathIndicator.depth_3;
				} else if (how_deep == 1) {
					return digitalData.page.pathIndicator.depth_2;
				}
			} else if (usi_samsung.grab_ecomm_datalayer() != null) {
				var usi_data_layer = usi_samsung.grab_ecomm_datalayer();
				if (typeof (usi_data_layer.pageCategory) !== "undefined" && usi_data_layer.pageCategory == "product") {
					return usi_data_layer.ecommerce.detail.products[0].category;
				}
			}
		} catch (err) {
			usi_commons.report_error(err);
		}
		return "";
	};
	usi_samsung.scrape_category2 = function (how_deep) {
		try {
			if (document.getElementById("categorySubTypeCode") != null) {
				return document.getElementById("categorySubTypeCode").value;
			} else if (document.getElementById("wtb-categorySubTypeCode") != null && document.getElementById("wtb-categorySubTypeCode").value != "") {
				return document.getElementById("wtb-categorySubTypeCode").value;
			} else if (typeof(BC_GROUP) !== "undefined") {
				return BC_GROUP.categorySubTypeCode;
			}
		} catch (err) {
			usi_commons.report_error(err);
		}
		return "";
	};
	usi_samsung.scrape_customizations = function () {
		var usi_customizable = "";
		try {
			if (document.getElementsByClassName("product-item-color product-item-color-p6 ng-scope active-color").length == 1) {
				var componentToHex = function(c) {
				  var hex = Number(c).toString(16);
				  return hex.length == 1 ? "0" + hex : hex;
				};
				if (document.getElementsByClassName("product-item-color product-item-color-p6 ng-scope active-color")[0].getElementsByClassName("product-list-halo").length > 0) {
					var usi_rbg = document.getElementsByClassName("product-item-color product-item-color-p6 ng-scope active-color")[0].getElementsByClassName("product-list-halo")[0].style.backgroundColor.replace(/[^0-9\.,]+/g,"");
					return "colour:" + document.getElementsByClassName("product-item-color product-item-color-p6 ng-scope active-color")[0].getElementsByClassName("product-list-name")[0].innerText + "~" + usi_samsung.scrape_model_name().toLowerCase() + "~" + usi_samsung.scrape_sku() + "~#" + componentToHex(usi_rbg.split(",")[0]) + componentToHex(usi_rbg.split(",")[1]) + componentToHex(usi_rbg.split(",")[2]);
				}
			}
			if (document.getElementsByClassName("bttn selected").length == 1 && document.getElementsByClassName("bttn selected")[0].parentNode.className == "variant-btn-container ng-star-inserted") {
				var componentToHex = function(c) {
				  var hex = Number(c).toString(16);
				  return hex.length == 1 ? "0" + hex : hex;
				};
				var usi_color = document.getElementsByClassName("bttn selected")[0].parentNode;
				var usi_rbg = document.getElementsByClassName("bttn selected")[0].parentNode.getElementsByClassName("circle-inner")[0].style.backgroundColor.replace(/[^0-9,]+/g,"")
				return "colour:"+document.getElementsByClassName("bttn selected")[0].parentNode.getElementsByClassName("label")[0].innerText.toLowerCase()+"~"+usi_samsung.scrape_model_name().toLowerCase()+"~"+usi_samsung.scrape_sku()+"~#" + componentToHex(usi_rbg.split(",")[0]) + componentToHex(usi_rbg.split(",")[1]) + componentToHex(usi_rbg.split(",")[2]);
			}
			for (var i = 0; i < document.getElementsByClassName("hidden option-input add-special-tagging buyingoption-api checked").length; i++) {
				var usi_option = document.getElementsByClassName("hidden option-input add-special-tagging buyingoption-api checked")[i];
				if (usi_option.checked) {
					if (usi_option.getAttribute("an-la") != null && usi_option.getAttribute("an-la").indexOf("colo") == 0) {
						usi_customizable = "";
						usi_customizable += usi_option.getAttribute("an-la").replace("color:", "colour:") + "~";
						usi_customizable += usi_option.getAttribute("data-modelname") + "~";
						usi_customizable += usi_option.getAttribute("data-modelcode") + "~";
						var usi_color = usi_option.value;
						if (usi_color.indexOf("#") != -1) {
							usi_color = usi_color.substring(usi_color.indexOf("#"), usi_color.length);
							usi_customizable += usi_color;
							return usi_customizable;
						} else if (usi_option.parentNode.getElementsByClassName("pd-option-selector__color").length > 0) {
							usi_color = usi_option.parentNode.getElementsByClassName("pd-option-selector__color")[0].getAttribute("style");
							if (usi_color.indexOf("#") != -1) {
								usi_color = usi_color.substring(usi_color.indexOf("#"), usi_color.length);
								usi_customizable += usi_color.replace(";", "");
								return usi_customizable;
							}
						}
					}
				}
			}
			for (var i = 0; i < document.getElementsByClassName("sdf-comp-option-chip").length; i++) {
				var usi_option = document.getElementsByClassName("sdf-comp-option-chip")[i];
				if (usi_option.checked) {
					if (usi_option.getAttribute("an-la") != null && usi_option.getAttribute("an-la").indexOf("colo") == 0) {
						usi_customizable = "";
						usi_customizable += usi_option.getAttribute("an-la").replace("color:", "colour:") + "~";
						usi_customizable += usi_option.getAttribute("data-modelname") + "~";
						usi_customizable += usi_option.getAttribute("data-modelcode") + "~";
						var usi_color = usi_option.value;
						usi_color = usi_color.substring(usi_color.indexOf("#"), usi_color.length);
						usi_customizable += usi_color;
						return usi_customizable;
					}
				}
			}
			for (var i = 0; i < document.getElementsByClassName("s-box-option js-radio-wrap is-checked").length; i++) {
				var usi_option = document.getElementsByClassName("s-box-option js-radio-wrap is-checked")[i];
				if (usi_option.getAttribute("data-omni") != null && usi_option.getAttribute("data-omni").indexOf("colour") != -1) {
					var color_details = usi_option.getAttribute("data-omni").replace(/\|/g, "~");
					var hex_color = "";
					if (usi_option.getElementsByClassName("s-item-color-chip").length > 0) {
						hex_color = usi_option.getElementsByClassName("s-item-color-chip")[0].getAttribute("style").replace("background-color:", "").replace(";", "");
					} else {
						hex_color = "#cccccc";
					}
					return color_details + ":" + hex_color;
				}
			}
			if (document.getElementsByClassName("hubble-pd-radio s-type-color js-radio-wrap is-checked").length > 0 && document.getElementsByClassName("hubble-pd-radio s-type-color js-radio-wrap is-checked")[0].getElementsByTagName("img").length > 0) {
				//colour:dark gray~sm-x200~SM-X200NZAEEUA~#777777
				var color_details = document.getElementsByClassName("hubble-pd-radio s-type-color js-radio-wrap is-checked")[0].getElementsByTagName("img")[0].alt;
				var color_img = document.getElementsByClassName("hubble-pd-radio s-type-color js-radio-wrap is-checked")[0].getElementsByTagName("img")[0].src;
				return "colour:"+color_details + "~" +  document.getElementsByClassName("hubble-pd-radio s-type-color js-radio-wrap is-checked")[0].getElementsByTagName("input")[0].getAttribute("data-modelname").toLowerCase() + "~" +  document.getElementsByClassName("hubble-pd-radio s-type-color js-radio-wrap is-checked")[0].getElementsByTagName("input")[0].getAttribute("data-modelcode") + "~" + color_img;
			}
		} catch (err) {
			usi_commons.report_error(err);
		}
		return "";
	};
	usi_samsung.scrape_ratings = function () {
		try {
			if (document.getElementsByClassName("rating__point").length > 0) {
				return document.getElementsByClassName("rating__point")[0].innerText.replace(/[^0-9\.,]+/g, "");
			} else if (document.getElementsByClassName("bv_avgRating_component_container").length > 0) {
				return document.getElementsByClassName("bv_avgRating_component_container")[0].innerText;
			} else if (document.querySelector(".revoo-review iframe") != null && document.querySelector(".revoo-review iframe").contentDocument != null && document.querySelector(".revoo-review iframe").contentDocument.querySelector('[data-score]') != null) {
				return document.querySelector(".revoo-review iframe").contentDocument.querySelector('[data-score]').getAttribute("data-score") / 2;
			} else if (document.querySelector("#reviews_summary iframe") != null && document.querySelector("#reviews_summary iframe").contentDocument != null && document.querySelector("#reviews_summary iframe").contentDocument.querySelector('[data-score]') != null) {
				return document.querySelector("#reviews_summary iframe").contentDocument.querySelector('[data-score]').getAttribute("data-score") / 2;
			} else if (document.querySelector('[type="application/ld+json"]') != null && JSON.parse(document.querySelector('[type="application/ld+json"]').textContent).aggregateRating) {
				return JSON.parse(document.querySelector('[type="application/ld+json"]').textContent).aggregateRating.ratingValue;
			} else if (document.getElementsByClassName("rating").length > 0 && document.getElementsByClassName("rating")[0].getElementsByClassName("sr-only").length > 0) {
				return document.getElementsByClassName("rating")[0].getElementsByClassName("sr-only")[0].innerText.replace(/[^0-9\.]+/g,"");
			}
		} catch (err) {
			usi_commons.report_error(err);
		}
		return "";
	};
	usi_samsung.scrape_msrp = function () {
		try {
			var usi_msrp = "";
			var usi_buttons = document.getElementsByClassName("cta cta--contained cta--emphasis add-special-tagging js-buy-now");
			if (usi_buttons.length > 0 && usi_buttons[0].getAttribute("data-modelprice") != null) {
				usi_msrp = usi_buttons[0].getAttribute("data-modelprice");
				usi_msrp = usi_msrp.split(",")[0];
			} else if (usi_buttons.length > 1 && usi_buttons[1].getAttribute("data-modelprice") != null) {
				usi_msrp = usi_buttons[1].getAttribute("data-modelprice");
				usi_msrp = usi_msrp.split(",")[0];
			} else if (document.getElementsByClassName("cost-box__price-original").length > 0) {
				usi_msrp = document.getElementsByClassName("cost-box__price-original")[0].textContent;
			} else if (document.getElementById("originalPrice") != null) {
				usi_msrp = document.getElementById("originalPrice").value;
			} else if (document.getElementById("product-price-old") != null) {
				usi_msrp = document.getElementById("product-price-old").innerText;
			} else if (document.getElementsByClassName("hubble-product__summary-product-price").length > 0 && document.getElementsByClassName("hubble-product__summary-product-price")[0].getElementsByTagName("span").length > 0) {
				usi_msrp = document.getElementsByClassName("hubble-product__summary-product-price")[0].getElementsByTagName("span")[0].innerText;
			} else if (document.getElementsByClassName("hubble-product__summary-product-price").length > 0) {
				usi_msrp = document.getElementsByClassName("hubble-product__summary-product-price")[0].innerText;
			} else if (document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted").length > 0 && document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted")[0].getAttribute("data-modelprice") != null) {
				usi_msrp =  document.getElementsByClassName("button primary pill-btn pill-btn--blue ng-star-inserted")[0].getAttribute("data-modelprice");
			} else if (document.querySelector(".s-price-total .del-price") != null) {
				usi_msrp = document.querySelector(".s-price-total .del-price").textContent;
			} else if (document.getElementsByClassName("product-promo ng-scope").length > 0) {
				usi_msrp = document.getElementsByClassName("product-promo ng-scope")[0].innerText;
			}
			if (usi_msrp.indexOf("{{") != -1) return "";
			if (usi_msrp.indexOf(" z\u0142") != -1) usi_msrp = usi_msrp.substring(0, usi_msrp.indexOf(" z\u0142"));
			if (usi_msrp.indexOf(" Ft") != -1) usi_msrp = usi_msrp.substring(0, usi_msrp.indexOf(" Ft"));
			if (/[A-Za-z]/.test(usi_msrp)) return ""; //alpha in the price = bad
			if (usi_msrp != "") return usi_samsung.standardize_currency(usi_msrp);
		} catch (err) {
			usi_commons.report_error(err);
		}
		return "";
	};
	usi_samsung.standardize_currency = function (currency_str) {
		var usi_final = 0;
		currency_str = currency_str.replace(/[^0-9\.,]+/g, "");
		if (currency_str.indexOf(",") != -1 && (currency_str.split(",")[1].length == 2 || currency_str.split(",")[1].length == 1)) {
			//This is a 199,99 format
			usi_final = currency_str.split(",")[0].replace(/[^0-9]+/g, "") + "." + currency_str.split(",")[1];
		} else {
			usi_final = currency_str.replace(/[^0-9\.]+/g, "");
		}
		if (isNaN(Number(usi_final)) || Number(usi_final) > 80000) return "";
		return (Number(usi_final).toFixed(2)) + "";
	};
	usi_samsung.grab_ecomm_datalayer = function () {
		if (typeof (dataLayer) !== "undefined") {
			for (var i = 0; i < dataLayer.length; i++) {
				if (typeof (dataLayer[i].ecommerce) !== "undefined") {
					return dataLayer[i];
				}
			}
		}
		return null;
	};
	usi_samsung.test_product_page = function() {
		usi_samsung.is_product_page = usi_samsung.scrape_sku() != "" && location.href.indexOf("compare") == -1;
		if (document.getElementById("tempTitle") != null && document.getElementById("tempTitle").value == "page-feature-pd") {
			//Feature pages look like product pages, but they arne't.
			usi_samsung.is_product_page = false;
		}
	}
	usi_samsung.test_product_page();
}if (typeof usi_prodrec === 'undefined') {
	usi_prodrec = function () {
		var cookie_length = 30;
		var validateStringNotBlank = function(s, msg) {
			var valid = typeof s !== 'undefined';
			if (valid) {
				valid = s.trim().length > 0;
			}
			if (!valid && msg) {
				usi_commons.log(msg);
			}
			return valid;
		};
		var validateSameLengthArrays = function(a1, a2, msg) {
			var valid = Array.isArray(a1) && Array.isArray(a2);
			if (valid) {
				valid = a1.length == a2.length;
			}
			if (!valid) {
				usi_commons.log(msg);
			}
			return valid;
		};
		var validateNonEmptyArray = function(arr, msg) {
			var valid = Array.isArray(arr) && arr.length > 0;
			if (!valid) {
				usi_commons.log(msg);
			}
			return valid;
		};
		var validateProductsRequest = function (visitorId, configurationId, siteId, chatId, targetPid, targetPrice,
												shownPids, shownPrices) {
			var msgPrefix = 'usi_prodrec.products_shown:  error - ';
			return validateStringNotBlank(visitorId, msgPrefix + 'visitorId cannot be blank') &&
				validateStringNotBlank(siteId, msgPrefix + 'siteId cannot be blank') &&
				validateStringNotBlank(configurationId, msgPrefix + 'configurationId cannot be blank') &&
				validateStringNotBlank(chatId, msgPrefix + 'chatId cannot be blank') &&
				validateStringNotBlank(targetPid, msgPrefix + 'targetPid cannot be blank') &&
				validateStringNotBlank(targetPrice, msgPrefix + 'targetPrice cannot be blank') &&
				validateSameLengthArrays(shownPids, shownPrices, msgPrefix + 'invalid shownPids and/or shownPrices');
		};
		var buildReportProductUrl = function(visitorId, siteId, configurationId, chatId, targetPid, targetPrice,
											 shownPids, shownPrices) {
			return usi_commons.domain + '/utility/report_product.jsp?usi_upr_id=' + encodeURIComponent(visitorId) +
				'&siteID=' + encodeURIComponent(siteId) +
				'&configurationID=' + encodeURIComponent(configurationId) +
				'&chatID=' + encodeURIComponent(chatId) +
				'&target_pid=' + encodeURIComponent(targetPid) + '&target_price=' + encodeURIComponent(targetPrice) +
				'&shown_products=' + encodeURIComponent(JSON.stringify(shownPids)) +
				'&shown_prices=' + encodeURIComponent(JSON.stringify(shownPrices));
		};
		var buildReportSaleUrl = function(visitorId, chatId, pids, prices, quantities, order_id, order_amt) {
			return usi_commons.domain + '/utility/report_sale.jsp?usi_upr_id=' + encodeURIComponent(visitorId) +
				'&chatID=' + encodeURIComponent(chatId) +
				'&pids=' + encodeURIComponent(JSON.stringify(pids)) +
				'&prices=' + encodeURIComponent(JSON.stringify(prices)) +
				'&quantities=' + encodeURIComponent(JSON.stringify(quantities)) +
				'&order_id=' + encodeURIComponent(order_id) +
				'&order_amt=' + encodeURIComponent(order_amt);
		};
		var buildClickUrl = function(visitorId, siteId, configurationId, chatId, targetPid, targetPrice,
											 clickedPids, clickedPrices) {
			return usi_commons.domain + '/utility/report_click.jsp?usi_upr_id=' + encodeURIComponent(visitorId) +
				'&siteID=' + encodeURIComponent(siteId) +
				'&configurationID=' + encodeURIComponent(configurationId) +
				'&chatID=' + encodeURIComponent(chatId) +
				'&target_pid=' + encodeURIComponent(targetPid) + '&target_price=' + encodeURIComponent(targetPrice) +
				'&clicked_products=' + encodeURIComponent(JSON.stringify(clickedPids)) +
				'&clicked_prices=' + encodeURIComponent(JSON.stringify(clickedPrices));
		};
		var reportProducts = function(chatId, siteId, configurationId, targetPid, targetPrice, shownPids, shownPrices) {
			var visitorId = usi_prodrec.get_upsell_id();
			var url = buildReportProductUrl(visitorId, siteId, configurationId, chatId, targetPid+"", targetPrice+"", shownPids, shownPrices);
			usi_commons.load_script(url);
		};
		var reportClicks = function(chatId, siteId, configurationId, targetPid, targetPrice, clickedPids, clickedPrices, usi_callback) {
			var visitorId = usi_prodrec.get_upsell_id();
			var url = buildClickUrl(visitorId, siteId, configurationId, chatId, targetPid+"", targetPrice+"", clickedPids, clickedPrices);
			usi_commons.load_script(url, usi_callback);
		};
		var format_pid = function(product) {
			if (typeof(product.preferred_name) !== "undefined") {
				return product.preferred_name;
			}
			var pid = product.pid;
			if (typeof(pid) === "undefined" && typeof(product.sku) !== "undefined") {
				pid = product.sku;
			}
			return (pid+"").trim();
		};
		var reportSale = function(chatId, soldProducts, order_id, order_amt) {
			var visitorId = usi_prodrec.get_upsell_id();
			var pids = [];
			var prices = [];
			var quantities = [];
			for (var i = 0; i < 10; i++) {
				if (typeof(soldProducts[i]) === "undefined") {
					break;
				}
				pids.push(format_pid(soldProducts[i]));
				prices.push(soldProducts[i].price);
				quantities.push(Math.floor(soldProducts[i].quantity));
			}
			var url = buildReportSaleUrl(visitorId, chatId, pids, prices, quantities, order_id, order_amt);
			usi_commons.load_script(url);
		};
		var clearUpsellId = function (siteId) {
			siteId = siteId || "";
			siteId = siteId + "";
			if (usi_cookies.get('usi_upr_id') == null) {
				usi_cookies.del('usi_upr_id');
			}
		};
		return {
			get_upsell_id: function () {
				var usi_id = null;
				try {
					if (usi_cookies.get('usi_upr_id') == null && usi_cookies.get('usi_id') == null) {
						var usi_rand_str = Math.random().toString(36).substring(2);
						if (usi_rand_str.length > 6) usi_rand_str = usi_rand_str.substring(0, 6);
						usi_id = usi_rand_str + "_" + Math.round((new Date()).getTime() / 1000);
						usi_cookies.set('usi_id', usi_id, 30 * 86400, true);
						return usi_id;
					}
					if (usi_cookies.get('usi_upr_id') != null) usi_id = usi_cookies.get('usi_upr_id');
					if (usi_cookies.get('usi_id') != null) usi_id = usi_cookies.get('usi_id');
					usi_cookies.set('usi_id', usi_id, 30 * 86400, true);
				} catch(err) {
					usi_commons.report_error(err);
				}
				return usi_id;
			},
			report_product_view: function (chatId, siteId, configurationId, seenProducts, targetProduct) {
			},
			report_product_view2: function (chatId, siteId, configurationId, seenProducts, targetProduct) {
				try {
					var shownPids = [];
					var shownPrices = [];
					window.seenProducts = seenProducts;
					for (var i = 0; i < 10; i++) {
						if (typeof(seenProducts[i]) === "undefined") {
							break;
						}
						shownPids.push(format_pid(seenProducts[i]));
						shownPrices.push(seenProducts[i].price);
					}
					var targetPid = format_pid(targetProduct);
					var targetPrice = targetProduct.price;
					reportProducts(chatId, siteId+"", configurationId+"", targetPid, targetPrice, shownPids, shownPrices);
				} catch (err) {
					usi_commons.report_error(err);
				}
			},
			report_product_click: function (chatId, siteId, configurationId, clickedProducts, targetProduct, usi_callback) {
			},
			report_product_click2: function (chatId, siteId, configurationId, clickedProducts, targetProduct, usi_callback) {
				try {
					var clickedPids = [];
					var clickedPrices = [];
					if (typeof(clickedProducts[0]) !== "undefined") {
						for (var i = 0; i < 10; i++) {
							if (typeof(clickedProducts[i]) === "undefined") {
								break;
							}
							clickedPids.push(format_pid(clickedProducts[i]));
							clickedPrices.push(clickedProducts[i].price);
						}
					} else {
						clickedPids.push(format_pid(clickedProducts));
						clickedPrices.push(clickedProducts.price);
					}
					var targetPid = format_pid(targetProduct);
					var targetPrice = targetProduct.price;
					reportClicks(chatId, siteId+"", configurationId+"", targetPid, targetPrice, clickedPids, clickedPrices, usi_callback);
				} catch (err) {
					usi_commons.report_error(err);
					usi_commons.log(err);
				}
			},
			report_product_sale: function (chatId, pids, prices, quantities, order_id, order_amt) {
			},
			report_product_sale2: function (chatId, purchasedProducts, order_id, order_amt) {
				try {
					//Validate params
					reportSale(chatId, purchasedProducts, order_id, order_amt);
					//clearUpsellId(siteId);
				} catch (err) {
					usi_commons.report_error(err);
					usi_commons.log(err);
				}
			}
		};
	}();
}
"undefined"==typeof usi_ajax&&(usi_ajax={},usi_ajax.get=function(e,t){try{return usi_ajax.get_with_options({url:e},t)}catch(e){usi_commons.report_error(e)}},usi_ajax.get_with_options=function(e,t){null==t&&(t=function(){});var r={};if((e=e||{}).headers=e.headers||[],null==XMLHttpRequest)return t(new Error("XMLHttpRequest not supported"),r);if(""===(e.url||""))return t(new Error("url cannot be blank"),r);try{var a=new XMLHttpRequest;a.open("GET",e.url,!0),a.setRequestHeader("Content-type","application/json"),e.headers.forEach(function(e){""!==(e.name||"")&&""!==(e.value||"")&&a.setRequestHeader(e.name,e.value)}),a.onreadystatechange=function(){if(4===a.readyState){r.status=a.status,r.responseText=a.responseText||"";var e=null;return 0!==String(a.status).indexOf("2")&&(e=new Error("http.status: "+a.status)),t(e,r)}},a.send()}catch(e){return usi_commons.report_error(e),t(e,r)}},usi_ajax.post=function(e,t,r){try{return usi_ajax.post_with_options({url:e,params:t},r)}catch(e){usi_commons.report_error(e)}},usi_ajax.post_with_options=function(e,t){null==t&&(t=function(){});var r={};if((e=e||{}).headers=e.headers||[],e.paramsDataType=e.paramsDataType||"string",e.params=e.params||"",null==XMLHttpRequest)return t(new Error("XMLHttpRequest not supported"),r);if(""===(e.url||""))return t(new Error("url cannot be blank"),r);try{var a=new XMLHttpRequest;a.open("POST",e.url,!0),"formData"===e.paramsDataType||("object"===e.paramsDataType?(a.setRequestHeader("Content-type","application/json; charset=utf-8"),e.params=JSON.stringify(e.params)):a.setRequestHeader("Content-type","application/x-www-form-urlencoded")),e.headers.forEach(function(e){""!==(e.name||"")&&""!==(e.value||"")&&a.setRequestHeader(e.name,e.value)}),a.onreadystatechange=function(){if(4===a.readyState){r.status=a.status,r.responseText=a.responseText||"",r.responseURL=a.responseURL||"";var e=null;return 0!==String(a.status).indexOf("2")&&(e=new Error("http.status: "+a.status)),t(e,r)}},a.send(e.params)}catch(e){return usi_commons.report_error(e),t(e,r)}},usi_ajax.form_post=function(e,t,r){try{r=r||"post";var a=document.createElement("form");a.setAttribute("method",r),a.setAttribute("action",e),null!=t&&"object"==typeof t&&Object.keys(t).forEach(function(e){var r=document.createElement("input");r.setAttribute("type","hidden"),r.setAttribute("name",e),r.setAttribute("value",t[e]),a.appendChild(r)}),document.body.appendChild(a),a.submit()}catch(e){usi_commons.report_error(e)}},usi_ajax.put_with_options=function(e,t){null==t&&(t=function(){});var r={};if((e=e||{}).headers=e.headers||[],null==XMLHttpRequest)return t(new Error("XMLHttpRequest not supported"),r);if(""===(e.url||""))return t(new Error("url cannot be blank"),r);try{var a=new XMLHttpRequest;a.open("PUT",e.url,!0),a.setRequestHeader("Content-type","application/json"),e.headers.forEach(function(e){""!==(e.name||"")&&""!==(e.value||"")&&a.setRequestHeader(e.name,e.value)}),a.onreadystatechange=function(){if(4===a.readyState){r.status=a.status,r.responseText=a.responseText||"";var e=null;return 0!==String(a.status).indexOf("2")&&(e=new Error("http.status: "+a.status)),t(e,r)}},a.send()}catch(e){return usi_commons.report_error(e),t(e,r)}},usi_ajax.get_with_script=function(e,t,r){try{var a={};null==t&&(t=!0);var n="usi_"+(new Date).getTime(),s=document.getElementsByTagName("head")[0];top.location!=location&&(s=parent.document.getElementsByTagName("head")[0]);var o=document.createElement("script");o.id=n,o.type="text/javascript",o.src=e,o.addEventListener("load",function(){if(!0===t&&s.removeChild(o),null!=r)return r(null,a)}),s.appendChild(o)}catch(e){usi_commons.report_error(e)}},usi_ajax.listener=function(e){if(null==e&&(e=!1),null!=XMLHttpRequest){var t=this;t.ajax=new Object,t.clear=function(){t.ajax.requests=[],t.ajax.registeredRequests=[],t.ajax.scriptLoads=[],t.ajax.registeredScriptLoads=[]},t.clear(),t.register=function(e,r,a){try{var n={method:e=(e||"*").toUpperCase(),url:r=r||"*",callback:a=a||function(){}};t.ajax.registeredRequests.push(n)}catch(e){usi_commons.report_error(e)}},t.registerScriptLoad=function(e,r){try{var a={url:e=e||"*",callback:r=r||function(){}};t.ajax.registeredScriptLoads.push(a)}catch(e){usi_commons.report_error(e)}},t.registerFormSubmit=function(t,r){try{null!=t&&usi_dom.attach_event("submit",function(a){if(!0===e&&usi_commons.log("USI AJAX: form submit"),null!=a&&!0===a.returnValue){a.preventDefault();var n={action:t.action,data:{},e:a},s=["submit"];if(Array.prototype.slice.call(t.elements).forEach(function(e){try{-1===s.indexOf(e.type)&&("checkbox"===e.type?!0===e.checked&&(n.data[e.name]=e.value):n.data[e.name]=e.value)}catch(e){usi_commons.report_error(e)}}),null!=r)return r(null,n);a.returnValue=!0}},t)}catch(e){usi_commons.report_error(e)}},t.listen=function(){try{t.ajax.originalOpen=XMLHttpRequest.prototype.open,t.ajax.originalSend=XMLHttpRequest.prototype.send,XMLHttpRequest.prototype.open=function(r,a){r=(r||"").toUpperCase(),a=a||"",a=usi_dom.get_absolute_url(a),!0===e&&usi_commons.log("USI AJAX: open["+r+"]: "+a);var n={method:r,url:a,openDate:new Date};t.ajax.requests.push(n);var s=null;t.ajax.registeredRequests.forEach(function(e){e.method!=r&&"*"!=e.method||(a.indexOf(e.url)>-1||"*"==e.url)&&(s=e)}),null!=s&&(!0===e&&usi_commons.log("USI AJAX: Registered URL["+r+"]: "+a),this.requestObj=n,this.requestObj.callback=s.callback),t.ajax.originalOpen.apply(this,arguments)},XMLHttpRequest.prototype.send=function(r){var a=this;null!=a.requestObj&&(!0===e&&usi_commons.log("USI AJAX: Send Registered URL["+a.requestObj.method+"]: "+a.requestObj.url),""!=(r||"")&&(a.requestObj.params=r),a.addEventListener?a.addEventListener("readystatechange",function(){t.ajax.readyStateChanged(a)},!1):t.ajax.proxifyOnReadyStateChange(a)),t.ajax.originalSend.apply(a,arguments)},t.ajax.readyStateChanged=function(t){if(4===t.readyState&&null!=t.requestObj&&(t.requestObj.completedDate=new Date,!0===e&&usi_commons.log("Completed: "+t.requestObj.url),null!=t.requestObj.callback)){var r={requestObj:t.requestObj,responseText:t.responseText};return t.requestObj.callback(null,r)}},t.ajax.proxifyOnReadyStateChange=function(e){var r=e.onreadystatechange;null!=r&&(e.onreadystatechange=function(){t.ajax.readyStateChanged(e),r()})},document.head.addEventListener("load",function(e){if(null!=e&&null!=e.target&&""!=(e.target.src||"")){var r=e.target.src,a={url:r=usi_dom.get_absolute_url(r),completedDate:new Date};t.ajax.scriptLoads.push(a);var n=null;if(t.ajax.registeredScriptLoads.forEach(function(e){(r.indexOf(e.url)>-1||"*"==e.url)&&(n=e)}),null!=n&&null!=n.callback)return n.callback(null,a)}},!0),usi_commons.log("USI AJAX: listening ...")}catch(e){usi_commons.report_error(e),usi_commons.log("usi_ajax.listener ERROR: "+e.message)}},t.unregisterAll=function(){t.ajax.registeredRequests=[],t.ajax.registeredScriptLoads=[]}}});
"undefined"==typeof usi_date&&(usi_date={},usi_date.PSTOffsetMinutes=480,usi_date.localOffsetMinutes=(new Date).getTimezoneOffset(),usi_date.offsetDeltaMinutes=usi_date.localOffsetMinutes-usi_date.PSTOffsetMinutes,usi_date.toPST=function(e){return!1===usi_date.is_date(e)?e:new Date(e.getTime()+60*usi_date.offsetDeltaMinutes*1e3)},usi_date.add_hours=function(e,t){return!1===usi_date.is_date(e)?e:new Date(e.getTime()+60*t*60*1e3)},usi_date.add_minutes=function(e,t){return!1===usi_date.is_date(e)?e:new Date(e.getTime()+60*t*1e3)},usi_date.add_seconds=function(e,t){return!1===usi_date.is_date(e)?e:new Date(e.getTime()+1e3*t)},usi_date.get_week_number=function(e){var t={year:-1,weekNumber:-1};try{if(usi_date.is_date(e)){var a=new Date(Date.UTC(e.getFullYear(),e.getMonth(),e.getDate()));a.setUTCDate(a.getUTCDate()+4-(a.getUTCDay()||7));var s=new Date(Date.UTC(a.getUTCFullYear(),0,1)),i=Math.ceil(((a-s)/864e5+1)/7);t.year=a.getUTCFullYear(),t.weekNumber=i}}catch(e){}finally{return t}},usi_date.is_date=function(e){return null!=e&&"object"==typeof e&&e instanceof Date==!0&&!1===isNaN(e.getTime())},usi_date.is_date_within_range=function(e,t,a){if(void 0===e&&(e=usi_date.set_date()),!1===usi_date.is_date(e))return!1;var s=usi_date.string_to_date(t,!1),i=usi_date.string_to_date(a,!1),r=usi_date.toPST(e);return r>=s&&r<i},usi_date.is_after=function(e){try{usi_date.check_format(e);var t=usi_date.set_date(),a=new Date(e);return t.getTime()>a.getTime()}catch(e){"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error(e)}return!1},usi_date.is_before=function(e){try{usi_date.check_format(e);var t=usi_date.set_date(),a=new Date(e);return t.getTime()<a.getTime()}catch(e){"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error(e)}return!1},usi_date.is_between=function(e,t){return usi_date.check_format(e,t),usi_date.is_after(e)&&usi_date.is_before(t)},usi_date.check_format=function(e,t){(-1!=e.indexOf(" ")||t&&-1!=t.indexOf(" "))&&"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error("Incorrect format: Use YYYY-MM-DDThh:mm:ss")},usi_date.is_date_after=function(e,t){if(!1===usi_date.is_date(e))return!1;var a=usi_date.string_to_date(t,!1);return usi_date.toPST(e)>a},usi_date.is_date_before=function(e,t){if(!1===usi_date.is_date(e))return!1;var a=usi_date.string_to_date(t,!1);return usi_date.toPST(e)<a},usi_date.string_to_date=function(e,t){t=t||!1;var a=null,s=/^[0-2]?[0-9]\/[0-3]?[0-9]\/\d{4}(\s[0-2]?[0-9]\:[0-5]?[0-9](?:\:[0-5]?[0-9])?)?$/.exec(e),i=/^(\d{4}\-[0-2]?[0-9]\-[0-3]?[0-9])(\s[0-2]?[0-9]\:[0-5]?[0-9](?:\:[0-5]?[0-9])?)?$/.exec(e);if(2===(s||[]).length){if(a=new Date(e),""===(s[1]||"")&&!0===t){var r=new Date;a=usi_date.add_hours(a,r.getHours()),a=usi_date.add_minutes(a,r.getMinutes()),a=usi_date.add_seconds(a,r.getSeconds())}}else if(3===(i||[]).length){var o=i[1].split(/\-/g),u=o[1]+"/"+o[2]+"/"+o[0];return u+=i[2]||"",usi_date.string_to_date(u,t)}return a},usi_date.set_date=function(){var e=new Date,t=usi_commons.gup("usi_force_date");if(""!==t){t=decodeURIComponent(t);var a=usi_date.string_to_date(t,!0);null!=a?(e=a,usi_cookies.set("usi_force_date",t,usi_cookies.expire_time.hour),usi_commons.log("Date forced to: "+e)):usi_cookies.del("usi_force_date")}else e=null!=usi_cookies.get("usi_force_date")?usi_date.string_to_date(usi_cookies.get("usi_force_date"),!0):new Date;return e},usi_date.diff=function(e,t,a,s){null==s&&(s=1),""!=(a||"")&&(a=usi_date.get_units(a));var i=null;if(!0===usi_date.is_date(t)&&!0===usi_date.is_date(e))try{var r=Math.abs(t-e);switch(a){case"ms":i=r;break;case"seconds":i=usi_dom.to_decimal_places(parseFloat(r)/parseFloat(1e3),s);break;case"minutes":i=usi_dom.to_decimal_places(parseFloat(r)/parseFloat(1e3)/parseFloat(60),s);break;case"hours":i=usi_dom.to_decimal_places(parseFloat(r)/parseFloat(1e3)/parseFloat(60)/parseFloat(60),s);break;case"days":i=usi_dom.to_decimal_places(parseFloat(r)/parseFloat(1e3)/parseFloat(60)/parseFloat(60)/parseFloat(24),s)}}catch(e){i=null}return i},usi_date.convert_units=function(e,t,a,s){var i=null,r=null;switch(usi_date.get_units(t)){case"days":i=1e6*e*1e3*60*60*24;break;case"hours":i=1e6*e*1e3*60*60;break;case"minutes":i=1e6*e*1e3*60;break;case"seconds":i=1e6*e*1e3;break;case"ms":i=1e6*e}switch(usi_date.get_units(a)){case"days":r=usi_dom.to_decimal_places(parseFloat(i)/parseFloat(1e6)/parseFloat(1e3)/parseFloat(60)/parseFloat(60)/parseFloat(24),s);break;case"hours":r=usi_dom.to_decimal_places(parseFloat(i)/parseFloat(1e6)/parseFloat(1e3)/parseFloat(60)/parseFloat(60),s);break;case"minutes":r=usi_dom.to_decimal_places(parseFloat(i)/parseFloat(1e6)/parseFloat(1e3)/parseFloat(60),s);break;case"seconds":r=usi_dom.to_decimal_places(parseFloat(i)/parseFloat(1e6)/parseFloat(1e3),s);break;case"ms":r=usi_dom.to_decimal_places(parseFloat(i)/parseFloat(1e6),s)}return r},usi_date.get_units=function(e){var t="";switch(e.toLowerCase()){case"days":case"day":case"d":t="days";break;case"hours":case"hour":case"hrs":case"hr":case"h":t="hours";break;case"minutes":case"minute":case"mins":case"min":case"m":t="minutes";break;case"seconds":case"second":case"secs":case"sec":case"s":t="seconds";break;case"ms":case"milliseconds":case"millisecond":case"millis":case"milli":t="ms"}return t});

if (typeof usi_analytics === 'undefined') {
	usi_analytics = {
		cookie_length : 30,
		load_script:function(source) {
			var docHead = document.getElementsByTagName("head")[0];
			if (top.location != location) docHead = parent.document.getElementsByTagName("head")[0];
			var newScript = document.createElement('script');
			newScript.type = 'text/javascript';
			newScript.src = source;
			docHead.appendChild(newScript);
		},
		get_id:function() {
			var usi_id = null;
			try {
				if (usi_cookies.get('usi_analytics') == null && usi_cookies.get('usi_id') == null) {
					var usi_rand_str = Math.random().toString(36).substring(2);
					if (usi_rand_str.length > 6) usi_rand_str = usi_rand_str.substring(0, 6);
					usi_id = usi_rand_str + "_" + Math.round((new Date()).getTime() / 1000);
					usi_cookies.set('usi_id', usi_id, 30 * 86400, true);
					return usi_id;
				}
				if (usi_cookies.get('usi_analytics') != null) usi_id = usi_cookies.get('usi_analytics');
				if (usi_cookies.get('usi_id') != null) usi_id = usi_cookies.get('usi_id');
				usi_cookies.set('usi_id', usi_id, 30 * 86400, true);
			} catch(err) {
				usi_commons.report_error(err);
			}
			return usi_id;
		},
		send_page_hit:function(report_type, companyID, data1) {
			var qs = "";
			if (data1) qs += data1;
			usi_analytics.load_script(usi_commons.domain + "/analytics/hit.js?usi_a="+usi_analytics.get_id(companyID)+"&usi_t="+(Date.now())+"&usi_r="+report_type+"&usi_c="+companyID+qs+"&usi_u="+encodeURIComponent(location.href));
		}
	};
}
	try {
		usi_app = {};
		usi_app.main = function () {
			try {
				usi_app.url = location.href.toLowerCase();
				usi_app.is_enabled = usi_commons.gup_or_get_cookie("usi_enable", usi_cookies.expire_time.day, true) != "";
				usi_app.force_group = usi_commons.gup_or_get_cookie('usi_force_group');
				usi_app.page_visits = usi_app.get_page_visits();
				usi_app.coupon = usi_cookies.value_exists("usi_coupon_applied") ? "" : usi_commons.gup_or_get_cookie("usi_coupon", usi_cookies.expire_time.week, true);
				usi_app.cart_pids = [];

				usi_app.is_business = usi_app.url.indexOf("/business/") != -1;
				usi_app.is_home_page = location.pathname == "/fr/";
				usi_app.is_cart_page = location.href.indexOf("/cart") != -1;
				usi_app.is_checkout_page = location.href.indexOf("/checkout") != -1;
				usi_app.is_tv_page = usi_app.url.indexOf("/tvs/") != -1 || usi_app.url.indexOf("/lifestyle-tvs/") != -1;
				usi_app.is_upgrader = location.href.toLowerCase().indexOf("o5ytv") != -1 || usi_commons.gup("usi_churn").indexOf("o5ytv") != -1 || (usi_cookies.get("usi_churn") != null && usi_cookies.get("usi_churn").indexOf("o5ytv") != -1);
				usi_app.is_2ndtv = location.href.toLowerCase().indexOf("u5ytv") != -1 || usi_commons.gup("usi_churn").indexOf("u5ytv") != -1 || (usi_cookies.get("usi_churn") != null && usi_cookies.get("usi_churn").indexOf("u5ytv") != -1);
				usi_app.is_switcher = location.href.toLowerCase().indexOf("ppntv") != -1 || location.href.toLowerCase().indexOf("nppntv") != -1 || location.href.toLowerCase().indexOf("nptv") != -1 || usi_commons.gup("usi_churn").indexOf("ppntv") != -1 || (usi_cookies.get("usi_churn") != null && usi_cookies.get("usi_churn").indexOf("ppntv") != -1);
				if (usi_app.is_upgrader) {
					usi_cookies.set("usi_upgrader", "1", usi_cookies.expire_time.hour, true);
				} else if (usi_app.is_2ndtv) {
					usi_cookies.set("usi_2ndtv", "1", usi_cookies.expire_time.hour, true);
				} else if (usi_app.is_switcher) {
					usi_cookies.set("usi_switcher", "1", usi_cookies.expire_time.hour, true);
				}
				usi_app.site = "main";
				if (location.href.indexOf("/employee/") != -1 || location.href.indexOf("/fr_employee/") != -1) usi_app.site = "employee";
				else if (location.href.indexOf("frepp/macif") !== -1 || location.href.indexOf("/networks/") != -1 || location.href.indexOf("/fr_networks/") != -1) usi_app.site = "networks";
				else if (location.href.indexOf("fretudiants") != -1 || location.href.indexOf("/students/") != -1 || location.href.indexOf("/fr_student/") != -1) usi_app.site = "students";
				if ((location.href.indexOf("/smallbusiness") != -1 || location.href.indexOf("/fr/business/") != -1) && (location.href.indexOf("shop.samsung.com/fr/business") != -1 || location.href.indexOf("shop.samsung.com") == -1)) usi_app.site = "business";

				if (location.href.indexOf("/lydia") != -1 || location.href.indexOf("support") != -1) {
					//Suppressing https://shop.samsung.com/fr/multistore/frepp/lydia/r
					return;
				}

				setTimeout(usi_app.monitor_for_analytics, 100);


				// Apply coupons
				if (usi_app.is_cart_page && (usi_app.coupon != "" || usi_cookies.value_exists("usi_churn_coupon"))) {
					usi_app.apply_coupon();
				}
				if (usi_app.is_cart_page && usi_cookies.value_exists("usi_coupon_applied")) {
					if (usi_cookies.value_exists("usi_tradein_pid")) {
						var cart_rows = document.querySelectorAll(".cart-product-list .cart-row");
						for (var i = 0; i < cart_rows.length; i++) {
							if (cart_rows[i].querySelector(".cart-item-details .sku").textContent.trim().indexOf(usi_cookies.get("usi_tradein_pid")) != -1) {
								var target_element = cart_rows[i].querySelector(".added-services");
								if (target_element != null) {
									if (usi_commons.device == "desktop"){
										var usi_boost_css = [
											'#usi_trade_in__item { display: flex; font-size: 14px; position: relative;padding-top: 20px;border-top: 1px solid #ddd;margin-top: 20px; overflow: visible;}',
											'#usi_trade_in__item:before {content: "";background-image: url(https://prod.upsellit.com/chatskins/7419/tradein-product-logo.png); width: 31px;height: 31px;background-size: cover; position: absolute;left: -38px;top: 12px;}',
											'.usi_trade_in__discount {font-family: \'SamsungOne700\';font-size: 16px; color: #2189FF;}',
											'.usi_trade_in__title {font-family: \'SamsungOne800\';padding-bottom: 20px;}',
										].join('');

										var cart_html = [
											'<div class="usi_trade_in__content">',
											'<div class="usi_trade_in__title">Remise reprise Trade in TV</div>',
											'<p style="font-size: 13px;line-height: 15.59px;margin-bottom: 0;">En profitant de cette offre, vous acceptez ce qui suit :  la r\u00E9duction de prix conditionn\u00E9e \u00E0 la reprise de votre ancien TV constitue une incitation \u00E0 recycler votre ancien appareil (quelle que soit la marque); il ne s\'agit pas d\'une valeur de reprise pour le t\u00E9l\u00E9viseur recycl\u00E9, ladite reprise ne donnant lieu \u00E0 aucune compensation financi\u00E8re quelconque. La reprise de votre ancien TV doit intervenir dans les conditions suivantes : reprise concomitante \u00E0 la livraison de votre nouveau TV, \u00E9tant pr\u00E9cis\u00E9 que votre ancien appareil devra \u00EAtre pr\u00EAt pour la collecte au moment de la livraison de votre nouveau TV, c\u2019est-\u00E0-dire pr\u00E9alablement d\u00E9sinstall\u00E9 (incluant le d\u00E9montage et le d\u00E9branchement) par vos soins.</p>',
											'<p style="font-size: 13px;line-height: 15.59px;margin-bottom: 0;">Dans la mesure o\u00F9 vous aurez b\u00E9n\u00E9fici\u00E9 d\u2019une r\u00E9duction de prix conditionn\u00E9e \u00E0 la reprise de votre ancien appareil, la livraison de votre nouveau TV sera conditionn\u00E9e \u00E0 la reprise de l\u2019ancien appareil. A d\u00E9faut, il sera proc\u00E9d\u00E9 \u00E0 l\u2019annulation de la vente.</p>',
											'<p style="font-size: 13px;line-height: 15.59px;margin-bottom: 0;"><b>La reprise de votre ancien appareil intervient conform\u00E9ment \u00E0 la r\u00E9glementation en vigueur qui permet \u00E0 tout consommateur de faire reprendre gratuitement son ancien produit, dans la limite de la quantit\u00E9 et du type de produit concern\u00E9.</b></p>',
											'<p style="font-size: 13px;line-height: 15.59px;margin-bottom: 0;"><b>La remise reprise n\'est pas cumulable avec d\'autres codes promotionnels.</b></p>',
											'</div>',
											'<div class="usi_trade_in__discount">-',usi_cookies.get("usi_tradein_discount"),'\u20AC</div>',
										].join('');
										var usi_container = document.createElement("div");
										usi_container.setAttribute("id", "usi_trade_in__item");
										usi_container.setAttribute("class", "added-services");
										target_element.parentNode.insertBefore(usi_container, target_element);
										usi_container.innerHTML = cart_html;

										var usi_css = document.createElement("style");
										usi_css.type = "text/css";
										if (usi_css.styleSheet) usi_css.styleSheet.cssText = usi_boost_css;
										else usi_css.innerHTML = usi_boost_css;
										document.getElementsByTagName('head')[0].appendChild(usi_css);
									} else {
										var usi_boost_css = [
											'#usi_trade_in__item { font-size: 14px; position: relative;padding-top: 20px;border-top: 1px solid #ddd;margin-top: 20px; overflow: visible;}',
											'#usi_trade_in__item:before {content: "";background-image: url(https://prod.upsellit.com/chatskins/7419/tradein-product-logo.png); width: 31px;height: 31px;background-size: cover; position: absolute;left: 2px;top: 16px;}',
											'.usi_trade_in__discount {font-family: \'SamsungOne700\';font-size: 16px; color: #2189FF;}',
											'.usi_trade_in__title {font-family: \'SamsungOne800\';padding-bottom: 20px; margin-left: 31px;}',
										].join('');

										var cart_html = [
											'<div class="usi_trade_in__wrap">',
												'<div class="usi_trade_in__title">Remise reprise Trade in TV</div>',
												'<div class="usi_trade_in__discount">-',usi_cookies.get("usi_tradein_discount"),'\u20AC</div>',
											'</div>',
											'<div class="usi_trade_in__content">',
											'<p style="font-size: 13px;line-height: 15.59px;margin-bottom: 0;">En renseignant ce code promotionnel, vous reconnaissez et acceptez ce qui suit : Cette r\u00E9duction de prix est conditionn\u00E9e \u00E0 la reprise de votre ancien TV. Elle constitue une incitation \u00E0 recycler votre ancien appareil (quelle que soit la marque); il ne s\'agit pas d\'une valeur de reprise pour le t\u00E9l\u00E9viseur recycl\u00E9, ladite reprise ne donnant lieu \u00E0 aucune compensation financi\u00E8re quelconque.</p>',
											'<p style="font-size: 13px;line-height: 15.59px;margin-bottom: 0;">La reprise de votre ancien TV doit intervenir dans les conditions suivantes : reprise concomitante \u00E0 la livraison de votre nouveau TV, \u00E9tant pr\u00E9cis\u00E9 que votre ancien appareil devra \u00EAtre pr\u00EAt pour la collecte au moment de la livraison de votre nouveau TV, c\u2019est-\u00E0-dire pr\u00E9alablement d\u00E9sinstall\u00E9 (incluant le d\u00E9montage et le d\u00E9branchement) par vos soins. Dans la mesure o\u00F9 vous aurez b\u00E9n\u00E9fici\u00E9 d\u2019une r\u00E9duction de prix conditionn\u00E9e \u00E0 la reprise de votre ancien appareil, la livraison de votre nouveau TV sera conditionn\u00E9e \u00E0 la reprise de l\u2019ancien appareil. A d\u00E9faut, il sera proc\u00E9d\u00E9 \u00E0 l\u2019annulation de la vente.</p>',
											'<p style="font-size: 13px;line-height: 15.59px;margin-bottom: 0;"><b>La reprise de votre ancien appareil intervient conform\u00E9ment \u00E0 la r\u00E9glementation en vigueur qui permet \u00E0 tout consommateur de faire reprendre gratuitement son ancien produit, dans la limite de la quantit\u00E9 et du type de produit concern\u00E9.</b></p>',
											'<p style="font-size: 13px;line-height: 15.59px;margin-bottom: 0;"><b>La remise reprise n\'est pas cumulable avec d\'autres codes promotionnels.</b></p>',
											'</div>',
										].join('');
										var usi_container = document.createElement("div");
										usi_container.setAttribute("id", "usi_trade_in__item");
										usi_container.setAttribute("class", "added-services");
										target_element.parentNode.insertBefore(usi_container, target_element);
										usi_container.innerHTML = cart_html;

										var usi_css = document.createElement("style");
										usi_css.type = "text/css";
										if (usi_css.styleSheet) usi_css.styleSheet.cssText = usi_boost_css;
										else usi_css.innerHTML = usi_boost_css;
										document.getElementsByTagName('head')[0].appendChild(usi_css);
									}
								}
							}
						}
					}
				}

				usi_app.product_page_recs = "30819";
				usi_app.cart_page_recs = "30823";
				if (usi_app.site == "business") usi_app.product_page_recs = "41444";
				if (usi_app.site == "networks") usi_app.product_page_recs = "41448";
				if (usi_app.site == "students") usi_app.product_page_recs = "41446";

				if (usi_app.site !== "main" && usi_app.site !== "business") {
					//return usi_commons.log('main site only');
				}

				if (location.href.indexOf("/fr") == -1 || location.href.indexOf("mypage") != -1) {
					//Wrong site or order lookup page
					return;
				}

				if (location.href.indexOf("https://shop.samsung.com/fr/multistore/frredemption/rent_plus") != -1 || location.href.indexOf("https://shop.samsung.com/fr/multistore/frredemption/rent_plus_offers/") != -1 || location.href.indexOf("https://shop.samsung.com/fr/multistore/frepp/freestyle_insiders") != -1 || location.href.indexOf("https://shop.samsung.com/fr/multistore/frepp/cinnaxsamsung/") != -1 || location.href.indexOf("https://shop.samsung.com/fr/multistore/frpro/canalbusiness/") != -1 || location.href.indexOf("https://shop.samsung.com/fr/multistore/frredemption/cadre_offert_the_frame/") != -1 || location.href.indexOf("https://shop.samsung.com/fr/multistore/frepp/bt_epp/") != -1 || location.href.indexOf("https://shop.samsung.com/fr/multistore/frredemption/barre_de_son_offerte/") != -1 || location.href.indexOf("/fr/projectors/the-freestyle/the-freestyle-sp-lsp3blaxxe/") != -1 || location.href.indexOf("/cadre_offert_the_frame") != -1) {
					usi_commons.log("Suppression");
					return;
				}

				if (usi_cookies.get("usi_click_id") != null || usi_cookies.get("usi_email_id") != null) {
					if (usi_commons.gup("awc") != "") {
						usi_cookies.set("_aw_m_18417", usi_commons.gup("awc"), 365 * 30 * 24 * 60 * 60, true);
					}
				}

				if (usi_commons.gup("cid").indexOf("fr_owned_email_") != -1) {
					usi_cookies.set("usi_owned_optin", "1", usi_cookies.expire_time.year);
				}

				if (location.href.indexOf("usi_sess_") != -1) {
					var usi_sess = location.href.substring(location.href.indexOf("usi_sess_"), location.href.length);
					usi_sess = usi_sess.split("&")[0];
					if (usi_sess.substring(usi_sess.length - 1, usi_sess.length) == '_') {
						usi_sess = usi_sess.substring(0, usi_sess.length - 1);
					}
					usi_cookies.set("usi_email_id", usi_sess, 30 * 24 * 60 * 60, true);
					usi_commons.load_script("https://www.upsellit.com/launch/blank.jsp?samsung_email=" + usi_sess + "&url=" + encodeURIComponent(location.href));
					usi_app.link_injection("https://www.upsellit.com/email/link.jsp?s=" + usi_sess + "&l=1&a=1");
					usi_app.link_injection("https://www.awin1.com/cread.php?awinmid=18417&awinaffid=743003&clickref=&ued=https%3A%2F%2Fwww.upsellit.com%2Futility%2Fstrip_params.jsp%3Fparams_to_remove%3Dcid%2Cutm_source%2Cutm_medium%2Cutm_campaign%2Cutm_content%26final_url%3Dhttps%253A%252F%252Fwww.samsung.com%252Ffr%252F");
				}

				usi_app.is_epp = usi_app.url.indexOf("bouyguestelecom") != -1 || (usi_app.url.indexOf("/fr/web/") != -1 && usi_app.url.indexOf("/cart/") != -1 && usi_app.url.indexOf("/fr/web/cart/") == 0);
				if (usi_app.is_epp || usi_cookies.get("usi_epp") != null) {
					usi_cookies.set("usi_epp", "1", 30 * 24 * 60 * 60, true);
					return;
				}
				usi_app.monitor_for_receipt();
				if (usi_app.is_bezel_upsell() != null && usi_samsung.scrape_stock() == "INSTOCK") {
					usi_app.load_bezel();
				} else if (usi_app.is_qled_wallmount_upsell() != null) {
					usi_app.load_wall_mount();
				}
				var usi_first_hit = false;
				if (usi_cookies.get("usi_first_hit") == null) {
					usi_first_hit = true;
					usi_cookies.set("usi_first_hit", "1", 30 * 24 * 60 * 60, true);
				}
				if (usi_date.is_before("2022-12-31T22:59:59-00:00") && usi_commons.gup("cid").indexOf("fr_pd") != -1 && usi_commons.gup("cid").indexOf("NPTV") != -1) {
					var control_site_id = '44439';
					var group = usi_app.force_group || (Math.random() < 0.20 ? 0 : 1);
					usi_split_test.instantiate(control_site_id, group);
					if (usi_split_test.get_group(control_site_id) == '1') {
						//NEO QLED https://www.samsung.com/fr/tvs/qled-tv/neo-qled/?cid=fr_pd_social_facebook_neo-qled_hot_brun-abc-remarketing_dpa_1080x1080_rtg-card-abandoners-neo-qled
						//QLED https://www.samsung.com/fr/tvs/qled-tv/?cid=fr_pd_social_facebook_neo-qled_hot_brun-abc-remarketing_dpa_1080x1080_rtg-card-abandoners-qled-tv
						//OLED https://www.samsung.com/fr/tvs/oled-tv/s95b-55-inch-oled-4k-smart-tv-qe55s95batxxc/?cid=fr_pd_social_facebook_neo-qled_hot_brun-abc-remarketing_dpa_1080x1080_rtg-card-abandoners-oled
						//Lifestle https://www.samsung.com/fr/lifestyle-tvs/all-lifestyle-tvs/?cid=fr_pd_social_facebook_neo-qled_hot_brun-abc-remarketing_dpa_1080x1080_rtg-card-abandoners-lifestyle
						// Proactive TV remarketing
						var key;
						if (location.href.indexOf("/fr/tvs/qled-tv/neo-qled/") != -1) {
							key = "_neo";
						} else if (location.href.indexOf("/fr/tvs/qled-tv/") != -1) {
							key = "_qled";
						} else if (location.href.indexOf("/fr/tvs/oled-tv/s95b-55-inch-oled-4k-smart-tv-qe55s95batxxc/") != -1) {
							key = "_oled";
						} else if (location.href.indexOf("/fr/lifestyle-tvs/all-lifestyle-tvs/") != -1) {
							key = "_lifestyle";
						}
						usi_commons.load_view("ZztiodxU34dtsMnUc3mfKsr", "44437", usi_commons.device + key);
						usi_commons.log("Split Group: USI");
					} else {
						usi_commons.log("Split Group: Control");
					}

				} else if (usi_app.get_churn_proactive_msg(usi_app.url) != null) {
					var control_site_id = '43411';
					var group = usi_app.force_group || (Math.random() < 0.10 ? 0 : 1);
					usi_split_test.instantiate(control_site_id, group);
					if (usi_split_test.get_group(control_site_id) == '1') {
						//Upgrade https://www.samsung.com//fr/tvs/qled-tv/neo-qled/?usi_enable=1&usi_churn=o5ytv&usi_force_group=1
						//Swicher https://www.samsung.com/fr/tvs/qled-tv/neo-qled/?usi_enable=1&usi_churn=ppntv&usi_force_group=1
						//2nd TV https://www.samsung.com/fr/tvs/qled-tv/neo-qled/?usi_enable=1&usi_churn=u5ytv&usi_force_group=1
						usi_app.churn = usi_app.get_churn_proactive_msg(usi_app.url);
						// Proactive campaign loads the abandonment campaign
						usi_commons.load_view("nVyELyOLy3PDbbEOoXjMvva", "43453", usi_commons.device + usi_app.churn.campaign);
						usi_commons.log("Split Group: USI");
					} else {
						usi_commons.log("Split Group: Control");
					}
				} else if (usi_app.is_enabled && !usi_app.is_home_page && location.href.indexOf("/fr/search/") == -1 && location.href.indexOf("/fr/youmake/") == -1 && location.href.indexOf("/fr/support/") == -1 && location.href.indexOf("/multistore") == -1 && !usi_app.is_pdp_or_product() && !usi_samsung.is_product_page && !usi_app.is_cart_page && !usi_app.is_checkout_page && usi_app.site == "main" && !usi_cookies.value_exists("usi_owned_optin") && !usi_cookies.value_exists("usi_suppress37987") && usi_app.is_eligible_group("38031", 0.10)) {
					usi_app.wait_for_cookie_for_lead_capture();
				} else if (usi_samsung.is_product_page || document.body.className.indexOf("page-productDetails") != -1) {
					usi_app.send_product_data();
				} else if (usi_app.is_cart_page) {
					if (usi_commons.gup("usi_add") != "") {
						usi_app.add_items(usi_commons.gup("usi_add").replace("%2C", ","));
					}
					if (usi_cookies.value_exists("usi_bezel_to_add")) {
						usi_app.all_bezel();
					} else if (location.href.indexOf("multistore/frepp/bt_epp") == -1) {
						usi_app.scrape_cart();
					}
				}
				if (usi_app.get_churn_exit_msg(usi_app.cart_pids) && usi_app.is_cart_page) {
					var control_site_id = '43411';
					var group = usi_app.force_group || (Math.random() < 0.10 ? 0 : 1);
					usi_split_test.instantiate(control_site_id, group);
					if (usi_split_test.get_group(control_site_id) == '1') {
						//Upgrade https://www.samsung.com//fr/tvs/qled-tv/neo-qled/?usi_enable=1&usi_churn=o5ytv&usi_force_group=1
						//Swicher https://www.samsung.com/fr/tvs/qled-tv/neo-qled/?usi_enable=1&usi_churn=ppntv&usi_force_group=1
						//2nd TV https://www.samsung.com/fr/tvs/qled-tv/neo-qled/?usi_enable=1&usi_churn=u5ytv&usi_force_group=1
						usi_app.churn = usi_app.get_churn_exit_msg(usi_app.cart_pids);
						// Proactive campaign loads the abandonment campaign
						usi_commons.load_view("X6dngf7sTM8nS2cqdh0AKI9", "43525", usi_commons.device + usi_app.churn.campaign);
						usi_commons.log("Split Group: USI");
					} else {
						usi_commons.log("Split Group: Control");
					}
				}
				if (usi_commons.gup("usi_open_oos") != "") {
					document.getElementsByClassName("tg-out-stock")[0].click();
				}

			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.load_wall_mount = function() {
			try {
				var control_site_id = '37339';
				var group = usi_app.force_group || (Math.random() < 0.10 ? 0 : 1);
				usi_split_test.instantiate(control_site_id, group);
				if (usi_split_test.get_group(control_site_id) == '1') {
					usi_app.load_qled_wallmount();
					usi_commons.log("Split Group: USI");
				} else {
					usi_commons.log("Split Group: Control");
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		}

		usi_app.apply_coupon = function () {
			usi_commons.log("usi_app.apply_coupon()");
			var coupon_input = document.querySelector("#promocode");
			var coupon_button = document.querySelector(".submit-promo-code");
			if (coupon_input !== null && coupon_button !== null) {
				coupon_input.value = usi_app.coupon;
				usi_cookies.set("usi_coupon_applied", usi_app.coupon, usi_cookies.expire_time.week);
				usi_cookies.del("usi_coupon");
				usi_app.coupon = "";
				coupon_button.disabled = false;
				coupon_button.click();
				setTimeout(usi_app.post_apply_coupon, 2000);
				usi_commons.log("Coupon applied");
			} else {
				if (usi_app.coupon_attempts == undefined) {
					usi_app.coupon_attempts = 0;
				} else if (usi_app.coupon_attempts >= 5) {
					usi_commons.report_error("Coupon elements not found");
					return;
				}
				usi_app.coupon_attempts++;
				usi_commons.log("Coupon elements missing, trying again. Tries: " + usi_app.coupon_attempts);
				setTimeout(usi_app.apply_coupon, 1000);
			}
		};
		usi_app.post_apply_coupon = function () {
			var error_element = document.querySelector(".promo-error-msg");
			var error_message_exists = error_element != null && error_element.textContent.trim() != "";
			if (error_message_exists) {
				usi_commons.report_error("Coupon error message seen");
			} else {
				usi_commons.log_success("Coupon application was successful");
			}
		};

		usi_app.wait_for_cookie_for_lead_capture = function () {
			try {
				// entrance LC
				if (usi_app.site !== "main" && !usi_app.is_enabled) {
					return;
				}
				if (usi_app.session_data.country == "us" || (usi_cookies.get("notice_gdpr_prefs") != null && usi_cookies.get("notice_gdpr_prefs").indexOf(",2") != -1)) {
					usi_cookies.set("usi_first_hit", "1", 30 * 24 * 60 * 60, true);
					usi_commons.load_view("IoEus10U9NvBe3MZWVZvERD", "37987", usi_commons.device);
				} else {
					setTimeout(usi_app.wait_for_cookie_for_lead_capture, 1000);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.is_pdp_or_product = function () {
			try {
				if (digitalData.page.pageInfo.pageTrack.indexOf("pdp") != -1) return true;
				if (digitalData.page.pageInfo.pageTrack == "product detail") return true;
			} catch (err) {
				return false;
			}
			return false;
		};

		usi_cookies.create_cookie = function (name, value, exp_seconds) {
			try {
				if (navigator.cookieEnabled === false) {
					return;
				}
				if (usi_app.session_data.country != "us" && (usi_cookies.get("notice_gdpr_prefs") == null || usi_cookies.get("notice_gdpr_prefs").indexOf(",2") == -1)) {
					//Only set cookies if the customer has opted in
					return;
				}
				var expires = "";
				if (exp_seconds != -1) {
					var date = new Date();
					date.setTime(date.getTime() + (exp_seconds * 1000));
					expires = "; expires=" + date.toGMTString();
				}
				var usi_security = "samesite=none;";
				if (location.href.indexOf("https://") == 0) {
					usi_security += "secure;";
				}
				var usi_domain = usi_cookies.root_domain();
				if (typeof (usi_parent_domain) != "undefined" && document.domain.indexOf(usi_parent_domain) != -1) {
					usi_domain = usi_parent_domain;
				}
				document.cookie = name + "=" + encodeURIComponent(value) + expires + "; path=/;domain=" + usi_domain + "; " + usi_security;
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.is_eligible_group = function (control_site_id, control_size) {
			try {
				if (!control_site_id) return usi_commons.log("control_site_id required");
				var group = usi_app.force_group || (Math.random() < control_size ? 0 : 1);
				usi_split_test.instantiate(control_site_id, group);
				if (usi_split_test.get_group(control_site_id) == '1') {
					usi_commons.log("Split Group: USI " + control_site_id);
					return true;
				} else {
					usi_commons.log("Split Group: Control " + control_site_id);
					return false;
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.load_bezel = function () {
			try {
				if (usi_app.site !== "main" && !usi_app.is_enabled) {
					return;
				}
				usi_app.load_product_data({
					siteID: usi_app.product_page_recs,
					pid: usi_app.is_bezel_upsell(),
					rows: 100,
					allow_dupe_names: 1,
					//nomatch: "OUTOFSTOCK",
					force_exact: 1,
					callback: function () {
						usi_app.remove_loads();
						var ua = window.navigator.userAgent;
						var msie = ua.indexOf('MSIE ') != -1; // IE 10 or older
						var trident = ua.indexOf('Trident/') != -1; //IE 11
						if (!msie && !trident) {
							usi_commons.load("BtuhwqwRJAo1BV6ioIfdZzd", "35077");
						}
					}
				});
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.all_bezel = function () {
			try {
				var usi_bezel = usi_cookies.get("usi_bezel_to_add");
				usi_cookies.del("usi_bezel_to_add")
				usi_app.add_items(usi_bezel);
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.add_items = function (items, callback) {
			try {
				if (usi_app.site == "students" || usi_app.site == "networks") {
					var usi_url = "https://shop.samsung.com/fr/multistore/frepp/macif/cart/add";
					if (usi_app.site == "students") {
						usi_url = "https://shop.samsung.com/fr/multistore/fretudiants/etudiants/cart/add";
					}
					var items_split = items.split(",");


					var postOptions = {};
					postOptions.paramsDataType = 'formData';
					postOptions.url = usi_url;
					postOptions.params = new FormData();
					postOptions.params.append('qty', "1");
					postOptions.params.append('productCodePost', items_split[0]);
					postOptions.params.append('CSRFToken', ACC.config.CSRFToken);
					postOptions.params.append('recommendation', 'true');
					postOptions.params.append('forcedAddToCart', 'true');
					usi_ajax.post_with_options(postOptions, function (err, postResult) {
						if (items_split.length > 1) {
							setTimeout(function() {
								usi_app.add_items(items.replace(items_split[0] + ",", ""));
								}, 50);
						} else {
							usi_app.go_to_cart();
						}
					});

					for (var i = 0; i < items_split.length; i++) {

					}
				} else if (usi_app.site == "business") {
					var usi_prods = "";
					var items_split = items.split(",");
					for (var i = 0; i < items_split.length; i++) {
						if (usi_prods != "") usi_prods += ",";
						usi_prods += '{"productCode":"'+items_split[i]+'","quantity":"1"}';
					}
					$.ajax({
						url: "https://shop.samsung.com/fr/business/servicesv2/addToCart",
						type: "POST",
						dataType: "json",
						cache: !0,
						crossDomain: !0,
						contentType: "application/json",
						timeout: 3E4,
						xhrFields: {
							withCredentials: !0
						},
						data: '{"products":['+usi_prods+']}',
						success: function () {
							callback();
						},
						error: function (a) {
							console.log(a)
						}
					})
				} else {
					var usi_qs = "";
					var items_split = items.split(",");
					for (var i = 0; i < items_split.length; i++) {
						if (usi_qs != "") usi_qs += "&";
						usi_qs += "products%5B" + i + "%5D.productCode=" + items_split[i] + "&products%5B" + i + "%5D.quantity=1";
					}
					usi_commons.load_script("https://shop.samsung.com/fr/ng/p4v1/addToCart?" + usi_qs + "&callback=usi_app.go_to_cart");
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.go_to_cart = function (a) {
			try {
				if (a) {
					var all_oos = a.products.filter(function (a) {
						return a.resultMessage.indexOf("no longer available") == -1
					}).length == 0;
					var empty = document.querySelector(".cart-heading.cart-empty h1")
					if (all_oos && empty != null) {
						return empty.textContent = "Votre produit est temporairement en rupture de stock";
					}
				}
				if (usi_app.site == "students") window.location = "https://shop.samsung.com/fr/multistore/fretudiants/etudiants/cart/";
				else if (usi_app.site == "networks") window.location = "https://shop.samsung.com/fr/multistore/frepp/macif/cart/";
				else if (usi_app.site == "business") window.location = "https://shop.samsung.com/fr/business/cart/";
				else window.location = "https://shop.samsung.com/fr/cart";
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.add_tradein = function (items, callback) {
			try {
				var usi_destination = "fr";
				usi_commons.log("usi_app.add_to_cart: " + items);
				var pids_split = items.split(",");
				var pids_array = [];
				for (var i = 0; i < pids_split.length; i++) {
					pids_array.push({
						"productCode": pids_split[i],
						"qty": 1,
						"services": []
					});
				}
				$.ajax({
					url: "https://p1-smn2-api-cdn.shop.samsung.com/tokocommercewebservices/v2/" + usi_destination + "/addToCart/multi?fields=BASIC",
					type: "POST",
					dataType: "json",
					cache: !0,
					crossDomain: !0,
					contentType: "application/json",
					timeout: 3E4,
					xhrFields: {
						withCredentials: !0
					},
					data: JSON.stringify(pids_array),
					success: function () {
						callback();
					},
					error: function (a) {
						console.log(a)
					}
				})
			} catch (err) {
				usi_commons.report_error(err);
			}
		}

		usi_app.link_injection = function (destination) {
			try {
				var usi_dynamic_div = document.createElement("div");
				usi_dynamic_div.innerHTML = "<iframe style='width: 1px; height: 1px;' src='" + destination + "'></iframe>";
				document.getElementsByTagName('body')[0].appendChild(usi_dynamic_div);
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.monitor_for_receipt = function () {
			try {
				if (location.href.indexOf("order-success") != -1 || location.href.indexOf("orderConfirmation") != -1 || location.href.indexOf("order-confirm") != -1) {
					usi_commons.load_script('https://www.upsellit.com/active/samsungfrance_pixel.jsp');
				} else if (typeof AWIN != 'undefined' && typeof AWIN.Tracking != 'undefined' && typeof AWIN.Tracking.Sale != 'undefined') {
					usi_commons.load_script("https://www.upsellit.com/active/samsungfrance_pixel.jsp");
				} else {
					setTimeout(usi_app.monitor_for_receipt, 2000);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.is_bezel_upsell = function () {
			try {
				if (location.href.toUpperCase().indexOf("QE43LS03AAUXXC") != -1) {
					return "VG-SCFA43BWBXC,VG-SCFA43TKBXC,VG-SCFA43WTBXC";
				}
				if (location.href.toUpperCase().indexOf("QE50LS03AAUXXC") != -1) {
					return "VG-SCFA50BWBXC,VG-SCFA50TKBXC,VG-SCFA50WTBXC";
				}
				if (location.href.toUpperCase().indexOf("QE55LS03AAUXXC") != -1) {
					return "VG-SCFA55BWBXC,VG-SCFA55TKBXC,VG-SCFA55WTBXC,VG-SCFA55TRCXC,VG-SCFA55WTCXC";
				}
				if (location.href.toUpperCase().indexOf("QE65LS03AAUXXC") != -1) {
					return "VG-SCFA65BWBXC,VG-SCFA65TKBXC,VG-SCFA65WTBXC,VG-SCFA65TRCXC,VG-SCFA65WTCXC";
				}
				if (location.href.toUpperCase().indexOf("QE75LS03AAUXXC") != -1) {
					return "VG-SCFA75BWBXC,VG-SCFA75TKBXC,VG-SCFA75WTBXC";
				}
				if (location.href.toUpperCase().indexOf("QE85LS03AAUXXC") != -1) {
					return "VG-SCFA85TKBXC,VG-SCFA85WTBXC";
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
			return null;
		};

		usi_app.load_qled_wallmount = function () {
			try {
				if (usi_app.site !== "main" && !usi_app.is_enabled) {
					return;
				}
				usi_app.load_product_data({
					siteID: usi_app.product_page_recs,
					pid: usi_app.is_qled_wallmount_upsell(),
					nomatch: "OUTOFSTOCK",
					rows: 1,
					allow_dupe_names: 1,
					force_exact: 1,
					callback: function () {
						usi_app.remove_loads();
						var ua = window.navigator.userAgent;
						var msie = ua.indexOf('MSIE ') != -1; // IE 10 or older
						var trident = ua.indexOf('Trident/') != -1; //IE 11
						if (!msie && !trident) {
							if (typeof (usi_app.product_rec.product0) != "undefined") {
								usi_app.product_rec_wallmount = usi_app.product_rec;
								usi_commons.load("4xTfcFZaeHUzTEEdjhM1MdA", "37305");
							}
						}
					}
				});
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.all_qled_wallmount = function () {
			try {
				var usi_qled_wallmount = usi_cookies.get("usi_qled_wallmount_to_add");
				usi_cookies.del("usi_qled_wallmount_to_add")
				usi_app.add_items(usi_qled_wallmount);
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.is_in_install_region = function () {
			try {
				var region = usi_app.state;
				if (region === "--") {
					usi_app.is_in_install_region_callback(0);
				} else {
					usi_commons.load_script(usi_commons.cdn + '/utility/lookup_suppression.jsp?companyID=7419&callback=usi_app.is_in_install_region_callback&label=WMInstallRegions&product=' + region);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.is_in_install_region_callback = function (found, json) {
			try {
				if (found == 1 || false) {
					var control_site_id = '37339';
					var group = usi_app.force_group || (Math.random() < 0.10 ? 0 : 1);
					usi_split_test.instantiate(control_site_id, group);
					if (usi_split_test.get_group(control_site_id) == '1') {
						usi_app.load_qled_wallmount();
						usi_commons.log("Split Group: USI");
					} else {
						usi_commons.log("Split Group: Control");
					}
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.is_qled_wallmount_upsell = function() {
			try {
				if (location.href.toUpperCase().indexOf("QE65LST7TCUXXC") != -1) { return "WMN4277TT/XC"; }
				if (location.href.toUpperCase().indexOf("QE75LST7TCUXXC") != -1) { return "WMN4277TT/XC"; }
				if (location.href.toUpperCase().indexOf("QE98QN90AATXXC") != -1) { return "WMN-A50EB/XC"; }
				if (typeof(usi_app.cart) !== "undefined" && usi_app.cart.length > 0) {
					if (usi_app.cart[0].pid == "QE65LST7TCUXXC")  { return "WMN4277TT/XC"; }
					if (usi_app.cart[0].pid == "QE75LST7TCUXXC")  { return "WMN4277TT/XC"; }
					if (usi_app.cart[0].pid == "QE98QN90AATXXC") { return "WMN-A50EB/XC"; }
				}
				return null;
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.listen_for_scroll = function() {
			var pageOffset = window.pageYOffset;
			var pageHeight = document.body.scrollHeight;
			if (pageOffset /  pageHeight > .2 || window.pageYOffset > 1400) {
				usi_commons.load_view("6aT1H0DjWICFtRVtjonDavh", "41938", usi_commons.device);
			} else {
				setTimeout(usi_app.listen_for_scroll, 1000);
			}
		};

		usi_app.load_product_page = function () {
			try {
				if (usi_app.url.match("/fr/business/climate/heating/ac-ehs-ae080bxydeg-eu/") != null) {
					return;
				}
				if (usi_app.site == "main" && usi_app.is_enabled) {
					setTimeout(usi_app.listen_for_scroll, 3000);
					usi_app.seconds_inactive(3,function(){
						usi_commons.load_view("6aT1H0DjWICFtRVtjonDavh", "41938", usi_commons.device);
					});
				}
				if (usi_app.is_bezel_upsell() != null && usi_samsung.scrape_stock() == "INSTOCK") {
					usi_app.load_bezel();
				} else if (typeof (usi_app.product_page_data) !== "undefined" && usi_app.product_page_data.extra.toLowerCase().indexOf("outofstock") != -1 && location.href.indexOf("/fr/washers-and-dryers/washing-machines/ww5000t-front-loading-eco-bubble-hygiene-steam-dit-7kg-ivorywhite-ww70ta046tt-ef") == -1 && location.href.indexOf("/fr/refrigerators/side-by-side/rs8000nc--8-609l-silver-rs68a8520s9-ef") == -1 && location.href.indexOf("/fr/refrigerators/french-door/rf9000ac-non-dispenser-fdr-with-triple-cooling-650l-silver-rf65a90tfsl-ef") == -1 && location.href.indexOf("/fr/vacuum-cleaners/stick/vs9000rl-silver-vs20t7536pa-ef") == -1 && usi_app.product_page_data.category.indexOf("tv") == -1 && usi_app.product_page_data.category.indexOf("television") == -1) {
					usi_app.product = usi_app.product_page_data;
					usi_app.depth_level = 3;
					usi_app.load_oos();
				}
				if (usi_date.is_after("2022-12-08T08:59:59-00:00") && !usi_cookies.value_exists("usi_tradein_coupon") && usi_samsung.scrape_stock() == "INSTOCK" && "QE85QN85BATXXC|QE65QN700BTXXC|QE55QN700BTXXC|QE75QN700BTXXC|QE85QN800BTXXC|QE65QN800BTXXC|QE55QN85BATXXC|QE75QN85BATXXC|QE75QN800BTXXC|QE65QN85BATXXC|QE75QN900BTXXC|QE65QN900BTXXC|QE85QN900BTXXC|QE50QN90BATXXC|QE65QN90BATXXC|QE75QN90BATXXC|QE43QN90BATXXC|QE55QN90BATXXC|QE85QN90BATXXC|QE65QN95BATXXC|QE75QN95BATXXC|QE85QN95BATXXC|QE55QN95BATXXC|QE55S95BATXXC|QE65S95BATXXC|QE50Q80BATXXC|QE55Q80BATXXC|QE65Q80BATXXC|QE75Q80BATXXC|QE85Q80BATXXC|QE55LS01BAUXXC|QE55LS01BBUXXC|QE50LS01BBUXXC|QE43LS01BAUXXC|QE43LS01BBUXXC|QE65LS01BAUXXC|QE65LS01BBUXXC|QE50LS01BAUXXC|QE55LS03BAUXXC|QE50LS03BAUXXC|QE43LS03BAUXXC|QE32LS03BBUXXC|QE85LS03BAUXXC|QE65LS03BAUXXC|QE75LS03BAUXXC|QE43LS05BAUXXC".indexOf(usi_app.product_page_data.pid) != -1) {
					usi_commons.load_view("WOgCrdTtCCOe7KaodjFMxBZ", "44995");
					usi_commons.load("t2KX9kYW4siWSJKJSrKQIcx", "44929", "test");
				}
				if (usi_app.site == "networks" || usi_app.site == "students") {
					usi_app.listen_for_add();
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.get_page_visits = function() {
			try {
				usi_commons.log("usi_app.get_page_visits()");
				var page_visits = Number(usi_cookies.get("usi_page_visits")) + 1;
				usi_cookies.set("usi_page_visits", page_visits, usi_cookies.expire_time.day);
				usi_commons.log("Page visit: " + page_visits);
				return page_visits;
			} catch(err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.get_churn_proactive_msg = function (url) {
			try {
				if (url.indexOf("/fr/tvs/qled-tv/neo-qled/") == -1) return null;
				var churn = {};
				if (usi_app.is_upgrader) {
					churn.campaign = "_upgrade";
				} else if (usi_app.is_2ndtv) {
					churn.campaign = "_2ndtv";
				} else if (usi_app.is_switcher) {
					churn.campaign = "_switcher";
				}
				if (!usi_app.is_upgrader && !usi_app.is_2ndtv && !usi_app.is_switcher) {
					return null;
				}
				return churn;
			} catch(err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.get_churn_exit_msg = function (pid) {
			try {
				if (pid.join("|").match(/QE65QN95BATXXC|QE85QN95BATXXC|QE75QN95BATXXC|QE55QN95BATXXC|QE43QN90BATXXC|QE55QN90BATXXC|QE50QN90BATXXC|QE75QN90BATXXC|QE65QN90BATXXC|QE85QN90BATXXC|QE85QN900BTXXC|QE75QN900BTXXC|QE65QN900BTXXC|QE75QN85BATXXC|QE65QN85BATXXC|QE55QN85BATXXC|QE85QN85BATXXC|QE65QN800BTXXC|QE85QN800BTXXC|QE75QN800BTXXC|QE55QN700BTXXC|QE65QN700BTXXC|QE75QN700BTXXC/i) != null) {
					var churn = {};
					if (usi_cookies.value_exists("usi_upgrader")) {
						churn.campaign = "_upgrade";
					} else if (usi_cookies.value_exists("usi_2ndtv")) {
						churn.campaign = "_2ndtv";
					} else if (usi_cookies.value_exists("usi_switcher")) {
						churn.campaign = "_switcher";
					}
				} else {
					return null;
				}
				if (!usi_cookies.value_exists("usi_upgrader") && !usi_cookies.value_exists("usi_2ndtv") && !usi_cookies.value_exists("usi_switcher")) {
					return null;
				}
				return churn;
			} catch(err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.listen_for_add = function() {
			try {
				if (document.getElementById("addToCartNotificationModal") != null && document.getElementById("addToCartNotificationModal").className == "modal fade in show") {
					usi_app.offer = {};
					usi_app.load_product_data({
						siteID: usi_app.product_page_recs,
						association_siteID: usi_app.cart_page_recs,
						pid: usi_app.product_page_data.pid,
						nomatch: "OUTOFSTOCK",
						allow_dupe_names: 1,
						days_back: 2,
						rows: 20,
						callback: function () {
							if (typeof (usi_app.product_rec.product1) != "undefined") {
								usi_app.product_acc_offer = usi_app.product_rec;
								var usi_customizations = "";
								var i = 1;
								while (typeof (usi_app.product_acc_offer['product' + i]) != "undefined") {
									usi_customizations += usi_app.grab_customizations(usi_app.product_acc_offer['product' + i].extra);
									i++;
								}
								if (usi_customizations != "") {
									usi_app.load_product_data({
										siteID: usi_app.product_page_recs,
										match: usi_customizations,
										pid: "matching",
										nomatch: 'OUTOFSTOCK,model_name":""',
										allow_dupe_names: 1,
										days_back: 7,
										rows: 200,
										callback: function () {
											usi_app.product_acc_offer_colours = usi_app.product_rec;
											if (usi_app.site == "students") {
												usi_commons.load("JdP2RyoiyUu9c4fKtFAPJ3L", "42492", "test", function() { setTimeout(function() { document.getElementById("addToCartNotificationModal").getElementsByClassName("modal-close-button")[0].click(); }, 1000); });
											} else {
												usi_commons.load("BRTljMlJc9CjXdqrhirSCb1", "41720", "test", function() { setTimeout(function() { document.getElementById("addToCartNotificationModal").getElementsByClassName("modal-close-button")[0].click(); }, 1000); });
											}
										}
									});
								} else {
									usi_app.product_acc_offer_colours = usi_app.product_rec;
									if (usi_app.site == "students") {
										usi_commons.load("JdP2RyoiyUu9c4fKtFAPJ3L", "42492", "test", function() { setTimeout(function() { document.getElementById("addToCartNotificationModal").getElementsByClassName("modal-close-button")[0].click(); }, 1000); });
									} else {
										usi_commons.load("BRTljMlJc9CjXdqrhirSCb1", "41720", "test", function() { setTimeout(function() { document.getElementById("addToCartNotificationModal").getElementsByClassName("modal-close-button")[0].click(); }, 1000); });
									}
								}
							}
						}
					});
				} else {
					setTimeout(usi_app.listen_for_add, 500);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		}
		usi_app.load_cart_recs = function (cart) {
			try {
				usi_app.cart = cart;
				var usi_nomatch = "%7B%7B,/smartphones/,OUTOFSTOCK,PREORDER,";
				var usi_match = "";
				for (var i = 0; i < usi_app.cart.length; i++) {
					usi_nomatch += usi_app.cart[i].pid.substring(0, 9) + "," + usi_app.cart[i].pid;
					if (typeof (usi_app.get_rec(usi_app.cart[i].pid)) !== "undefined") {
						usi_match += usi_app.get_rec(usi_app.cart[i].pid) + ",";
					}
				}
				var usi_pid = usi_app.cart[0].pid;
				if (usi_app.is_qled_wallmount_upsell() != null && usi_nomatch.indexOf(usi_app.is_qled_wallmount_upsell()) == -1) {
					usi_app.load_product_data({
						siteID: usi_app.product_page_recs,
						pid: usi_app.is_qled_wallmount_upsell(),
						nomatch: usi_nomatch,
						force_exact: 1,
						rows: 1,
						callback: function () {
							usi_app.product_rec_colours = usi_app.product_rec;
							if (typeof (usi_app.product_rec.product0) != "undefined") {
								usi_app.remove_loads();
								usi_commons.load("aSLkRbMje6dIUlkbnKQDtPI", "37319");
							}
						}
					});
				} else {
					usi_app.load_product_data({
						siteID: usi_app.product_page_recs,
						association_siteID: usi_app.cart_page_recs,
						pid: usi_pid,
						nomatch: usi_nomatch,
						match: usi_match,
						//less_expensive: true,
						rows: 7,
						callback: function () {
							if (typeof (usi_app.product_rec.product4) != "undefined") {
								var usi_customizations = "";
								usi_customizations += usi_app.grab_customizations(usi_app.product_rec.product1.extra);
								usi_customizations += usi_app.grab_customizations(usi_app.product_rec.product2.extra);
								usi_customizations += usi_app.grab_customizations(usi_app.product_rec.product3.extra);
								usi_customizations += usi_app.grab_customizations(usi_app.product_rec.product4.extra);
								usi_customizations += usi_app.grab_customizations(usi_app.product_rec.product5.extra);
								usi_customizations += usi_app.grab_customizations(usi_app.product_rec.product6.extra);
								usi_customizations += usi_app.grab_customizations(usi_app.product_rec.product7.extra);
								usi_commons.log("usi_customizations: " + usi_customizations);
								if (usi_customizations != "") {
									usi_app.product_rec_temp = usi_app.product_rec;
									usi_app.load_product_data({
										siteID: usi_app.product_page_recs,
										pid: "cache1b",
										rows: 100,
										match: usi_customizations,
										nomatch: usi_nomatch,
										allow_dupe_names: 1,
										force_exact: 1,
										callback: function () {
											usi_app.product_rec_colours = usi_app.product_rec;
											usi_app.product_rec = usi_app.product_rec_temp;
											usi_force = 1;
											usi_app.remove_loads();
											if (usi_app.site == "students") {
												if (usi_app.is_eligible_group("41584", 0.10)) {
													usi_commons.load("SrpDQbfR7ms5kN36RN3OkMF", "41570", "cart");
												}
											} else if (usi_app.site == "networks") {
												if (usi_app.is_eligible_group("41586", 0.10)) {
													usi_commons.load("6UxRPraIj4gyfCPYdGKpwfs", "41572", "cart");
												}
											} else if (usi_app.site == "business") {
												if (usi_app.is_eligible_group("41588", 0.10)) {
													usi_commons.load("fy5ylLM3phUtMqhOrbUxMrO", "41574", "cart");
												}
											} else {
												usi_commons.load("4n1rMHOohgLdhy1n8V8Dg39", "34349", "cart");
											}
										}
									});
								} else {
									usi_app.product_rec_colours = usi_app.product_rec;
									usi_force = 1;
									usi_app.remove_loads();
									var usi_key = "";
									if (usi_app.site == "students") {
										if (usi_app.is_eligible_group("41584", 0.10)) {
											usi_commons.load("SrpDQbfR7ms5kN36RN3OkMF", "41570", "cart");
										}
									} else if (usi_app.site == "networks") {
										if (usi_app.is_eligible_group("41586", 0.10)) {
											usi_commons.load("6UxRPraIj4gyfCPYdGKpwfs", "41572", "cart");
										}
									} else if (usi_app.site == "business") {
										if (usi_app.is_eligible_group("41588", 0.10)) {
											usi_commons.load("fy5ylLM3phUtMqhOrbUxMrO", "41574", "cart");
										}
									} else {
										usi_commons.load("4n1rMHOohgLdhy1n8V8Dg39", "34349", "cart");
									}
								}
							}
						}
					});
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.is_smart_tag_offer = function (pid) {
			var skus = {};
			skus["SM-A526BLVDEUH"] = "1";
			skus["SM-A526BZBDEUH"] = "1";
			skus["SM-A526BZKDEUH"] = "1";
			skus["SM-A526BZWDEUH"] = "1";
			skus["SM-F707BZAAXEF"] = "1";
			skus["SM-F707BZNAXEF"] = "1";
			skus["SM-F916BBKAXEF"] = "1";
			skus["SM-F916BBNAXEF"] = "1";
			skus["SM-F916BDKAXEF"] = "1";
			skus["SM-F916BDNAXEF"] = "1";
			skus["SM-F916BRKAXEF"] = "1";
			skus["SM-F916BRNAXEF"] = "1";
			skus["SM-F916BSKAXEF"] = "1";
			skus["SM-F916BSNAXEF"] = "1";
			skus["SM-F916BZKAXEF"] = "1";
			skus["SM-F916BZNAXEF"] = "1";
			skus["SM-G780FZGDEUH"] = "1";
			skus["SM-G780GLVDEUH"] = "1";
			skus["SM-G780GZBDEUH"] = "1";
			skus["SM-G780GZRDEUH"] = "1";
			skus["SM-G780GZWDEUH"] = "1";
			skus["SM-G781BLVDEUH"] = "1";
			skus["SM-G781BZBDEUH"] = "1";
			skus["SM-G781BZBHEUH"] = "1";
			skus["SM-G781BZGDEUH"] = "1";
			skus["SM-G781BZODEUH"] = "1";
			skus["SM-G781BZRDEUH"] = "1";
			skus["SM-G781BZWDEUH"] = "1";
			skus["SM-G991BZADEUH"] = "1";
			skus["SM-G991BZAGEUH"] = "1";
			skus["SM-G991BZIDEUH"] = "1";
			skus["SM-G991BZIGEUH"] = "1";
			skus["SM-G991BZVDEUH"] = "1";
			skus["SM-G991BZVGEUH"] = "1";
			skus["SM-G991BZWDEUH"] = "1";
			skus["SM-G991BZWGEUH"] = "1";
			skus["SM-G996BIDDEUH"] = "1";
			skus["SM-G996BIDGEUH"] = "1";
			skus["SM-G996BZKDEUH"] = "1";
			skus["SM-G996BZKGEUH"] = "1";
			skus["SM-G996BZRDEUH"] = "1";
			skus["SM-G996BZRGEUH"] = "1";
			skus["SM-G996BZSDEUH"] = "1";
			skus["SM-G996BZSGEUH"] = "1";
			skus["SM-G996BZVDEUH"] = "1";
			skus["SM-G996BZVGEUH"] = "1";
			skus["SM-G998BDBDEUH"] = "1";
			skus["SM-G998BDBGEUH"] = "1";
			skus["SM-G998BDBHEUH"] = "1";
			skus["SM-G998BZKDEUH"] = "1";
			skus["SM-G998BZKGEUH"] = "1";
			skus["SM-G998BZKHEUH"] = "1";
			skus["SM-G998BZNDEUH"] = "1";
			skus["SM-G998BZNGEUH"] = "1";
			skus["SM-G998BZNHEUH"] = "1";
			skus["SM-G998BZSDEUH"] = "1";
			skus["SM-G998BZSGEUH"] = "1";
			skus["SM-G998BZSHEUH"] = "1";
			skus["SM-G998BZTDEUH"] = "1";
			skus["SM-G998BZTGEUH"] = "1";
			skus["SM-G998BZTHEUH"] = "1";
			skus["SM-N986BZKGEUB"] = "1";
			skus["SM-N986BZNGEUB"] = "1";
			skus["SM-N986BZWGEUB"] = "1";
			skus["SM-P610NZAAXEF"] = "1";
			skus["SM-P610NZBAXEF"] = "1";
			skus["SM-P615NZAAXEF"] = "1";
			skus["SM-P615NZBAXEF"] = "1";
			skus["SM-R190NZKAEUB"] = "1";
			skus["SM-R190NZSAEUB"] = "1";
			skus["SM-R190NZVAEUB"] = "1";
			skus["SM-R820NZDAXEF"] = "1";
			skus["SM-R820NZKAXEF"] = "1";
			skus["SM-R820NZSAXEF"] = "1";
			skus["SM-R825FZKAXEF"] = "1";
			skus["SM-R830NADAXEF"] = "1";
			skus["SM-R830NZDAXEF"] = "1";
			skus["SM-R830NZKAXEF"] = "1";
			skus["SM-R830NZSAXEF"] = "1";
			skus["SM-R835FZDAXEF"] = "1";
			skus["SM-R840NTKAEUB"] = "1";
			skus["SM-R840NZKAEUB"] = "1";
			skus["SM-R840NZSAEUB"] = "1";
			skus["SM-R845FZKAEUB"] = "1";
			skus["SM-R845FZSAEUB"] = "1";
			skus["SM-R850NZDAEUB"] = "1";
			skus["SM-R850NZSAEUB"] = "1";
			skus["SM-R855FZDAEUB"] = "1";
			skus["SM-R855FZSAEUB"] = "1";
			skus["SM-T500NZAAEUH"] = "1";
			skus["SM-T500NZAEEUH"] = "1";
			skus["SM-T500NZSAEUH"] = "1";
			skus["SM-T505NZAAEUH"] = "1";
			skus["SM-T505NZAEEUH"] = "1";
			skus["SM-T720NZDAXEF"] = "1";
			skus["SM-T720NZKAXEF"] = "1";
			skus["SM-T720NZKLXEF"] = "1";
			skus["SM-T720NZSAXEF"] = "1";
			skus["SM-T720NZSLXEF"] = "1";
			skus["SM-T725NZKAXEF"] = "1";
			skus["SM-T725NZKLXEF"] = "1";
			skus["SM-T870NDBAEUH"] = "1";
			skus["SM-T870NZKAEUH"] = "1";
			skus["SM-T870NZKEEUH"] = "1";
			skus["SM-T870NZNAEUH"] = "1";
			skus["SM-T870NZNEEUH"] = "1";
			skus["SM-T870NZSAEUH"] = "1";
			skus["SM-T870NZSEEUH"] = "1";
			skus["SM-T875NZKAEUH"] = "1";
			skus["SM-T875NZKEEUH"] = "1";
			skus["SM-T875NZNEEUH"] = "1";
			skus["SM-T970NDBEEUH"] = "1";
			skus["SM-T970NZKAEUH"] = "1";
			skus["SM-T970NZKEEUH"] = "1";
			skus["SM-T970NZNAEUH"] = "1";
			skus["SM-T970NZNEEUH"] = "1";
			skus["SM-T970NZSAEUH"] = "1";
			skus["SM-T970NZSEEUH"] = "1";
			skus["SM-T976BDBEEUH"] = "1";
			skus["SM-T976BZKAEUH"] = "1";
			skus["SM-T976BZKEEUH"] = "1";
			skus["SM-T976BZNEEUH"] = "1";
			skus["SM-T976BZSEEUH"] = "1";
			return skus[pid] !== "undefined";
		}
		usi_app.get_better_qled = function (pid) {
			var skus = {};
			skus["QE55QN85AATXXC"] = "QE65QN85AATXXC";
			skus["QE65QN85AATXXC"] = "QE75QN85AATXXC";
			skus["QE75QN85AATXXC"] = "QE85QN85AATXXC";
			skus["QE55QN95AATXXC"] = "QE65QN95AATXXC";
			skus["QE65QN95AATXXC"] = "QE75QN95AATXXC";
			skus["QE75QN95AATXXC"] = "QE85QN95AATXXC";
			skus["QE65QN800ATXXC"] = "QE75QN800ATXXC";
			skus["QE75QN800ATXXC"] = "QE85QN800ATXXC";
			skus["QE65QN900ATXXC"] = "QE75QN900ATXXC";
			skus["QE75QN900ATXXC"] = "QE85QN900ATXXC";
			return skus[pid];
		};
		usi_app.get_better_tv = function (pid) {
			try {
				var skus = {};
				skus["QE43LS01TBUXXC"] = "QE49LS01TBUXXC";
				skus["QE43LS01TAUXXC"] = "QE49LS01TAUXXC";
				skus["QE32LS03TBKXXC"] = "QE43LS03TAUXXC";
				skus["QE43LS03TAUXXC"] = "QE50LS03TAUXXC";
				skus["QE50LS03TAUXXC"] = "QE55LS03TAUXXC";
				skus["QE55LS03TAUXXC"] = "QE65LS03TAUXXC";
				skus["QE43Q60TAUXXC"] = "QE50Q60TAUXXC";
				skus["QE50Q60TAUXXC"] = "QE55Q60TAUXXC";
				skus["QE55Q60TAUXXC"] = "QE65Q60TAUXXC";
				skus["QE65Q60TAUXXC"] = "QE75Q60TAUXXC";
				return skus[pid];
			} catch (err) {
				usi_commons.report_error(err);
			}
		};


		usi_app.get_rec = function (pid) {
			try {
				var skus = {};
				skus["QE65Q95TATXXC"] = "BDS Q800T,HW-Q90R/ZF,VG-SOCR15/XC,WMN-M15EA/XC";
				skus["UE32T5375CUXXC"] = "HW-T420/ZF,HW-Q60T/ZF";
				skus["QE55LST7TCUXXC"] = "HW-LST70T,WMN4070TT/XC";
				skus["QE65LST7TCUXXC"] = "HW-LST70T,WMN4277TT/XC";
				skus["QE75LST7TCUXXC"] = "HW-LST70T,WMN4277TT/XC";
				skus["UE43TU7025KXXC"] = "HW-A450/ZF,HW-A550/ZF,HW-A650/ZF,HW-Q60T/ZF";
				skus["UE50TU7025KXXC"] = "HW-A450/ZF,HW-A550/ZF,VG-SEST11K/XC,HW-A650/ZF";
				skus["UE55TU7025KXXC"] = "HW-A450/ZF,HW-A550/ZF,VG-SEST11K/XC,HW-A650/ZF";
				skus["UE65TU7025KXXC"] = "HW-A550/ZF,HW-A450/ZF,VG-SEST11K/XC,HW-A650/ZF";
				skus["UE70TU7025KXXC"] = "HW-A550/ZF,HW-A450/ZF,HW-A650/ZF,HW-Q60T/ZF";
				skus["UE75TU7025KXXC"] = "HW-A550/ZF,HW-A450/ZF,HW-A650/ZF,HW-Q60T/ZF";
				skus["UE43AU7105KXXC"] = "HW-A450/ZF,HW-A550/ZF,HW-A650/ZF,HW-Q60T/ZF";
				skus["UE50AU7105KXXC"] = "HW-A450/ZF,HW-A550/ZF,VG-SEST11K/XC,HW-Q60T/ZF";
				skus["UE55AU7105KXXC"] = "HW-A550/ZF,HW-A450/ZF,VG-SEST11K/XC,HW-Q60T/ZF";
				skus["UE65AU7105KXXC"] = "HW-A550/ZF,HW-A450/ZF,VG-SEST11K/XC,HW-Q60T/ZF";
				skus["UE75AU7105KXXC"] = "HW-A550/ZF,HW-A450/ZF,HW-A650/ZF,HW-Q60T/ZF";
				skus["UE85AU7105KXXC"] = "HW-A550/ZF,HW-A450/ZF,HW-A650/ZF,HW-Q60T/ZF";
				skus["UE43AU8075UXXC"] = "HW-A650/ZF,HW-A550/ZF,WMN-A50EB/XC,HW-Q60T/ZF";
				skus["UE50AU8075UXXC"] = "HW-A650/ZF,HW-A550/ZF,WMN-A50EB/XC,HW-Q60T/ZF";
				skus["UE55AU8075UXXC"] = "HW-A650/ZF,HW-A550/ZF,VG-SESA11K/XC,WMN-A50EB/XC";
				skus["UE60AU8075UXXC"] = "HW-A650/ZF,HW-A550/ZF,VG-SESA11K/XC,WMN-A50EB/XC";
				skus["UE65AU8075UXXC"] = "HW-A650/ZF,HW-A550/ZF,VG-SESA11K/XC,WMN-A50EB/XC";
				skus["UE75AU8075UXXC"] = "HW-A650/ZF,HW-A550/ZF,WMN-A50EB/XC,HW-A450/ZF";
				skus["UE85AU8075UXXC"] = "HW-A650/ZF,HW-A550/ZF,WMN-A50EB/XC,HW-A450/ZF";
				skus["QE43Q60AAUXXC"] = "HW-Q600A/ZF,HW-Q700A/ZF,WMN-A50EB/XC,HW-Q60T/ZF";
				skus["QE50Q60AAUXXC"] = "HW-Q600A/ZF,HW-Q700A/ZF,WMN-A50EB/XC,HW-Q60T/ZF";
				skus["QE55Q60AAUXXC"] = "HW-Q600A/ZF,HW-Q700A/ZF,VG-SESA11K/XC,WMN-A50EB/XC";
				skus["QE65Q60AAUXXC"] = "HW-Q600A/ZF,HW-Q700A/ZF,VG-SESA11K/XC,WMN-A50EB/XC";
				skus["QE75Q60AAUXXC"] = "HW-Q600A/ZF,HW-Q700A/ZF,WMN-A50EB/XC,HW-Q60T/ZF";
				skus["QE85Q60AAUXXC"] = "HW-Q600A/ZF,HW-Q700A/ZF,WMN-A50EB/XC,HW-Q60T/ZF";
				skus["QE50Q80AATXXC"] = "HW-Q800A/ZF,HW-Q700A/ZF,HW-Q60T/ZF,HW-Q800T/ZF";
				skus["QE55Q80AATXXC"] = "HW-Q800A/ZF,HW-Q700A/ZF,VG-SESA11K/XC,HW-Q800T/ZF";
				skus["QE65Q80AATXXC"] = "HW-Q800A/ZF,HW-Q700A/ZF,VG-SESA11K/XC,HW-Q800T/ZF";
				skus["QE75Q80AATXXC"] = "HW-Q800A/ZF,HW-Q700A/ZF,HW-Q800T/ZF,HW-Q60T/ZF";
				skus["QE85Q80AATXXC"] = "HW-Q800A/ZF,HW-Q700A/ZF,HW-Q800T/ZF,HW-Q60T/ZF";
				skus["QE55QN85AATXXC"] = "HW-Q800A/ZF,HW-Q700A/ZF,WMN-A50EB/XC,HW-Q60T/ZF";
				skus["QE65QN85AATXXC"] = "HW-Q800A/ZF,HW-Q700A/ZF,WMN-A50EB/XC,HW-Q60T/ZF";
				skus["QE75QN85AATXXC"] = "HW-Q800A/ZF,HW-Q700A/ZF,WMN-A50EB/XC,HW-Q60T/ZF";
				skus["QE85QN85AATXXC"] = "HW-Q800A/ZF,HW-Q700A/ZF,WMN-A50EB/XC,HW-Q60T/ZF";
				skus["QE50QN90AATXXC"] = "HW-Q800A/ZF,HW-Q700A/ZF,WMN-A50EB/XC,HW-Q60T/ZF";
				skus["QE55QN95AATXXC"] = "HW-Q800A/ZF,VG-SOCA05/XC,WMN-A50EB/XC,HW-Q700A/ZF";
				skus["QE65QN95AATXXC"] = "HW-Q800A/ZF,VG-SOCA05/XC,WMN-A50EB/XC,HW-Q700A/ZF";
				skus["QE75QN95AATXXC"] = "HW-Q800A/ZF,VG-SOCA05/XC,WMN-A50EB/XC,HW-Q700A/ZF";
				skus["QE85QN95AATXXC"] = "HW-Q800A/ZF,VG-SOCA05/XC,WMN-A50EB/XC,HW-Q700A/ZF";
				skus["QE65QN800ATXXC"] = "HW-Q800A/ZF,VG-SOCA05/XC,WMN-A50EB/XC,HW-Q60T/ZF";
				skus["QE75QN800ATXXC"] = "HW-Q800A/ZF,VG-SOCA05/XC,WMN-A50EB/XC,HW-Q60T/ZF";
				skus["QE85QN800ATXXC"] = "HW-Q800A/ZF,VG-SOCA05/XC,WMN-A50EB/XC,HW-Q60T/ZF";
				skus["QE65QN900ATXXC"] = "HW-Q800A/ZF,VG-SOCA05/XC,WMN-A50EB/XC,HW-Q60T/ZF";
				skus["QE75QN900ATXXC"] = "HW-Q800A/ZF,VG-SOCA05/XC,WMN-A50EB/XC,HW-Q60T/ZF";
				skus["QE85QN900ATXXC"] = "HW-Q800A/ZF,VG-SOCA05/XC,WMN-A50EB/XC,HW-Q60T/ZF";
				skus["QE43LS03AAUXXC"] = "HW-S61A/ZF,HW-S41T/ZF,VG-SOCR15,VG-SESA11K/XC";
				skus["QE50LS03AAUXXC"] = "HW-S61A/ZF,HW-S41T/ZF,VG-SOCR15,VG-SESA11K/XC";
				skus["QE55LS03AAUXXC"] = "HW-S61A/ZF,HW-S41T/ZF,VG-SOCR16,VG-SESA11K/XC";
				skus["QE65LS03AAUXXC"] = "HW-S61A/ZF,HW-S41T/ZF,VG-SOCR17,VG-SESA11K/XC";
				skus["QE75LS03AAUXXC"] = "HW-S61A/ZF,HW-S41T/ZF,VG-SOCR18,VG-SESA11K/XC";
				skus["QE32LS03TCUXXC"] = "VG-SCFT32xx/XC,HW-S50A/ZF,HW-S41T/ZF,HW-Q60T/ZF";
				skus["QE43LS05TCUXXC"] = "VG-SCST43V/XC,HW-S61A/ZF,HW-S41T/ZF,HW-Q60T/ZF";
				skus["QE50LS01TAUXXC"] = "HW-S41T/ZF,HW-S61A/ZF,HW-Q60T/ZF";
				skus["QE50LS01TBUXXC"] = "HW-S41T/ZF,HW-S61A/ZF,HW-Q60T/ZF";
				skus["QE58Q60TAUXXC"] = "HW-Q600A/ZF,HW-Q700A/ZF,VG-SESA11K/XC,WMN-A50EB/XC";
				skus["VG-SOCR15"] = "QE75LS03AAUXXC,QE65LS03AAUXXC,QE55LS03AAUXXC,QE50LS03AAUXXC";
				return skus[pid];
			} catch (err) {
				usi_commons.report_error(err);
			}
		}

		usi_app.get_oos_matches = function (pid) {
			var skus = {};
			skus["QE43LS03AAUXXC"] = "QE50LS03AAUXXC,QE55LS03AAUXXC,QE65LS03AAUXXC,QE75LS03AAUXXC,QE85LS03AAUXXC";
			skus["HW-Q950A/ZF"] = "HW-Q800A/ZF,HW-Q700A/ZF,HW-Q600A/ZF";
			skus["HW-Q900A/ZF"] = "HW-Q800A/ZF,HW-Q700A/ZF,HW-Q600A/ZF";
			return skus[pid];
		}

		usi_app.load_oos = function () {
			try {
				var force_exact = 1;
				var usi_match = usi_samsung.scrape_category(usi_app.depth_level) + ",";
				usi_app.load_product_data({
					siteID: usi_app.product_page_recs,
					association_siteID: "30819",
					pid: usi_app.product.pid,
					rows: 4,
					allow_dupe_names: 1,
					match: usi_match,
					nomatch: "%7B%7B,\"original_price\":\"0.0\",OUTOFSTOCK,PREORDER",
					force_exact: force_exact,
					callback: function () {
						if (typeof (usi_app.product_rec.product4) != "undefined") {
							usi_app.remove_loads();
							if (usi_app.site == "students") {
								if (usi_app.is_eligible_group("41590", 0.10)) {
									usi_commons.load("NcWIVXyPIkMSxeSlWVRMZml", "41576");
								}
							} else if (usi_app.site == "networks") {
								if (usi_app.is_eligible_group("41592", 0.10)) {
									usi_commons.load("GHSttT53NvU1KnC4x078tcZ", "41578");
								}
							} else if (usi_app.site == "business") {
								if (usi_app.is_eligible_group("41582", 0.10)) {
									usi_commons.load("rISOre7wQ9dKjdY42rSByi6", "41580");
								}
							} else {
								usi_commons.load("Ggj22lpSrIrAzGMGWHFn89u", "34091");
							}
						} else if (usi_app.depth_level > 1) {
							var usi_previous_level = usi_samsung.scrape_category(usi_app.depth_level).split("~").length;
							if (usi_previous_level[usi_previous_level - 1] == "accessories") {
								//Don't go deeper than accessories
								usi_commons.log("Found accessories, that's sort of bedrock");
							} else {
								usi_app.depth_level--;
								usi_app.load_oos();
							}
						}
					}
				});
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.remove_loads = function () {
			try {
				usi_commons.remove_loads();
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.scrape_cart = function (is_rescrape) {
			usi_commons.log("usi_app.scrape_cart()");
			try {
				if (document.getElementsByClassName('shopping-cart-product-row').length == 0) {
					usi_app.scrape_cart2(false);
				} else {
					var usi_pid = "";
					var usi_other_pids = "";
					var usi_product_names = "";
					var cart_rows = document.getElementsByClassName('shopping-cart-product-row');
					var prod_array = [], product;
					// Scrape cart info
					for (var i = 0; i < cart_rows.length; i++) {
						if (document.getElementsByClassName("sc-product-ship-name").length != 0){
							var usi_next_pid = document.getElementsByClassName("sc-product-ship-name")[i].innerText;
							usi_app.cart_pids.push(usi_next_pid);
							if (i == 0) {
								usi_pid = usi_next_pid;
							}
							usi_other_pids += usi_next_pid + ",";
							var usi_name = document.getElementsByClassName("sc-product-name")[i].innerText;
							usi_other_pids += encodeURIComponent(usi_name.replace("cart:", "")).replace(/\+/g, /%2B/) + ",";
							usi_product_names += usi_name + ",";
						}

						var row = cart_rows[i];
						product = {};
						if (row.querySelector(".sc-product-pic a") != null) product.link = row.querySelector(".sc-product-pic a").href;
						product.image = row.querySelector(".sc-product-pic img").src;
						product.name = row.querySelector(".sc-product-name").textContent.trim();
						product.price = usi_samsung.standardize_currency(row.querySelector(".current-price").textContent);
						if (row.querySelector(".sc-product-ship-name") != null) {
							product.pid = row.querySelector(".sc-product-ship-name").textContent;
						} else {
							product.pid = row.querySelector(".sc-product-pic a").getAttribute("data-omni-variant");
						}
						prod_array.push(product);
					}
					if (prod_array.length > 0) {
						usi_cookies.set_json("usi_cart", prod_array, 24 * 60 * 60);
						usi_cookies.set("usi_subtotal", document.getElementsByClassName("os-price-row total-price-row")[0].innerText.replace(/[^0-9\.,]+/g, ""), 24 * 60 * 60);
						if (!is_rescrape) {
							if (usi_cookies.value_exists("usi_cart") && !usi_cookies.value_exists("usi_churn_coupon")) {
								usi_app.load_lead_capture();
							}
							usi_app.load_cart_recs(prod_array);
						}
					} else {
						setTimeout(usi_app.scrape_cart, 2000);
					}
				}

			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.scrape_cart2 = function (is_rescrape) {
			try {
				var usi_pid = "";
				var usi_other_pids = "";
				var usi_product_names = "";
				var cart_rows = document.getElementsByClassName('cart-row');
				var prod_array = [], product;
				// Scrape cart info
				for (var i = 0; i < cart_rows.length; i++) {

					var row = cart_rows[i];
					product = {};
					product.link = row.getElementsByTagName("a")[0].href;
					product.image = row.getElementsByTagName("img")[0].src;
					product.name = row.getElementsByTagName("img")[0].alt;
					product.price = usi_samsung.standardize_currency(row.getElementsByClassName('item-price')[0].innerText.split("\n")[0]);
					product.pid = row.getElementsByClassName('sku')[0].innerText;
					usi_app.cart_pids.push(product.pid);
					if (i == 0) {
						usi_pid = product.pid;
					}
					prod_array.push(product);
				}
				if (prod_array.length > 0) {
					usi_cookies.set_json("usi_cart", prod_array, 24 * 60 * 60);
					usi_cookies.set("usi_subtotal", document.getElementsByClassName('grand-total')[1].innerText.replace(/[^0-9\.,]+/g, ""), 24 * 60 * 60);
					if (!is_rescrape) {
						if (usi_cookies.value_exists("usi_cart") && !usi_cookies.value_exists("usi_churn_coupon")) {
							usi_app.load_lead_capture();
						}
						usi_app.load_cart_recs(prod_array);
					}
				} else {
					setTimeout(usi_app.scrape_cart, 2000);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.load_lead_capture = function () {
			usi_commons.log("usi_app.load_lead_capture()");
			if (usi_app.site !== "main" && !usi_app.is_enabled) {
				return;
			}
			try {
				if (usi_app.is_enabled) {
					if (usi_app.session_data.country == "us" || (usi_cookies.get("notice_gdpr_prefs") != null && usi_cookies.get("notice_gdpr_prefs").indexOf(",2") != -1)) {
						if (document.getElementsByClassName("gnb__user-name").length == 0 || (document.getElementsByClassName("gnb__user-name").length > 1 && document.getElementsByClassName("gnb__user-name")[1].innerText.trim() == "")) {
							usi_commons.load_view("xfnuxQ1358DfDd2Tpdeluww", "34341", usi_commons.device);
						}
					}
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.grab_customizations = function (json_str) {
			try {
				var usi_pids = "";
				if (typeof (json_str) == "undefined") return "";
				var extra = JSON.parse(json_str.replace(/&quot;+/g, "\""));
				extra.customizable = extra.customizable.replace("colour:", "colour~").replace("color:", "color~");
				usi_commons.log("extra.customizable: ", extra.customizable);
				if (typeof (extra.customizable) != "undefined" && (extra.customizable.indexOf("color~") == 0 || extra.customizable.indexOf("colour~") == 0)) {
					return extra.customizable.split("~")[2] + ",";
				} else {
					return "";
				}
				return usi_pids;
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.seen = function (usi_products, id, site_id) {
			try {
				usi_app.current_upsells = usi_products;
				if (usi_cookies.get("usi_" + site_id + "_c") == null) {
					usi_commons.load_script("https://www.upsellit.com/utility/update_launch_point.jsp?id=" + id + "&trackingInfo=" + usi_commons.get_id() + "~" + encodeURIComponent(usi_products));
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.seen2 = function (id, site_id, config_id, seenProducts, targetProduct) {
			try {
				usi_prodrec.report_product_view2(id, site_id, config_id, seenProducts, targetProduct);
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.clicked = function (usi_clicked, id, site_id) {
			try {
				if (!id) id = usi_js.campaign.id;
				if (!site_id) site_id = usi_js.campaign.site_id;
				if (usi_clicked == "") return;
				if (usi_app.current_upsells.indexOf(usi_clicked) != -1) {
					var usi_products = usi_clicked.split(",");
					for (var i = 0; i < usi_products.length; i++) {
						if (usi_app.current_upsells.indexOf(usi_products[i] + "[C]") == -1) {
							usi_app.current_upsells = usi_app.current_upsells.replace(usi_products[i], usi_products[i] + "[C]");
						}
					}
				} else {
					usi_app.current_upsells += "," + usi_clicked + "[C]";
				}
				usi_cookies.set("usi_" + site_id + "_c", usi_app.current_upsells, 7 * 24 * 60 * 60, true);
				usi_commons.load_script("https://www.upsellit.com/utility/update_launch_point.jsp?id=" + id + "&trackingInfo=" + usi_commons.get_id() + "~" + encodeURIComponent(usi_app.current_upsells));
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.clicked2 = function (id, site_id, config_id, clickedProducts, targetProduct, usi_callback) {
			try {
				usi_prodrec.report_product_click2(id, site_id, config_id, clickedProducts, targetProduct, usi_callback);
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.load_product_data = function (options) {
			usi_commons.log("usi_app.load_product_data()");
			try {
				var queryStr = "";
				if (options.siteID) queryStr += '?siteID=' + options.siteID;
				if (options.association_siteID) queryStr += '&association_siteID=' + options.association_siteID;
				if (options.pid) queryStr += '&pid=' + options.pid;
				if (options.less_expensive) queryStr += '&less_expensive=1';
				if (options.rows) queryStr += '&rows=' + options.rows;
				if (options.days_back) queryStr += '&days_back=' + options.days_back;
				if (options.match) queryStr += '&match=' + options.match;
				if (options.nomatch) queryStr += '&nomatch=' + options.nomatch;
				if (options.force_exact) queryStr += '&force_exact=' + options.force_exact;
				if (options.allow_dupe_names) queryStr += '&allow_dupe_names=' + options.allow_dupe_names;
				usi_commons.load_script(usi_commons.cdn + '/utility/product_recommendations.jsp' + queryStr, function () {
					if (typeof options.callback === 'function' && typeof usi_app.product_rec !== 'undefined') {
						options.callback(usi_app.product_rec);
					}
				});
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.send_product_data = function () {
			try {
				var current_prod = usi_app.scrape_product_page();
				if (current_prod != null && current_prod.name != "" && current_prod.pid != "" && current_prod.image.indexOf("https://images.samsung.com/") != -1 && current_prod.price != "" && (current_prod.link.indexOf("www.samsung.com") != -1 || current_prod.link.indexOf("shop.samsung.com") != -1)) {
					if (usi_samsung.check_for_consistency(current_prod)) {
						if (document.getElementsByClassName("owl-item active").length > 0 && document.getElementsByClassName("owl-item active")[0].getElementsByClassName("thumbnails-image ng-scope selected").length == 0) {
							//This is not the right product image
						} else {
							usi_app.product_page_data = current_prod;
							usi_app.last_pid = current_prod.pid;
							usi_app.last_price = current_prod.price;
							usi_commons.send_prod_rec(usi_app.product_page_recs, current_prod, true); //current_prod.stock == "OUTOFSTOCK");
							usi_commons.log(current_prod);
							usi_app.load_product_page();
						}
					}
				}
				setTimeout(usi_app.send_product_data, 2000);
			} catch (err) {
				usi_commons.report_error(err);
			}
		};
		usi_app.scrape_product_page = function () {
			try {
				var product = {};
				product.pid = usi_samsung.scrape_sku();
				product.name = usi_samsung.scrape_name();
				product.link = usi_samsung.scrape_link();
				product.image = usi_samsung.scrape_image();
				product.category = usi_samsung.scrape_category(3);
				product.category2 = usi_samsung.scrape_category2();
				product.stock = usi_samsung.scrape_stock();
				product.price = usi_samsung.scrape_price();
				product.msrp = usi_samsung.scrape_msrp();
				if (product.stock == "OUTOFSTOCK" && product.price == "") product.price = "0.0";
				if (product.stock == "OUTOFSTOCK" && product.msrp == "") product.msrp = "0.0";
				if (Number(product.price) == 0) {
					product.stock = "OUTOFSTOCK"; //prevent zeros
				}
				var usi_customizable = usi_samsung.scrape_customizations();
				var usi_rating = usi_samsung.scrape_ratings();
				var usi_model_name = usi_samsung.scrape_model_name();
				product.extra = JSON.stringify({
					category: product.category,
					category2: product.category2,
					original_price: product.msrp,
					stock: product.stock,
					rating: usi_rating,
					customizable: usi_customizable,
					model_name: usi_model_name
				});
				return product;
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.check_for_idle = function () {
			var date = new Date();
			var time_to_go = usi_app.launch_delay - (date.getTime() - usi_app.timestamp);
			usi_commons.log("usi_app.check_for_idle " + time_to_go);
			if (time_to_go <= 0) {
				if (typeof usi_js == "undefined" || !usi_js.launch.launched) {
					usi_app.inactive_callback();
				}
			} else {
				setTimeout(usi_app.check_for_idle, time_to_go);
			}
		}
		usi_app.reset_timer = function () {
			var date = new Date();
			usi_app.timestamp = date.getTime();
		}
		usi_app.seconds_inactive = function (seconds, callback) {
			usi_commons.log("usi_app.seconds_inactive")
			usi_app.launch_delay = seconds * 1000;
			usi_app.inactive_callback = callback;
			usi_app.reset_timer();
			usi_app.check_for_idle();
			document.addEventListener("mousemove", usi_app.reset_timer, false);
			document.addEventListener("mousedown", usi_app.reset_timer, false);
			document.addEventListener("keypress", usi_app.reset_timer, false);
			document.addEventListener("touchmove", usi_app.reset_timer, false);
			document.addEventListener("click", usi_app.reset_timer, false);
			document.addEventListener("scroll", usi_app.reset_timer, false);
		}

		usi_app.session_data_callback = function() {
			usi_app.country = usi_app.session_data.country;
			usi_app.state = usi_app.session_data.state;
			setTimeout(usi_app.main, 2000);
		};

		usi_commons.load_session_data(true);

		usi_app.monitor_for_analytics = function() {
			try {
				if (typeof(usi_app.last_url) === "undefined" || usi_app.last_url != location.href) {
					usi_app.last_url = location.href;
					usi_analytics.send_page_hit("VIEW", "7419");
				}
				setTimeout(usi_app.monitor_for_analytics, 2000);
			} catch(err) {
				usi_commons.report_error(err);
			}
		};

	} catch (err) {
		usi_commons.report_error(err);
	}
}