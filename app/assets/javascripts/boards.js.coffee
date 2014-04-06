jQuery ->
	$boardsIdeas = $('.boards-ideas')

	$boardsIdeas.imagesLoaded ->
		$boardsIdeas.masonry
			columnWidth: '.block',
			itemSelector: '.block',
			isFitWidth: true

	$boardsIdeas.infinitescroll
		navSelector: '.boards-ideas-paginate',
		nextSelector: '.boards-ideas-paginate .next_page a',
		itemSelector: '.block',
		loading:
			speed: 'fast',
			selector: '.boards-ideas-paginate',
			img: 'https://s3.amazonaws.com/img.kravly.com/loading.gif'
	, ( newElements ) ->
		# hide new items while they are loading
		$newElems = $( newElements ).css({ opacity: 0 })
		# ensure that images load before adding to discover layout
		$newElems.imagesLoaded ->
			# show elems now they're ready
			$newElems.animate({ opacity: 1 })
			# Add new items using masonry
			$boardsIdeas.masonry( 'appended', $newElems, true )

		#Add image source hover for added items
		$newElems.find('.img-container').hover ->
			$(this).find('.img-source').toggleClass('hidden')

	addCharacterCounter = ($field, limit) ->
		$field.characterCounter
			limit: limit,
			counterFormat: '%1 characters left',
		#  counterExceededCssClass: 'error'
			onExceed: ->
				$field.addClass('error')
			, 
			onDeceed: ->
				$field.removeClass('error')

	$boardName = $('#board_name')
	$boardDescription = $('#board_description')

	addCharacterCounter( $boardName, 30 )
	addCharacterCounter( $boardDescription, 145 )