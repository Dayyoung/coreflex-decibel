var webUrl = ((window.location != window.parent.location)
  ? document.referrer
  : document.location.href).toLowerCase();

/**
 * Check if web url starting with given string
 * 
 * @param {string} str 
 * @returns {boolean}
 */
function urlStartWith(str) {
  return webUrl.indexOf(str.toLowerCase()) === 0
}

/**
 * Check if web url contains with given string
 *
 * @param {string} str
 * @returns {boolean}
 */
function urlContains(str) {
  return webUrl.indexOf(str.toLowerCase()) !== -1
}

/**
 * Creates a pixel image
 * @param {string} pixel Url to call
 */
function fire(pixel) {
  (new Image()).src = pixel
}

var visiteBlancUrl = "https://624451358527580020851073.tracker.adotmob.com/pixel/visiteBT?gdpr=${GDPR}&gdpr_consent=${GDPR_CONSENT_272}";
var samsungBlancUrl = "https://www.samsung.com/fr/washers-and-dryers/all-washers-and-dryers";

var visiteOvenUrl = "https://62c702374e7f3a002800ead4.tracker.adotmob.com/pixel/visiteBT?gdpr=${GDPR}&gdpr_consent=${GDPR_CONSENT_272}&d=5000&r=https%3A%2F%2F62c702374e7f3a002800ead4.tracker.adotmob.com%2Fpixel%2Fvisite5sBT%3Fgdpr%3D${GDPR}%26gdpr_consent%3D${GDPR_CONSENT_272}";
var samsungOvenUrl = "https://www.samsung.com/fr/cooking-appliances/fours-encastrables/";

var visitWatch5= "https://6346dfc22128a40027f3a30e.tracker.adotmob.com/pixel/visiteBT?gdpr=${GDPR}&gdpr_consent=${GDPR_CONSENT_272}&d=5000&r=https%3A%2F%2F6346dfc22128a40027f3a30e.tracker.adotmob.com%2Fpixel%2Fvisite5sBT%3Fgdpr%3D${GDPR}%26gdpr_consent%3D${GDPR_CONSENT_272}";
var samsungWatch5Url = "https://www.samsung.com/fr/watches/galaxy-watch5/";

var visiteBuds= "https://634d47e7063f8e0026e13319.tracker.adotmob.com/pixel/visiteBT?gdpr=${GDPR}&gdpr_consent=${GDPR_CONSENT_272}&d=5000&r=https%3A%2F%2F634d47e7063f8e0026e13319.tracker.adotmob.com%2Fpixel%2Fvisite5sBT%3Fgdpr%3D${GDPR}%26gdpr_consent%3D${GDPR_CONSENT_272}";
var samsungBudsurl= "https://www.samsung.com/fr/audio-sound/galaxy-buds/";

var visiteFlip4 = "https://63752768a0309800269c077f.tracker.adotmob.com/pixel/visiteBT?gdpr=${GDPR}&gdpr_consent=${GDPR_CONSENT_272}&d=5000&r=https%3A%2F%2F63752768a0309800269c077f.tracker.adotmob.com%2Fpixel%2FvisiteBT5s%3Fgdpr%3D${GDPR}%26gdpr_consent%3D${GDPR_CONSENT_272}";
var samsungflip4Url = "https://www.samsung.com/fr/smartphones/galaxy-z-flip4/";

if (urlStartWith(samsungBlancUrl) && urlContains('adot')) {
  fire(visiteBlancUrl);
}

if (urlStartWith(samsungOvenUrl) && urlContains('adot')) {
  fire(visiteOvenUrl);
}

if (urlStartWith(samsungWatch5Url) && urlContains('adot')) {
  fire(visitWatch5);
}

if (urlStartWith(samsungBudsurl) && urlContains('adot')) {
  fire(visiteBuds);
}

if (urlStartWith(samsungflip4Url) && urlContains('adot')) {
  fire(visiteFlip4);
}