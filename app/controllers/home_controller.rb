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
    begin
      @eventos= @api.get_object("/me/events", "fields"=>"name, id, owner, description, start_time, end_time, location, venue, privacy, picture")
    rescue Exception=>ex
      puts ex.message
    end
    
    
       begin
      @amigos= @api.get_object("/me/friends")
    rescue Exception=>ex
      puts ex.message
    end
    
    
    #funciona pero se queda muy pegado
      #@amigos.each do |friend|      
      #friendq = "/" +friend["id"] + "/events"      
      #@friend_event = @api.get_object(friendq, "fields"=>"name, id, owner, description, start_time, end_time, location, venue, privacy, picture")      
      #@friend_event.each do |fevent|        
     #Event.create(:name => fevent["name"], :address => fevent["location"]) 
    # end
          
      
    end
    
    
    
  
    respond_to do |format|
     format.html {   }       
    end
    
  
  end
end
