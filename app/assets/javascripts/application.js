// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery.validate
//= require jquery.validate.additional-methods
//= require jquery.charactercounter
//= require jquery.uriAnchor
//= require jquery.infinitescroll.min
//= require foundation
//= require ckeditor/override
//= require ckeditor/init
//= require imagesloaded.pkgd.min
//= require masonry.pkgd.min
//= require_tree .
//= require turbolinks

$(document).ready(function() {
	// $(document).foundation();  Foundation Javascript has problems with Opera

	$('.img-container').hover(
		function() {
			$(this).find('.img-source').toggleClass('hidden');
		}
	);

	var $flashAlert = $('.flash-alert');

	$flashAlert.find('.close').on('click', function () {
		$(this).parent('.flash-alert').remove();
	});
	
	$flashAlert.slideDown(500, function () {
		if ( $(this).hasClass('notice') )
			$(this).delay(3000).slideUp(500);
	});
});

// $(document).on('page:change', function () {
// 	if ( window.clicky !== null && window.clicky !== "undefined" ) {
//     clicky.log( document.location.pathname + document.location.search, 
//     	document.title, 'pageview' );
// 	}
// });