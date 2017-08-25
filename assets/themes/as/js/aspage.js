

var reLayoutImage = function() {
  var backImgWidth = 800, backImgHeight = 343, rocketYCor = 0;
  var frontImageWidth = 1500, frontImageHeight = 288;
  var initDivHeight = 800, initCssHeight = 720, minCssHeight = 236, initYPos = 120;
  var winHeight = $(window).height();
  var fullHeight = winHeight - 58;
  var winWidth = $(window).width();
  var imgDiv = $('.indexmain');
  var dlBtn = $('.download');
  var currWidth = imgDiv.width();
  var zoomRatio = currWidth / frontImageWidth;
  var calHeight = zoomRatio * frontImageHeight;

  var dlBtnBottomYCor = dlBtn.offset().top - imgDiv.offset().top + dlBtn.outerHeight();
  var height, yCor;
  if(winHeight > winWidth) {
    var space = 10;
    height = calHeight + dlBtnBottomYCor + space;
    yCor = dlBtnBottomYCor + space;
  } else {
    height = Math.max(minCssHeight, fullHeight);
    yCor = Math.max(height - calHeight, dlBtnBottomYCor);
  }
  
  imgDiv.css("height", height + "px");
  imgDiv.css("background-position", "0 " + yCor + "px, 0 0");
}

var resizeLogo = function() {
  var winWidth = $(window).width();
  // resize logo image for small screens
  var minus = 44 + 15 + (15 +3) *2 + 1*2;
  var logoImgWidth = 287;
  if(winWidth - minus - logoImgWidth < 0) {
    $('.navbar-brand > img').attr('width', winWidth - minus);
  } else {
    $('.navbar-brand > img').attr('width', logoImgWidth);
  }
}