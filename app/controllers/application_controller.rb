class ApplicationController < ActionController::Base
before_filter :set_locale
 
  def set_locale
    if request.location.country == "Chile"
      I18n.locale = :enES || I18n.default_locale  
    end  
  end
  
end
