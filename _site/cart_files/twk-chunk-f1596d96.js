(window.tawkJsonp=window.tawkJsonp||[]).push([["chunk-f1596d96"],{"0bdc":function(t,e,i){"use strict";i.r(e);var s=i("4ba0").a,o=i("2877"),n=Object(o.a)(s,(function(){var t=this,e=t.$createElement,i=t._self._c||e;return i("i-frame",{attrs:{cssLink:t.cssLink,styleObject:t.styleObject,width:t.width,height:t.height}},[i("div",{ref:"tawk-bubble-container",staticClass:"tawk-bubble-container",attrs:{id:"tawk-bubble-container",role:"button",tabindex:"0"},on:{click:t.toggleWidget,keyup:function(e){return!e.type.indexOf("key")&&t._k(e.keyCode,"enter",13,e.key,"Enter")?null:t.toggleWidget.apply(null,arguments)}}},["text"===t.bubble.type?i("div",[i("canvas",{ref:"tawk-canvas-bubble",attrs:{id:"tawk-canvas-bubble",width:"146px",height:"85px"}}),i("div",{staticClass:"tawk-bubble-text-container\n\t\t\t\t\t\ttawk-flex\n\t\t\t\t\t\ttawk-flex-center\n\t\t\t\t\t\ttawk-flex-middle",style:{top:t.isBottom||t.isCenter?"5px":"auto",bottom:t.isBottom||t.isCenter?"auto":"5px",left:"auto",right:"9px"},attrs:{id:"tawk-bubble-text-container"}},[i("p",{staticClass:"tawk-text-center tawk-text-italic",style:{color:t.bubble.config.foreground},attrs:{id:"tawk-bubble-text"}},[t._v(" "+t._s(t.bubble.config.content)+" ")])]),i("div",{directives:[{name:"tawk-tooltip",rawName:"v-tawk-tooltip",value:{position:this.isBottom||this.isCenter?"":"bottom"},expression:"{position : (this.isBottom || this.isCenter ? '' : 'bottom')}"}],style:t.textCloseButton,attrs:{role:"button",tabindex:"0","data-text":t.$i18n("form","CloseButton"),"aria-label":t.$i18n("form","CloseButton")},on:{click:t.bubbleClose,keydown:function(e){return!e.type.indexOf("key")&&t._k(e.keyCode,"enter",13,e.key,"Enter")?null:t.bubbleClose.apply(null,arguments)}}})]):i("div",{class:t.closeButtonPosition},[i("tawk-icon",{directives:[{name:"tawk-tooltip",rawName:"v-tawk-tooltip"}],attrs:{type:"close",size:"small",role:"button",tabindex:"0","data-text":t.$i18n("form","CloseButton"),"aria-label":t.$i18n("form","CloseButton")},on:{click:t.bubbleClose,keydown:function(e){return!e.type.indexOf("key")&&t._k(e.keyCode,"enter",13,e.key,"Enter")?null:t.bubbleClose.apply(null,arguments)}}}),i("img",{style:{width:this.bubble.config.width+"px",height:this.bubble.config.height+"px"},attrs:{src:t.imageUrl,alt:""+t.$i18n("bubble","attention_grabber")}})],1)])])}),[],!1,null,null,null);e.default=n.exports},"4ba0":function(t,e,i){"use strict";(function(t){var s=i("5a60"),o=i("2f62"),n=i("f0b0"),a=i("87dd");function r(t,e){var i=Object.keys(t);if(Object.getOwnPropertySymbols){var s=Object.getOwnPropertySymbols(t);e&&(s=s.filter((function(e){return Object.getOwnPropertyDescriptor(t,e).enumerable}))),i.push.apply(i,s)}return i}function b(t){for(var e=1;e<arguments.length;e++){var i=null!=arguments[e]?arguments[e]:{};e%2?r(Object(i),!0).forEach((function(e){l(t,e,i[e])})):Object.getOwnPropertyDescriptors?Object.defineProperties(t,Object.getOwnPropertyDescriptors(i)):r(Object(i)).forEach((function(e){Object.defineProperty(t,e,Object.getOwnPropertyDescriptor(i,e))}))}return t}function l(t,e,i){return e in t?Object.defineProperty(t,e,{value:i,enumerable:!0,configurable:!0,writable:!0}):t[e]=i,t}e.a={name:"BubbleWidget",components:{"i-frame":s.a,TawkIcon:n.TawkIcon},directives:{TawkTooltip:n.TawkTooltip},mixins:[a.a],data:function(){return{isHidden:"hidden",cssLink:"".concat("https://embed.tawk.to/_s/v4/app/62835fee0eb","/css/bubble-widget.css"),closeIconWidth:16,messagePreviewIsVisible:!1}},computed:b(b({},Object(o.c)({minDesktop:"widget/minDesktop",chatWindowState:"session/chatWindowState",pageStatus:"session/pageStatus",bubble:"widget/bubble",isCenter:"widget/isCenter",isRight:"widget/isRight",isBottom:"widget/isBottom",chatBubbleClosed:"session/chatBubbleClosed",isRTL:"widget/isRTL"})),{},{isRoundWidget:function(){return t.Tawk_Window.widgetSettings.isRoundWidget()},xOffset:function(){return t.Tawk_Window.widgetSettings.xOffset()},yOffset:function(){return t.Tawk_Window.widgetSettings.yOffset()},bubbleXOffset:function(){return t.Tawk_Window.widgetSettings.bubbleXOffset()},bubbleYOffset:function(){return t.Tawk_Window.widgetSettings.bubbleYOffset()},bubbleRotate:function(){return t.Tawk_Window.widgetSettings.bubbleRotate()},closeButtonPosition:function(){return this.isBottom||this.isCenter?this.isCenter&&this.isRight?"tawk-icon-left":"tawk-icon-right":"tawk-icon-bottom"},textCloseButton:function(){var t={width:"25px",height:"25px",padding:0,background:"transparent",position:"absolute"};return this.isRTL?t.left="2px":t.right="2px",this.isBottom||this.isCenter?t.top="0":t.bottom="0",t},styleObject:function(){var t=b({"position:":"fixed !important;","display:":"none !important;","z-index:":"".concat(0===this.bubble.config.zIndex?"1000000":"1000002"," !important;"),"height:":"".concat(this.height," !important;"),"max-height:":"".concat(this.height," !important;"),"min-height:":"".concat(this.height," !important;"),"width:":"".concat(this.width," !important;"),"max-width:":"".concat(this.width," !important;"),"min-width:":"".concat(this.width," !important;")},this.calculatePosition());return"max"===this.chatWindowState||"offline"===this.pageStatus||this.chatBubbleClosed||this.messagePreviewIsVisible?t["display:"]="none !important;":t["display:"]="block !important;",b(b({},this.genericStyles),t)},width:function(){return"text"===this.bubble.type?"146px":"".concat(this.bubble.config.width,"px")},height:function(){return"text"===this.bubble.type?"85px":"".concat(this.bubble.config.height+this.closeIconWidth,"px")},imageUrl:function(){var t,e=this.bubble.config;if("gallery"===e.image.type){var i=parseInt(e.image.content,10),s=22===i;this.isRoundWidget&&(i+="-r"),this.isCenter?i+=this.isRight?"-cr":"-cl":this.isBottom?i+=this.isRight?"-br":"-bl":i+=this.isRight?"-tr":"-tl",t="".concat("https://embed.tawk.to/_s/v4/assets","/images/attention-grabbers/").concat(i).concat(s?".png":".svg")}else t="".concat("https://tawk.link","/").concat(e.image.content);return t},offsets:function(){var t=0,e=0,i=0;if(this.isCenter)if("text"===this.bubble.type)e=this.yOffset,this.isRight?(i=-90,this.isRTL&&(e=this.minDesktop.width+e-146),e-=10):(i=90,this.isRoundWidget||(e=this.minDesktop.width+e-146),e+=10),t=this.minDesktop.height+this.xOffset+2;else{var s="image"===this.bubble.type&&"gallery"===this.bubble.config.image.type;e=this.bubbleYOffset,t=this.bubbleXOffset,i=this.bubbleRotate,s&&(e+=this.yOffset,t+=this.xOffset),0!==this.bubbleRotate&&(s?t-=3:t+=2)}else"text"===this.bubble.type?(e=this.minDesktop.height+this.yOffset+2,t=this.xOffset):"image"===this.bubble.type&&"gallery"===this.bubble.config.image.type?(e=this.yOffset+this.bubbleYOffset,t=this.xOffset+this.bubbleXOffset,i=this.bubbleRotate):(e=this.bubbleYOffset,t=this.bubbleXOffset,i=this.bubbleRotate);return{xOffset:t,yOffset:e,rotate:i}}}),methods:b(b({},Object(o.b)({toggleWidget:"session/toggleWidget",closeChatBubble:"session/closeChatBubble"})),{},{calculatePosition:function(){var t,e,i="image"===this.bubble.type&&"gallery"===this.bubble.config.image.type,s=this.offsets,o="text"===this.bubble.type?85:this.bubble.config.height+this.closeIconWidth,n="text"===this.bubble.type?146:this.bubble.config.width,a={},r="0;",b="50% !important;";if(this.isCenter){var l,h=s.yOffset,c=-.5*o;r="49%;",0===s.rotate?(i?(l=0,b="calc(50% - ".concat(.5*this.bubble.config.height+13-h,"px) !important;"),t="0"):l=.5*(this.minDesktop.width-o),e="".concat(s.xOffset,"px !important;")):i?(l=0,h=0===this.yOffset?0:s.yOffset,e="".concat(-1*(.5*(n-o)-s.yOffset),"px !important;")):(l=.5*(this.minDesktop.width-n),e="".concat(-1*(.5*(n-o)-s.xOffset),"px !important;")),this.isRight?(a["right:"]=e,a["left:"]="auto !important;"):(a["right:"]="auto !important;",a["left:"]=e),a["top:"]=b,a["bottom:"]="auto !important;",t||(t=c-l+h)}else t="0",this.isBottom?(a["bottom:"]=s.yOffset+"px !important;",a["top:"]="auto !important;"):(a["bottom:"]="auto !important;",a["top:"]=s.yOffset+"px !important;"),this.isRight?(a["right:"]=s.xOffset+"px !important;",a["left:"]="auto !important;"):(a["right:"]="auto !important;",a["left:"]=s.xOffset+"px !important;");var u="rotate(".concat(s.rotate,"deg) translateZ(0);");return a["transform:"]=u,a["-moz-transform:"]=u,a["-webkit-transform:"]=u,a["-o-transform:"]=u,a["-ms-transform:"]=u,a["transform-origin:"]=r,a["-moz-transform-origin:"]=r,a["-webkit-transform-origin:"]=r,a["-o-transform-origin:"]=r,a["-ms-transform-origin:"]=r,a["margin:"]="".concat(t,"px 0 0 0 !important;"),a},bubbleClose:function(t){t.stopPropagation(),this.closeChatBubble()},updateMessagPreviewData:function(t){this.messagePreviewIsVisible=t},loaded:function(){if("text"===this.bubble.type){var e,i,s,o,n,a,r,b,l,h,c,u,f,g=this.$refs["tawk-canvas-bubble"];if(!g||!g.getContext)return;var p=5,d=134,m=63,w=this.bubble.config.background,k=g.getContext("2d"),y="#e3e0e7";k.clearRect(0,0,134,63),k.fillStyle=w,this.isCenter||this.isBottom?(e=p=6,i=p+m-3,s=55,o=79,n=!0,a={s1:.9,a1:.1,s2:.4,a2:1.15}):(e=68,i=(p=16)+3,s=81,o=6,n=!1,a={s1:1.1,a1:1.9,s2:1.6,a2:.85}),this.isRTL?(b=(r=10)+2,l=r+5,h=r-2,c=r-2,u=r+5,s=81,f=!n,this.isBottom||this.isCenter?(f=!n,a.s2=.6,a.a2=1.85):(f=n,a.s2=.2,a.a2=1.45)):(b=(r=2)+d-2,l=r+d-5,h=r+d+2,c=r+d+2,u=r+d-5,f=n),k.beginPath(),k.moveTo(r+8,p),k.lineTo(68,p),k.lineTo(r+d-8,p),k.quadraticCurveTo(r+d,p,r+d,p+8),k.lineTo(r+d,p+m-8),k.quadraticCurveTo(r+d,p+m,r+d-8,p+m),k.lineTo(r+8,p+m),k.quadraticCurveTo(r,p+m,r,p+m-8),k.lineTo(r,p+8),k.quadraticCurveTo(r,p,r+8,p),k.strokeStyle=y,k.lineWidth=2,k.stroke(),k.closePath(),k.fill(),k.beginPath(),k.arc(68,i,10,Math.PI*a.s1,Math.PI*a.a1,n),k.strokeStyle=y,k.lineWidth=2,k.stroke(),k.fill(),this.isRoundWidget&&(this.isBottom||this.isCenter||this.isRight?(this.isBottom&&this.isRight||this.isCenter&&this.isRight)&&(s+=30):s-=30),k.beginPath(),k.arc(s,o,5,0,2*Math.PI,!1),k.strokeStyle=y,k.lineWidth=2,k.stroke(),k.closePath(),k.fill(),k.beginPath(),k.arc(b,e+5,10,Math.PI*a.s2,Math.PI*a.a2,f),k.strokeStyle=y,k.lineWidth=2,k.stroke(),k.closePath(),k.fillStyle=w,k.fill(),k.beginPath(),k.moveTo(l,e+1.5),k.lineTo(h,e+8),k.closePath(),k.lineWidth=2,k.strokeStyle=this.bubble.config.foreground,k.stroke(),k.beginPath(),k.moveTo(c,e+1.5),k.lineTo(u,e+8),k.closePath(),k.lineWidth=2,k.strokeStyle=this.bubble.config.foreground,k.stroke()}t.Tawk_Window.eventBus.$on("mpIsVisible",this.updateMessagPreviewData)},beforeDestroy:function(){t.Tawk_Window.eventBus.$off("mpIsVisible",this.updateMessagPreviewData)}})}}).call(this,i("c8ba"))}}]);