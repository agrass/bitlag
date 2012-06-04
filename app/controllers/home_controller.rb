class HomeController < ApplicationController
  protect_from_forgery
  layout "clean"
  
   def index  
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
 
    @me= @api.get_object("/me")      
    
    User.create(:fb_id => @me["id"], :access_token => session[:access_token])
    
    session[:user_id] = @me["id"]      
  
    respond_to do |format|
     format.html {   }       
    end
    
    redirect_to root_path
  end
  
  
  def ajax_callback
    
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
        
        if session[:friend_total] == nil
        session[:friend_total] = @amigos.length
        end
      #obtener los 10 proximos amigos
      temp_max = [session[:friend_count] + 10, @amigos.length].min
      @temp_friend = @amigos[session[:friend_count]..temp_max]     
      
    
      @temp_friend.each do |friend|      
      friendq = "/" +friend["id"] + "/events"      
      @friend_event = @api.get_object(friendq, "fields"=>"name, id, owner, description, start_time, end_time, location, venue, privacy, picture")           
           
    @friend_event.each do |fevent|
     
    Event.add_from_facebook(fevent, @api)
     
     end #end fevent do    
    end #end friend do
    
     session[:friend_count] = session[:friend_count] + 10    
   
  
    respond_to do |format|
     format.html {   }       
    end
    
    
  end
  
  
  
end
