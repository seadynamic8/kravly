# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# endlessScroll = ->
jQuery ->
	if $('.pagination').length # if pagination exists (ie if there is pagination on this page)
		onEndless = ->
			$(window).off 'scroll', onEndless
			url = $('.paginate .next_page a').attr('href')
			if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
				$('.pagination').text("Fetching more ideas...")
				$.getScript url, ->
					$(window).on 'scroll', onEndless
			else
				$(window).on 'scroll', onEndless

		$(window).on 'scroll', onEndless

		$(window).trigger 'scroll'

# $(document).on 'ready page:change', endlessScroll

# jQuery ->
# 	if $('.pagination').length # if pagination exists (ie if there is pagination on this page)
# 		$(window).scroll ->
# 			url = $('.pagination .next_page a').attr('href')
# 			if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
# 				$('.pagination').text("Fetching more ideas...")
# 				$.getScript(url)
# 		$(window).scroll()