$ ->
  setPosition = (position)->
    $('#filter_in_distance_client_latitude').attr('value', position.coords.latitude)
    $('#filter_in_distance_client_longitude').attr('value', position.coords.longitude)

  if(navigator.geolocation)
    navigator.geolocation.getCurrentPosition(setPosition)

  # Actions
  $('#search').submit( (event) ->
    event.preventDefault()
    $.ajax({
      dataType: "json",
      url: '/events',
      data: $(this).serialize(),
      success: renderEvents
    })
  )

  #Rendering
  renderEvents = (result) ->
    toAppend = ''
    result.events.forEach( (event) ->
      games = ''
      event.games.map (game) -> games += "<span class='label label-primary'>#{game.name}</span>&#160;"

      toAppend +=
        "<br/><div class='panel panel-default'>
          <div class='panel-heading'>#{event.name}</div>
          <div class='panel-body'>
            <time class='start'>#{event.start_at} &ndash; </time>
            <time class='ends'>#{event.end_at}</time>
            <address>#{event.address}</address>
            <div class='panel-footer'>#{games}</div>
          </div>
        </div>"
      )

    fullAppend =
      "<div class='panel-group events'>
         #{toAppend}
       </div>"

    $('.events').html(fullAppend)


