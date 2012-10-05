class UtilyController < ApplicationController

 require 'koala' 

    
  def fbtest   
    @token_app = session[:oauth].get_app_access_token    
    @api = Koala::Facebook::API.new(@token_app)    
    @amigos= @api.get_object("/727525843/friends", "fields"=>"id")    
    @amigos = @amigos[10..15]    
    @friend_event = []    
    @amigos.each do |friend|    
      @friendq = "/" +friend["id"]+ "/events"    
      @friend_event << @api.get_object(@friendq, "fields"=>"name, id, owner, description, start_time, end_time, location, venue, privacy, picture")    
    end 
  end  
  
  #respuesta al facebook
  def callback    
    if params[:code]
      # acknowledge code and get access token from FB
      session[:access_token] = session[:oauth].get_access_token(params[:code])
    end

    @api = Koala::Facebook::API.new(session[:access_token]) 
    @me= @api.get_object("/me")    
    @user = User.find_by_fb_id(@me["id"])
    if @user == nil
      User.create(:fb_id => @me["id"], :access_token => session[:access_token])
    else
      @user.update_attributes(:access_token => session[:access_token])      
    end
    
    session[:user_id] = @me["id"]   
  
    respond_to do |format|
     format.html {   }       
    end
    
    redirect_to root_path
  end



  def callback2
    
    if params[:code]
      # acknowledge code and get access token from FB
      session[:access_token] = session[:oauth].get_access_token(params[:code])
    end

    @api = Koala::Facebook::API.new(session[:access_token]) 
    @me= @api.get_object("/me")    
    @user = User.find_by_fb_id(@me["id"]) 
    if @user == nil
      User.create(:fb_id => @me["id"], :access_token => session[:access_token])
    else
      @user.update_attributes(:access_token => session[:access_token])
      
    end
    
    session[:user_id] = @me["id"]      
  
    respond_to do |format|
     format.html {   }       
    end
    
    redirect_to "home/fb_login"
  end
  
  
  def logout
    session[:user_id] = nil
    redirect_to root_path
  end  
  


def redirect
  session[:access_token] = Koala::Facebook::OAuth.new(oauth_redirect_url).get_access_token(params[:code]) if params[:code]

  redirect_to session[:access_token] ? success_path : failure_path
end

end
