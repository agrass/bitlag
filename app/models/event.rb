class Event < ActiveRecord::Base
acts_as_gmappable

def gmaps4rails_address
#describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
   "#{self.latitude}, #{self.longitude}"
end

def gmaps4rails_infowindow
         "<p><h2>#{name}</h2></p><p>#{address}</p>"
end

#agregar un evento desde el json de facebook
def self.add_from_facebook(fevent , api)
  if Event.find_by_fb_id(fevent["id"]) == nil
    if fevent!= nil       
      if fevent["venue"] != nil
          if fevent["venue"]["id"] != nil
         @venue= api.get_object("/"+fevent["venue"]["id"], "fields"=>"location")         
         Event.create(:name => fevent["name"], :latitude => @venue["location"]["latitude"], :longitude =>  @venue["location"]["longitude"], :fb_id => fevent["id"], :start_time => fevent["start_time"], :end_time => fevent["end_time"], :privacy => fevent["privacy"]  )    
          elsif fevent["venue"]["latitude"] != nil
         Event.create(:name => fevent["name"],  :latitude => fevent["venue"]["latitude"], :longitude =>  fevent["venue"]["longitude"], :fb_id => fevent["id"], :start_time => fevent["start_time"], :end_time => fevent["end_time"], :privacy => fevent["privacy"]  )
          end
      else
         Event.create(:name => fevent["name"], :address => fevent["location"], :fb_id => fevent["id"], :start_time => fevent["start_time"], :end_time => fevent["end_time"], :privacy => fevent["privacy"]  )
      end
     end
   end #end fb_id
end



end



