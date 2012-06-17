class HomeController < ApplicationController
  protect_from_forgery
  
  
   def index  
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
