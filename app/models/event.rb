class Event < ActiveRecord::Base
acts_as_gmappable
#acts_as_mappable :default_units => :kms,
                   #:default_formula => :sphere,
                   #:distance_field_name => :distance,
                   #:lat_column_name => :latitude,
                   #:lng_column_name => :longitude

has_and_belongs_to_many :tags

#before_save :set_tag

validates :fb_id, :uniqueness => true

geocoded_by :address
reverse_geocoded_by :latitude, :longitude
after_validation :geocode, :reverse_geocode


def set_tag
   Tag.find(:all).each do |tag|
   	tag.expressions.each do |expression|
		if !(self.name =~ /#{expression.expression}/).nil? || !(self.description =~ /#{expression.expression}/).nil?
	    		self.tags.push(tag)
	    		break
		end
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
  return "<div class='modal-header'><h3 id='myModalLabel'><a href='events/#{self.id}' ><p><strong>#{name}</strong></p></a></h3></div><div class='modal-body'><div class='show_picture'> <img src='#{self.picture}' height='50' width='50' /></div><p>#{address}</p><p>#{Time.at(start_time).strftime(I18n.t('time.formats.short'))}</p></div><div class='modal-footer'><a class='btn btn-primary' href='events/#{self.id}'>Go</a><button class='btn' data-dismiss='modal' aria-hidden='true'>Close</button></div>"
end

def gmaps4rails_marker_picture
  if self.tags.first() != nil
  {
    
   "picture" => "/assets/#{self.tags.first().name}.png",
   "width" => 40,
   "height" => 53,
   
   }
   else
       {
    
   "picture" => "/assets/todos.png",
   "width" => 40,
   "height" => 53,
   
   }
   end
end

def self.get_events_with_time(time)
   if time == "today"
   	Event.where("(end_time >= ? AND end_time <= ?)  OR ( start_time >= ? AND start_time <= ?)", (Time.now - 5.hours), (Time.now + 12.hours), (Time.now - 1.hours), (Time.now + 10.hours) )
   elsif time == "week"
   	Event.where(:end_time => (Time.now - 5.hours)..(Time.now + 7.days))
   else
   	if Time.now > Time.now.end_of_week.ago(86400 * 3)
   		Event.where(:end_time => (Time.now)..(Time.now.end_of_week))
   	else
   		Event.where(:end_time => (Time.now.end_of_week.ago(86400 * 3))..(Time.now.end_of_week))
   	end
   end
end

def self.search_by_name(q)
  Event.where("lower(name) LIKE lower(?) AND start_time < ? AND start_time > ?", '%'+ q + '%', Time.now + 10.days, Time.now - 1.days).limit(10).select(:name).uniq
end

end




