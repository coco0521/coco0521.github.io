$(document).ready(function(){
  $(window).scroll(function() {
    resizeVideo();

  });
  $(window).resize(function() {
    resizeVideo();
  });


  var resizeVideo = function(){
  var picHeight = $('.videolist').height();
  var picWidth = $('.videolist').width();
  var iconTop = picHeight/2 - 20;
  var iconLeft = picWidth/2 - 20;
  $(".mask").css('height',picHeight);
  $(".mask").css('width',picWidth);
  $('.iconSize').css('top', iconTop+'px');
  $('.iconSize').css('left', iconLeft+'px');
  //Add the mask when play the video
  var mWidth = document.body.clientWidth || document.documentElement.clientWidth;
  var mHeight = document.body.clientHeight || document.documentElement.clientHeight;
  $('.overlay').css('width',mWidth+'px');
  $('.overlay').css('height',mHeight+'px');
  $('.playDiv').css('width',mWidth/2);
  var wPDiv = $('.playDiv').css('width');
  var vLeft = mWidth/2 - parseInt(wPDiv)/2;
  $('.playDiv').css('left',parseInt(vLeft)+'px');
  if(mWidth < 991){
    $('.playDiv').css('width',mWidth);
    $('.playDiv').css('left', 0);
  }
}

function getEle(obj){
      return document.getElementsByClassName(obj);      
}

  var oMask = getEle('mask');
  var iFrame = document.getElementsByTagName('iframe');
  var oPlay = getEle('playDiv')[0];
  var oLay = getEle('overlay')[0];
  var oClose = getEle('closebtn')[0];
  
  for(var i=0;i<oMask.length;i++){
    (function(i){
      oMask[i].onclick=function(){
        iFrame[0].setAttribute('src',frame_0);
        var iSrc = iFrame[i].attributes['src'].value;
        oPlay.style.display="block";
        oLay.style.display="block";
        oClose.style.display="block";
        iFrame[0].setAttribute('src',iSrc);
      };
    })(i);
  }
  var frame_0 = iFrame[0].getAttribute('src');
    oClose.onclick=function(){
    oPlay.style.display="none";
    oLay.style.display="none";
    oClose.style.display="none";
    iFrame[0].setAttribute('src','');
  }
});
