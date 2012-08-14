module Api
    class EventsController < Api::ApplicationController
      
      def get_events
      filter = params[:filter]
      limit = params[:limit]

      case filter
      when "all"

      when "party"

      when "music"

      when "cultural"

      when "other"

      end

      case limit
      when "today"

      when "week"

      when "weekend"

      end


    end

    end
end
