# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
	$discoverIdeas = $('.discover-ideas')

	$discoverIdeas.imagesLoaded ->
		$discoverIdeas.masonry
			columnWidth: '.discover-block',
			itemSelector: '.discover-block',
			isFitWidth: true

	$discoverIdeas.infinitescroll
		navSelector: '.pagination',
		nextSelector: '.paginate .next_page a',
		itemSelector: '.discover-block',
		loading:
        img: 'https://s3.amazonaws.com/img.kravly.com/loading.gif',
        msgText: '<p>Fetching more ideas....</p>'
	, ( newElements ) ->
		  # hide new items while they are loading
      $newElems = $( newElements ).css({ opacity: 0 })
      # ensure that images load before adding to discover layout
      $newElems.imagesLoaded ->
        # show elems now they're ready
        $newElems.animate({ opacity: 1 })
        $discoverIdeas.masonry( 'appended', $newElems, true )

      $newElems.find('.img-container').hover ->
      	$(this).find('.img-source').toggleClass('hidden')


# endlessScroll = ->
# jQuery ->
# 	if $('.pagination').length # if pagination exists (ie if there is pagination on this page)
# 		onEndless = ->
# 			$(window).off 'scroll', onEndless
# 			url = $('.paginate .next_page a').attr('href')
# 			if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
# 				$('.pagination').text("Fetching more ideas...")
# 				$.getScript url ->
# 					$(window).on 'scroll', onEndless
# 			else
# 				$(window).on 'scroll', onEndless

# 		$(window).on 'scroll', onEndless

# 		$(window).trigger 'scroll'

# $(document).on 'ready page:change', endlessScroll

# jQuery ->
# 	if $('.pagination').length # if pagination exists (ie if there is pagination on this page)
# 		$(window).scroll ->
# 			url = $('.pagination .next_page a').attr('href')
# 			if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
# 				$('.pagination').text("Fetching more ideas...")
# 				$.getScript(url)
# 		$(window).scroll()