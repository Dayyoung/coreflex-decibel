$(function(){"undefined"!=typeof TiaraTracker&&TiaraTracker.getInstance().init({svcDomain:window.location.hostname,disableQuery:!0,enableHash:!1,deployment:"production"}),window.Tiara={setSection:function(e){"undefined"!=typeof TiaraTracker&&TiaraTracker.getInstance().setSection(e)},trackPage:function(e,t){"undefined"!=typeof TiaraTracker&&(e||("undefined"!=typeof window.Raven&&window.Raven.captureException(new Error("pageId is empty")),e="empty-page-id"),t="undefined"==typeof t?e:t,TiaraTracker.getInstance().setPage(e).trackPage(t).track())}}});