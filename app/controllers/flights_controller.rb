class FlightsController < ApplicationController
  def index
    @airports = Airport.all.order(:code) # for dropdowns

    if params[:search]
      departure_id = params[:departure_airport_id]
      arrival_id = params[:arrival_airport_id]
      date = Date.parse(params[:start_date]) rescue nil

      @flights = if departure_id.present? && arrival_id.present? && date
        Flight.where(
          departure_airport_id: departure_id,
          arrival_airport_id: arrival_id,
          start_datetime: date.beginning_of_day..date.end_of_day
        ).includes(:departure_airport, :arrival_airport)
      else
        []
      end
    else
      @flights = []
    end
  end
end
