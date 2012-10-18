class ApplicationController < ActionController::Base
before_filter :set_locale
 
  def set_locale
    begin
      if request.location.country == "Chile"
        I18n.locale = :enES
      end
    rescue Exception=>e
      # handle e
    end 
  end
  
end
