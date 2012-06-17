class Event < ActiveRecord::Base
acts_as_gmappable
has_and_belongs_to_many :tags

before_save :set_tag

def set_tag
   Tag.find(:all).each do |tag|
      if !(self.name =~ /#{tag.expression}/).nil? || !(self.description =~ /#{tag.expression}/).nil?
	    self.tags.push(tag)
	  end
   end
end

def gmaps4rails_address
#describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
   if self.latitude   
   return "#{self.latitude}, #{self.longitude}"
   else
     return address
   end
end

def gmaps4rails_infowindow
         "<p><strong>#{name}</strong></p><p>#{address}</p><p>#{start_time}</P"
end

def gmaps4rails_marker_picture
  {
   "picture" => "/assets/#{self.tags.first().name}.png",
   "width" => 60,
   "height" => 80,
   }
end

#agregar un evento desde el json de facebook
def self.add_from_facebook(fevent , api)
  if Event.find_by_fb_id(fevent["eid"]) == nil
    #ver la cantidad de asistentes
    @attending= api.get_object("/"+fevent["eid"].to_s + "/attending", "fields"=>"id")
    @attending = @attending.length
    
    @temp = Event.new
    if fevent!= nil  
      if fevent["venue"].count > 0
          if fevent["venue"]["id"] != nil
         @venue= api.get_object("/"+fevent["venue"]["id"].to_s, "fields"=>"location")         
        @temp = Event.new(:name => fevent["name"], :description => fevent["description"], :address => fevent["location"],  :latitude => @venue["location"]["latitude"], :longitude =>  @venue["location"]["longitude"], :fb_id => fevent["eid"], :start_time => fevent["start_time"], :end_time => fevent["end_time"], :privacy => fevent["privacy"], :atenders => @attending )    
          elsif fevent["venue"]["latitude"] != nil
         @temp = Event.new(:name => fevent["name"], :description => fevent["description"], :address => fevent["location"],  :latitude => fevent["venue"]["latitude"], :longitude =>  fevent["venue"]["longitude"], :fb_id => fevent["eid"], :start_time => fevent["start_time"], :end_time => fevent["end_time"], :privacy => fevent["privacy"], :atenders => @attending)
          else
         @temp = Event.new(:name => fevent["name"], :description => fevent["description"], :address => fevent["location"], :fb_id => fevent["eid"], :start_time => fevent["start_time"], :end_time => fevent["end_time"], :privacy => fevent["privacy"] , :atenders => @attending, :gmaps => true)
      end         
      else
         @temp = Event.new(:name => fevent["name"], :description => fevent["description"], :address => fevent["location"], :fb_id => fevent["eid"], :start_time => fevent["start_time"], :end_time => fevent["end_time"], :privacy => fevent["privacy"] , :atenders => @attending, :gmaps => true)
      end
     end     
     
     if !@temp.save
       
      return @temp.errors
     end
   end #end fb_id
   
   return nil
end



end



