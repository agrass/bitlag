class ApplicationController < ActionController::Base
before_filter :set_locale
 
  def set_locale
    begin
      if params[:locales]
        I18n.locale = params[:locales]
      else
      #otra forma de obtener el lenguaje
      end
    rescue Exception=>e
      # handle e
    end 
  end

  private
  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

  
end


