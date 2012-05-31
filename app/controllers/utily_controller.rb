class UtilyController < ApplicationController

 require 'koala'  
 
before_filter :parse_facebook_cookies
def parse_facebook_cookies
 @facebook_cookies = Koala::Facebook::OAuth.new.get_user_info_from_cookie(cookies)
end
    
  def fbtest
    @facebook_cookies = Koala::Facebook::OAuth.new.get_user_info_from_cookie(cookies)
    
    
    @graph = Koala::Facebook::GraphAPI.new
    @example = @graph.get_object("koppel")
   
  end
end

def redirect
  session[:access_token] = Koala::Facebook::OAuth.new(oauth_redirect_url).get_access_token(params[:code]) if params[:code]

  redirect_to session[:access_token] ? success_path : failure_path
end
