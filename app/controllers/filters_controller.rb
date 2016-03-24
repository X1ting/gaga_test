class FiltersController < ApplicationController

  def index
    @filters = Filter.all
  end

  def create
    filter = Filter.new(filter_params)
    json_message = filter.save ? {filters: Filter.all} : {errors: filter.errors}
    render json: json_message
  end

  def destroy
    Filter.find(params[:id]).destroy
    render json: {filters: Filter.all}
  end

  private

  def filter_params
    params.permit(:start_time, :end_time, :distance, :day_of_start, game_ids: [])
  end
end