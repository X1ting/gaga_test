class EventsController < ApplicationController
  def index
    @events = Event.includes(:games).filter(filter_params)
    @games = Game.all
    # @filters = Filter.includes(:games)
    respond_to do |format|
      format.html
      format.json
    end
  end

  def search
    @events = Event.filter(filter_params)
  end

  private

  def filter_params
    params.permit(:day_of_start, :between_time, :with_games)
  end
end