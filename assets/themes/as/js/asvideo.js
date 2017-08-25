var resizeHeight = function(){
	var list1 = $('.listitle:eq(0)').height();
  var list2 = $('.listitle:eq(1)').height();
  var list3 = $('.listitle:eq(2)').height();
  var max = Math.max(list1,list2,list3);
  $('.listitle:eq(0)').css('height',max);
  $('.listitle:eq(1)').css('height',max);
  $('.listitle:eq(2)').css('height',max);
}

var resizeVideo = function(){
	var picHeight = $('.videolist').height();
  var picWidth = $('.videolist').width();
  var iconTop = picHeight/2 - 30;
  var iconLeft = picWidth/2 - 30;
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

var clickMask = function(){
	var oMask = document.getElementsByClassName('mask');
  var iFrame = document.getElementsByTagName('iframe');
  var oPlay = document.getElementsByClassName('playDiv')[0];
  var oLay = document.getElementsByClassName('overlay')[0];
  var oClose = document.getElementsByClassName('closebtn')[0];
  
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
}