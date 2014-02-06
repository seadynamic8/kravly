# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

onEndless = ->
  $(window).off 'scroll', onEndless
  url = $('.pagination .next_page a').attr('href')
  $('.pagination').hide()
  if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
    $('#ideas').show()
    $.getScript url, ->
      $(window).on 'scroll', onEndless
  else
    $(window).on 'scroll', onEndless

$(window).on 'scroll', onEndless
  
$(window).scroll()

# jQuery ->
# 	if $('.pagination').length
# 		$(window).scroll ->
# 			url = $('.pagination .next_page a').attr('href')
# 			if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
# 				$('.pagination').text("Fetching more ideas...")
# 				$.getScript(url)
# 		$(window).scroll()