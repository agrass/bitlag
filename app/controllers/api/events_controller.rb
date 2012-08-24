module Api
    class EventsController < Api::ApplicationController
      respond_to  :json
      
      def get_events
      filter = params[:filter]
      limit = params[:limit]
      radius = params[:radius]
      lat = params[:lat]
      lon = params[:lon]

      @events = Event.near([lat, lon], radius).get_events_with_time(limit).joins(:tags).where(:tags => {:name => filter}).uniq
      respond_with(@events)

    end

    end
end
