// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require_self
//= require jquery
//= require jquery_ujs
// require jquery.sortable
// require jquery-ui/sortable
// require jquery.powertip.min
// require medium-editor
// require jquery-fileupload
// require jquery-fileupload/basic-plus
// require jquery-fileupload/angularjs
// require jquery-fileupload/jquery-ui
// require handlebars.runtime
// require jquery/dist/jquery.min.js
//= require medium-editor/dist/js/medium-editor
//= require handlebars/handlebars.runtime.min.js
//= require jquery-sortable/source/js/jquery-sortable-min.js
//= require blueimp-file-upload/js/vendor/jquery.ui.widget.js
//= require blueimp-file-upload/js/jquery.iframe-transport.js
//= require blueimp-file-upload/js/jquery.fileupload.js
//= require medium-editor-insert-plugin/dist/js/medium-editor-insert-plugin.js
//= reqire bootstrap-filestyle.min.js
//= require jquery.remotipart
// require websocket_rails/main
// require turbolinks
//= require bootstrap-sprockets
//= require_tree .

  //iphone
$('.link_bright .btn').on('click touchend', function(e) {
    var el = $(this);
    var link = el.attr('href');
    window.location = link;
});
$(function(){
$(":file").filestyle({input: false, size: "sm",buttonText: "Change"});
});
