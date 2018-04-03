  $(document).ready(function() {
    $("#c_i_2").on('keyup touchend', function() {
        var words;
        words = this.value.match(/\S+/g).length;
        if (words > 20) {
            // Split the string on first 200 words and rejoin on spaces
            var trimmed = $(this).val().split(/\s+/, 20).join(" ");
            // Add a space at the end to keep new typing making new words
            $(this).val(trimmed + " ");
            $('#display_count').css({'color': '#ff431e'});
        }
        else if (words > 15) {
          $('#display_count').css({'color': 'rgb(255, 180, 0)'});
          $('#display_count').text(words);
        }
        else {
            $('#display_count').text(words);
        }
    });
 });

        $(function(){
        $('#user_mo').powerTip({
        mouseOnToPopup: 'true',
        placement: 'sw' });
        $('#user_mo').data('powertip', '<p><%= @user_p.user_name %> has opened </p><p><b><%= pluralize(@user_p_mo, "material") %></b> last 30 days.</p>');
        });

getSelectedTextWithin(document);
$(document).ready(function (){

  var selected_or_not;
  selected_or_not = 0;
  var c_x_1_x_2;
  c_x_1_x_2 = "";
  var ccc_1;
  var ccc_2;
  var sel_i;
  var match;


  ccc_1 = /c_str_[0-9]*/;
  ccc_2 = /c_str_[0-9]*(?![\s\S]*c_str_)/;

  //selection comment popup
     $('#story').on("mouseup touchend", (function (e){
        var selected;
        selected = getSelectedTextWithin(document);
        if (selected != "" && selected_or_not == 0) {
          // $('#c_i').val(selected);
          if (window.innerWidth - e.pageX < 176) {
            $('#popup_m').css({top: e.pageY - 178, right: 10 }).show();
            }else if(e.pageX < 176){
              $('#popup_m').css({top: e.pageY - 178, left: 10 }).show();
            }else{
              $('#popup_m').css({top: e.pageY - 178, left: e.pageX - 192 }).show();
            };
            //
          sel_i = rangy.getSelection().toHtml();
          c_x_1_x_2 = ccc_1.exec(sel_i) + ",";
          match = ccc_1.exec(sel_i);
          while (match != null) {
              c_x_1_x_2 = c_x_1_x_2 + ccc_1.exec(sel_i) + ",";
              sel_i = sel_i.replace(ccc_1,"");
              match = ccc_1.exec(sel_i);
          }
          c_x_1_x_2 = c_x_1_x_2 + "1";
          //
          $("#c_x_1_x_2").val(c_x_1_x_2);
          selected_or_not = 1;
        }else{
          $('#popup_m').hide();
          selected_or_not = 0;
        };
      })
     );
     $('#story').on("mousedown touchstart",function(){
      $('#popup_m').hide();
      selected_or_not = 0;
     });

    $('#extra').on("mouseup touchend", (function (e){
        var selected;
        selected = getSelectedTextWithin(document);
        if (selected != "" && selected_or_not == 0) {
          // $('#c_i').val(selected);
          if (window.innerWidth - e.pageX < 176) {
            $('#popup_m').css({top: e.pageY - 178, right: 10 }).show();
        }else if(e.pageX < 176){
          $('#popup_m').css({top: e.pageY - 178, left: 10 }).show();
        }else{
          $('#popup_m').css({top: e.pageY - 178, left: e.pageX - 192 }).show();
        };
        //
          sel_i = rangy.getSelection().toHtml();
          c_x_1_x_2 = ccc_1.exec(sel_i) + ",";
          match = ccc_1.exec(sel_i);
          while (match != null) {
              c_x_1_x_2 = c_x_1_x_2 + ccc_1.exec(sel_i) + ",";
              sel_i = sel_i.replace(ccc_1,"");
              match = ccc_1.exec(sel_i);
          }
          c_x_1_x_2 = c_x_1_x_2 + "2";
          //

          $("#c_x_1_x_2").val(c_x_1_x_2);

          selected_or_not = 1;
        }else{
          $('#popup_m').hide();
          selected_or_not = 0;
        };
      })
     );

    $('#extra').on("mousedown touchstart",function(){
      $('#popup_m').hide();
      selected_or_not = 0;
     });

  });

  function getSelectedTextWithin(el) {
    var selectedText;
    selectedText = "";
    if (typeof window.getSelection != "undefined") {
        var sel = window.getSelection(), rangeCount;
        if ( (rangeCount = sel.rangeCount) > 0 ) {
            var range = document.createRange();
            for (var i = 0, selRange; i < rangeCount; ++i) {
                range.selectNodeContents(el);
                selRange = sel.getRangeAt(i);
                if (selRange.compareBoundaryPoints(range.START_TO_END, range) == 1 && selRange.compareBoundaryPoints(range.END_TO_START, range) == -1) {
                    if (selRange.compareBoundaryPoints(range.START_TO_START, range) == 1) {
                        range.setStart(selRange.startContainer, selRange.startOffset);
                    }
                    if (selRange.compareBoundaryPoints(range.END_TO_END, range) == -1) {
                        range.setEnd(selRange.endContainer, selRange.endOffset);
                    }
                    selectedText += range.toString();
                }
            }
        }
    } else if (typeof document.selection != "undefined" && document.selection.type == "Text") {
        var selTextRange;
        selTextRange = document.selection.createRange();
        var textRange;
        textRange = selTextRange.duplicate();
        textRange.moveToElementText(el);
        if (selTextRange.compareEndPoints("EndToStart", textRange) == 1 && selTextRange.compareEndPoints("StartToEnd", textRange) == -1) {
            if (selTextRange.compareEndPoints("StartToStart", textRange) == 1) {
                textRange.setEndPoint("StartToStart", selTextRange);
            }
            if (selTextRange.compareEndPoints("EndToEnd", textRange) == -1) {
                textRange.setEndPoint("EndToEnd", selTextRange);
            }
            selectedText = textRange.text;
        }
    }
    return selectedText;
}





