class HomeController < ApplicationController
  protect_from_forgery
  
  
   def index  
       session[:oauth] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, SITE_URL + '/callback')
    @auth_url =  session[:oauth].url_for_oauth_code(:permissions=>"email, user_events, friends_events")  
    puts session.to_s + "<<< session"
     
    respond_to do |format|
       format.html {  }
     end
  end


  def fb_login  
       session[:oauth] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, SITE_URL + '/callback')
    @auth_url =  session[:oauth].url_for_oauth_code(:permissions=>"email, user_events, friends_events")  
    puts session.to_s + "<<< session"
     
    respond_to do |format|
       format.html {  }
     end
  end

  
  
  def ajax_callback
    
 
  
    respond_to do |format|
     format.html {   }       
    end
    
    
  end
  
  
  
end
