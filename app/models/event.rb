class Event < ActiveRecord::Base
acts_as_gmappable

def gmaps4rails_address
#describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
   "#{self.latitude}, #{self.longitude}"
end

def gmaps4rails_infowindow
         "<p><strong>#{name}</strong></p><p>#{address}</p><p>#{start_time}</P"
end

#agregar un evento desde el json de facebook
def self.add_from_facebook(fevent , api)
  if Event.find_by_fb_id(fevent["eid"]) == nil
    #ver la cantidad de asistentes
    @attending= api.get_object("/"+fevent["eid"].to_s + "/attending", "fields"=>"id")
    @attending = @attending.length
    
    
    if fevent!= nil  
      if fevent["venue"].count > 0
          if fevent["venue"]["id"] != nil
         @venue= api.get_object("/"+fevent["venue"]["id"].to_s, "fields"=>"location")         
         Event.create(:name => fevent["name"], :description => fevent["description"], :latitude => @venue["location"]["latitude"], :longitude =>  @venue["location"]["longitude"], :fb_id => fevent["eid"], :start_time => fevent["start_time"], :end_time => fevent["end_time"], :privacy => fevent["privacy"], :atenders => @attending, :gmaps => false )    
          elsif fevent["venue"]["latitude"] != nil
         Event.create(:name => fevent["name"], :description => fevent["description"],  :latitude => fevent["venue"]["latitude"], :longitude =>  fevent["venue"]["longitude"], :fb_id => fevent["eid"], :start_time => fevent["start_time"], :end_time => fevent["end_time"], :privacy => fevent["privacy"], :atenders => @attending, :gmaps => false)
          end
      else
         Event.create(:name => fevent["name"], :description => fevent["description"], :location => fevent["location"], :fb_id => fevent["eid"], :start_time => fevent["start_time"], :end_time => fevent["end_time"], :privacy => fevent["privacy"] , :atenders => @attending, :gmaps => true  )
      end
     end     
     
   end #end fb_id
end



end



