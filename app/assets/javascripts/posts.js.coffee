$(document).on "page:change", ->
	$('#answer_link').click (event) ->
		event.preventDefault()
		$('#new_comment').fadeToggle(1000)
		$('#comment_answer').focus()

