class AdminController < ApplicationController
  
  def index
    
    
  end
  
  
  def refresh_count  
    
       render :layout => 'clean', :template => 'admin/add_events'
  end
  
  
  #con FQL queries
  def add_events    
    #guardar un index de cual usuario se esta revisando y un offset de en que parte de sus eventos se esta agregando
     if session[:user_index] == nil
       session[:user_index] = 0
     elsif session[:user_index] < User.count      
       if session[:next]
       session[:user_index] = session[:user_index] + 1
       session[:next] = false
       session[:offset] = 0
       end
     end
     
    if  session[:offset] == nil
      session[:offset] = 0
    end 
    
     
    @user = User.find(:all)[1]
      
    @api = Koala::Facebook::API.new(@user.access_token)
    
    @events = @api.fql_query("SELECT eid from event_member WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = me()) AND rsvp_status = 'attending' AND start_time >"+ Time.now.to_i.to_s)
    #@events = @api.fql_query("SELECT eid from event_member WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = me()) AND rsvp_status = 'attending' AND start_time >"+ Time.now.to_i.to_s+" LIMIT 5 OFFSET "+ session[:offset].to_s)
    session[:offset] = session[:offset] + 5    
    if @events.length < 2      
      session[:next] = true
    end
    
    @agregados = 0;
   
   @qry = ""
    @events.each do |evento| 
   
      @fevent = @api.fql_query(" SELECT eid, name, description, venue, location, start_time, end_time, privacy from event where eid = " + evento["eid"].to_s)      
      @error = Event.add_from_facebook(@fevent[0], @api)
      if @error
       @error.full_messages.each do |msg|
        @qry += '<li>'+ msg + '</li>'       
      end
      else
        @qry += @agregados.to_s
      end      
     
      @agregados = @agregados + 1       
    end
    
    
  end
  
  
  
  
  
  def add_events2
   
    if session[:event_count] == nil
      session[:event_count] = 0;
    end
    
  
    
    @user = User.find(:all)[params[:id].to_i]
      
    @api = Koala::Facebook::API.new(@user.access_token)

    Koala::Facebook::API.new
    
      #agregar mis eventos
      @eventos= @api.get_object("/me/events", "fields"=>"name, id, owner, description, start_time, end_time, location, venue, privacy, picture")      
      @eventos.each do |mevent|
      Event.add_from_facebook(mevent, @api)
      end
         
      @amigos= @api.get_object("/me/friends", "fields"=>"id")
      @amigos.each do |friend|      
      friendq = "/" +friend["id"] + "/events"      
      @friend_event = @api.get_object(friendq, "fields"=>"name, id, owner, description, start_time, end_time, location, venue, privacy, picture")           
           
    @friend_event.each do |fevent|
     
    Event.add_from_facebook(fevent, @api)
    session[:event_count] = session[:event_count] + 1
    
     
     end #end fevent do    
    end #end friend do  
     
    
   
   
   render :layout => 'clean'
   
  end
end
