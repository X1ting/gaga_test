$ ->
  $(document).ready ->
    getFilters()

  #Constants
  restruct = {
    start_time: 'filter_between_time_start_at'
    end_time: 'filter_between_time_end_at'
    distance: 'filter_in_distance_distance'
    day_of_start: 'filter_day_of_start_day'
  }


  #Actions
  getFilters = ->
    $.ajax({
      dataType: "json",
      url: '/filters',
      data: '',
      success: renderFilters
    })


  applyToForm = ->
    data = $(this).data()
    Object.keys(restruct).map((key) => $("##{restruct[key]}").val(data[key]))



  #Rendering
  renderFilters = (result) ->
    toAppend = ''
    if result.filters
      result.filters.forEach( (filter) ->
        data = ''
        Object.keys(filter).map((key) => data += " data-#{key}='#{filter[key]}' ")
        filter_text = "On #{filter.day_of_start_readable} from #{filter.start_time}h. to #{filter.end_time}h. on distance: #{filter.distance}km"
        toAppend +=
          "<a href='#' #{data} class='filter list-group-item' id=#{filter.id}>
            #{filter_text}
            <span class='pull-right'>
              <button id=#{filter.id} class='close'><span>&times;<span></button>
            </span>
           </a>"
        )
      fullAppend =
        "<div class='panel-heading'>Filters setting</Filter>
          <div class='panel-body'>
            <div class='list-group'>
              #{toAppend}
            </div>
          </div>
          <div class='errors'></div>
          <button class='save-filter btn btn-primary'> <-- Save this </button>
         </div>"
      $('.filters').html(fullAppend)
    else
      $('.errors').html('this filter saved yet')

    $('.filter').click(applyToForm)
    $('.close').click(destroyFilter)
    $('.save-filter').click(saveFilter)

    # destroyFilter)


  destroyFilter = ->
    $.ajax({
      method: 'DELETE',
      url: "/filters/#{$(this).attr('id')}/",
      data: '',
      success: renderFilters
    })



  saveFilter = ->
    data = Object.keys(restruct).reduce (data, key) ->
      data[key] = $("##{restruct[key]}").val()
      data
    , {}

    $.ajax({
      method: 'POST',
      dataType: 'json',
      url: '/filters',
      data: data,
      success: renderFilters
    })

