module Api
    class EventsController < Api::ApplicationController
      respond_to  :json
      
      def get_events
      category = params[:category]
      limit = params[:when]
      popularity = params[:popularity]
      radius = params[:radius]
      lat = params[:lat]
      lon = params[:lon]


      # @events = Event.near([lat, lon], radius).get_events_with_time(limit).joins(:tags).where('atenders >= ?',popularity,:tags => {:name => category}).uniq
      @events = Event.limit(5)
      respond_with(@events)

    end

    end
end
