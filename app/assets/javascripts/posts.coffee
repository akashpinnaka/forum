$(document).on "page:change", ->
	$('#answer_link').click (event) ->
		event.preventDefault()
		$('#new_comment').fadeToggle()
		$('#comment_answer').focus()