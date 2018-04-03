$(function(){
  if (gon.cate_select == 1) {$('#cate_1').addClass('link_bright_bright');}
  else if (gon.cate_select == 2) {$('#cate_2').addClass('link_bright_bright');}
  else if (gon.cate_select == 3) {$('#cate_3').addClass('link_bright_bright');}
  else if (gon.cate_select == 4) {$('#cate_4').addClass('link_bright_bright');}
  else if (gon.cate_select == 5) {$('#cate_5').addClass('link_bright_bright');}
  else if (gon.cate_select == 6) {$('#cate_6').addClass('link_bright_bright');}
  else if (gon.cate_select == 7) {$('#cate_7').addClass('link_bright_bright');}
  else if (gon.cate_select == 8) {$('#cate_8').addClass('link_bright_bright');}
  else if (gon.cate_select == 9) {$('#cate_9').addClass('link_bright_bright');}
  else if (gon.cate_select == 0) {$('#cate_0').addClass('link_bright_bright');}
  else if (gon.cate_select == 11) {$('#cate_11').addClass('link_bright_bright');}

});

// popover
$(document).ready(function(){
	$('[data-toggle="popover"]').popover();
  renderMathInElement(document.body);
});
