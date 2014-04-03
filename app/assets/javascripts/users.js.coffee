# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
	$usersBoards = $('.users-boards')
	$usersIdeas  = $('.users-ideas')
	$usersVotes  = $('.users-votes')

	masonryFunc = ( $container ) ->
		$container.masonry
			columnWidth: '.block',
			itemSelector: '.block',
			isFitWidth: true

	infiniteScrollOptions = (group) ->
		# return
		navSelector: '.' + group + '-paginate',
		nextSelector: '.' + group + '-paginate .next_page a',
		itemSelector: '.block',
		loading:
			speed: 'fast',
			selector: '.' + group + '-paginate',
			img: 'https://s3.amazonaws.com/img.kravly.com/loading.gif'

	callbackForScroll = ( newElements, $container ) ->
		# hide new items while they are loading
		$newElems = $( newElements ).css({ opacity: 0 })
		# ensure that images load before adding to users layout
		$newElems.imagesLoaded ->
			# show elems now they're ready
			$newElems.animate({ opacity: 1 })
			# Add new items using masonry
			$container.masonry( 'appended', $newElems, true )

		#Add image source hover for added items
		$newElems.find('.img-container').hover ->
			$(this).find('.img-source').toggleClass('hidden')

	# When images are loaded, load the masonry plugin
	$usersBoards.imagesLoaded -> masonryFunc( $usersBoards )
	$usersIdeas.imagesLoaded ->	masonryFunc( $usersIdeas )
	$usersVotes.imagesLoaded -> masonryFunc( $usersVotes )

	# call the infinitescroll plugin and then call masonry and image source callback
	$usersBoards.infinitescroll infiniteScrollOptions('users-boards'), ( newElements ) ->
		callbackForScroll newElements , $usersBoards
	$usersIdeas.infinitescroll infiniteScrollOptions('users-ideas'), ( newElements ) ->
		callbackForScroll newElements, $usersIdeas
	$usersVotes.infinitescroll infiniteScrollOptions('users-votes'), ( newElements ) ->
		callbackForScroll newElements, $usersVotes

      