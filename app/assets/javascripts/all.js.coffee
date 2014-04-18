
jQuery ->
	# $(document).foundation();  Foundation Javascript has problems with Opera

	$('.img-container').hover ->
		$(this).find('.img-source').toggleClass('hidden')

	$flashAlert = $('.flash-alert')

	$flashAlert.find('.close').on 'click', ->
		$(this).parent('.flash-alert').remove()
	
	$flashAlert.slideDown 500, ->
		if $(this).hasClass('notice')
			$(this).delay(3000).slideUp(500)

	# GhostRec Usability Testing Code
	host = "http://www.eemt.se"
	scriptTag = "<script src='" + host + "/gt/js/4289.js' type='text/javascript'>"
	$('footer').after(scriptTag)