class HomeController < ApplicationController
  protect_from_forgery
  
   def index   
    session[:oauth] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, SITE_URL + '/home/callback')
    @auth_url =  session[:oauth].url_for_oauth_code(:permissions=>"read_stream")  
    puts session.to_s + "<<< session"

    respond_to do |format|
       format.html {  }
     end
  end

  def callback
    if params[:code]
      # acknowledge code and get access token from FB
      session[:access_token] = session[:oauth].get_access_token(params[:code])
    end   

     # auth established, now do a graph call:
      
    @api = Koala::Facebook::API.new(session[:access_token])
    
    if session[:friend_count] == nil      
      session[:friend_count] = 0
    end
   
      @eventos= @api.get_object("/me/events", "fields"=>"name, id, owner, description, start_time, end_time, location, venue, privacy, picture")      
      @amigos= @api.get_object("/me/friends", "fields"=>"id")   
        
        
      #obtener los 10 proximos amigos
      temp_max = [session[:friend_count] + 10, @amigos.length].min
      @temp_friend = @amigos[session[:friend_count]..temp_max]      
      
      
      session[:friend_count] = session[:friend_count] + 10
    
    
      @temp_friend.each do |friend|      
      friendq = "/" +friend["id"] + "/events"      
      @friend_event = @api.get_object(friendq, "fields"=>"name, id, owner, description, start_time, end_time, location, venue, privacy, picture")           
           
    @friend_event.each do |fevent|
     
    Event.add_from_facebook(fevent, @api)
     
     end #end fevent do    
    end #end friend do

  
    respond_to do |format|
     format.html {   }       
    end
    
  
  end
end
