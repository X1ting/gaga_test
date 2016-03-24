class EventsController < ApplicationController
  def index
    @events = Event.includes(:games).filter(filter_params)
    respond_to do |format|
      format.html
      format.json
    end
  end

  private

  def filter_params
    params.require(:filter)
      .permit(
        between_time: [:start_at, :end_at],
        with_games: [game_ids: []],
        in_distance: [:distance, :client_longitude, :client_latitude],
        day_of_start: [:day]) if params[:filter]
  end
end