// pg.js
            $(function(){
                $('.c_pop_'+<%=conversation.id.to_s%>)
                .on( "mouseover touchend", function(){
                  var position = $('.c_pop_'+<%=conversation.id.to_s%>).position();
                  if (window.innerWidth - position.left < 176) {
                      $('#c_'+<%=conversation.id.to_s%>).css({top: position.top-126, left: window.innerWidth - 309});
                  }else if(position.left < 176){
                    $('#c_'+<%=conversation.id.to_s%>).css({top: position.top-126, left: 0 });
                  }else{
                    $('#c_'+<%=conversation.id.to_s%>).css({top: position.top-126, left: position.left - 144 });
                  };

                  $('#c_'+<%=conversation.id.to_s%>).css({visibility:"visible"}).animate({opacity: 1}, {queue: false});
                  // $('.c_pop_'+<%=conversation.id.to_s%>).css({'text-shadow': '1px 1px 0px rgb(255, 41, 41);'});
                })
                .on( "mouseleave", function(){
                  $('#c_'+<%=conversation.id.to_s%>).animate({opacity: 0}, {queue: false});
                  $('.c_pop_'+<%=conversation.id.to_s%>).css({'text-shadow': '1px 1px 0px rgb(255, 152, 140);'});
                });
            });





  //form




 function makeEditable(element){
  hljs.initHighlightingOnLoad();

  var editor = new MediumEditor(element,{
    "autolink": true,
  toolbar: {
    buttons: ['bold', 'italic','anchor','h2','h3', 'codeJS','tex','tex_inline']
  },
  buttonLabels: 'fontawesome', // use font-awesome icons for other buttons
  extensions: {
  'codeJS': new MediumButton({
    label: '<i class="fa fa-code" aria-hidden="true"></i>',
    start: '<br><pre><code>',
    end: '</code></pre><br>',
    action: function(html, mark){
              if(mark) return '<!--'+html+'-->' + hljs.highlight('javascript', html.substring(3, html.length - 4).replace(/(<\/p>|<p([^>]+)*>|&nbsp;|class="">)/g, "\n").replace(/</g, "<").replace(/>/g, ">")).value;
              return html.split('-->')[0].split('<!--').join('');
            }
    }),
  'tex': new MediumButton({
    label: '∫',
      start: '<br><div align="center">',
    end: '</div><br>',
    action: function(html, mark){   //HTML(String) is the selected Text
              if(mark) return '<!--'+html+'-->' + katex.renderToString(html);
              return html.split('-->')[0].split('<!--').join('');
           }
  }),
  //end ext
    'tex_inline': new MediumButton({
    label: '∫_',
      start: '&nbsp;<span align="center">',
    end: '</span>&nbsp;',
    action: function(html, mark){   //HTML(String) is the selected Text
              if(mark) return '<!--'+html+'-->' + katex.renderToString(html);
              return html.split('-->')[0].split('<!--').join('');
           }
  })
  //end ext
  }
  });

 $(element).mediumInsert({
  editor: editor,
  addons: {
    images: {
      fileUploadOptions: { // (object) File upload configuration. See https://github.com/blueimp/jQuery-File-Upload/wiki/Options
        url: '<%= upload_image_path%>', // (string) A relative path to an upload script
        acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i // (regexp) Regexp of accepted file types
      }
    }
  }
});
}

  $(function() {
    $("button").prop("type", "button");
    $(".btn-primary").prop("type", "submit");
    $(".btn-default").prop("type", "submit");

  // var editor = new MediumEditor('.editable');
  $('.editable').each(function(i,element){
    makeEditable(element);
  });


  $('.title_s .medium-insert-buttons-show').hide();
  $('#medium-editor-toolbar-1').hide();
  $('.medium-insert-buttons').hide();
  $('#title_edit.medium-editor-placeholder').show();
  if ($('p').html() == "<br>") {$(this).hide();}


$('.editable').bind('input propertychange focus active mouseleave', function() {
  $("#evangelist_" + $(this).attr("data-field-id")).val($(this).html());
  $('.title_hidden').val($('#title_edit').html());
  $('.body_hidden').val($('#body_edit').html());
  $('.extra_hidden').val($('#extra_edit').html());
  $('.title_s .medium-insert-buttons-show').hide();
  $('.title_s .medium-insert-buttons').hide();
  // replace_tag;
  return;
});

 });
