class ApplicationController < ActionController::Base
before_filter :set_locale
 
  def set_locale
    begin
      if params[:locales]
        I18n.locale = params[:locales]
      else
        if request.location != nil
          if request.location.country == "Chile"
            I18n.locale = :enES
          end
        end
      end
    rescue Exception=>e
      # handle e
    end 
  end


  
end


