$ ->
  setPosition = (position)->
    console.log(position)
  $('#search').submit( (event) ->
    event.preventDefault()
    submit = $('#search > input[type="submit"]')
    buttontext = submit.attr('value')

    submit.prop('disabled', true).attr('value', 'Searching...').addClass('disabled')

    $.getJSON('events.json?' + $(this).serialize(), renderEvents)

    submit.removeClass('disabled').attr('value', buttontext).prop('disabled', false)
  )
  if(navigator.geolocation)
    navigator.geolocation.getCurrentPosition(setPosition)