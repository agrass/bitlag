class EventsController < ApplicationController
  # GET /events
  # GET /events.json

  def refreshlist
    @limit = 10
    @active_filters = params[:filter]
    @offset = params[:offset]

    #Uso de busquedas
    if params[:search] != (0).to_s
      if session[:city] != ""
        @events = Event.near(session[:city] + ", " + session[:country]  , 100, :order => 'DATE(start_time) ASC, atenders DESC').where("lower(name) LIKE lower(?) AND start_time < ? AND start_time > ?", '%'+ params[:search] + '%', Time.now + 10.days, Time.now - 1.days).limit(10).offset(@offset)
        render :file => 'events/refreshList', :layout => false
      end
      return
    end

    #si logra encontrar la ciudad
    if session[:city] != ""
      if @active_filters == (0).to_s
        @events = Event.near(session[:city] + ", " + session[:country]  , 100, :order => 'DATE(start_time) ASC, atenders DESC').where('start_time < ? AND start_time > ?' , Time.now + 10.days, Time.now - 1.days ).limit(10).offset(@offset)
      else
        @events = Event.near(session[:city] + ", " + session[:country]  , 100, :order => 'DATE(start_time) ASC, atenders DESC').joins(:tags).where('tags.id = ? AND start_time < ? AND start_time > ?' ,@active_filters, Time.now + 10.days, Time.now - 1.days ).limit(10).offset(@offset)
      end
    else
      if @active_filters == (0).to_s
        @events = Event.where('start_time < ? AND start_time > ?' , Time.now + 10.days, Time.now - 1.days ).limit(10).offset(@offset).order('DATE(start_time) ASC, atenders DESC')
      else
        @events = Event.joins(:tags).where('tags.id = ? AND start_time < ? AND start_time > ?' ,@active_filters, Time.now + 10.days, Time.now - 1.days ).limit(10).offset(@offset).order('DATE(start_time) ASC, atenders DESC')
      end
    end    
    render :file => 'events/refreshList', :layout => false    
  end

  def lists

    if request.location
      session[:city] = request.location.city
      session[:country] = request.location.country
    end

    #si encuentra la ciudad
    if session[:city] != ""      
      @events = Event.near(session[:city] + ", " + session[:country]  , 100, :order => 'DATE(start_time) ASC, atenders DESC').where("start_time < ? AND start_time > ? ", Time.now + 10.days, Time.now - 10.hours).limit(10)
    else
      @events =Event.where("start_time < ? AND start_time > ? ", Time.now + 10.days, Time.now - 10.hours).order('DATE(start_time) ASC, atenders DESC').limit(10)
    end
     
  end


  def filter

    filter_events()

    respond_to do |format|
      format.json { render json: @data }
    end

  end

  def filter_events
    if params[:time]
  	@time = params[:time]
    else
  	@time = 'today'
    end
    if params[:radius] && params[:radius] != (0).to_s
        @radius = params[:radius]
    else
    	@radius = 5
    end
    if params[:lat] && params[:lon]
        @lat = params[:lat]
        @lon = params[:lon]
    else
      if request.location == nil
      	@lat = 0
        @lon = 0
      else
        @lat = request.location.latitude
        @lon = request.location.longitude
      end
    end
    
    if params[:atenders]
      atenders = Integer(params[:atenders])
    else
      atenders = 0
    end

    	@circles_json = '[{"lng": ' + @lon.to_s + ', "lat": ' + @lat.to_s + ', "radius": ' + (1.609344*5*1000).to_s + ' }]'

  #Si hay parámetros de tags, se hace una query con ellos
    if params[:data]
      @array = params[:data].split(',')
      if @lat == 0 && @lon == 0
      	@events = Event.get_events_with_time(@time).joins(:tags).where(:tags => {:id => @array }).where("atenders > ?",atenders).uniq
      else
      	@events = Event.near([@lat,@lon]  , @radius).get_events_with_time(@time).joins(:tags).where(:tags => {:id => @array }).where("atenders > ?",atenders).uniq
      end
      @data = @events.to_gmaps4rails
    #Si no, solo se usan filtros de tiempo
    else
      if @lat == 0 && @lon == 0
      	@events = Event.get_events_with_time(@time).where("atenders > ?",atenders)
      else
      	@events = Event.near([@lat,@lon] , @radius).get_events_with_time(@time).where("atenders > ?",atenders)
      end
      @data = @events.to_gmaps4rails
    end
  end


  #add Tags
  
  def addTags
    tag = Tag.find(params[:tag_id].to_i)
    event = Event.find_by_fb_id(params[:event_id].to_i)
    if tag && event
      event.tags.push(tag)
    end

    render :layout => false 
  end

  def personal_info
    session[:oauth] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, SITE_URL + '/callback')
    @auth_url =  session[:oauth].url_for_oauth_code(:permissions=>"email, user_events, friends_events, rsvp_event")
    if session[:user_id]
      @user = User.find_by_fb_id(session[:user_id])
      events = @user.events.where('end_time > ?',Time.now)
      @json = events.to_gmaps4rails
    else
      @json = '[]'
    end
  end

  def index
    if params[:term] && session[:city]
      @events = Event.near(session[:city] + ", " + session[:country]  , 100, :select => 'name').search_by_name(params[:term])
    else
      @events = Event.find :all, :order => 'atenders DESC', :conditions => ['start_time > ?',  Time.now]
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end


  def maps
  
    filter_events()
    @json = @data
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end

  end


  def extraInfo
    begin
      @api = Koala::Facebook::API.new(session[:access_token]) 
      @female = @api.fql_query("SELECT uid FROM user WHERE uid IN (select uid from event_member where eid = #{params[:fb_id]}  AND  rsvp_status = 'attending') AND sex = 'female'").length
      @male = @api.fql_query("SELECT uid FROM user WHERE uid IN (select uid from event_member where eid = #{params[:fb_id]}  AND  rsvp_status = 'attending') AND sex = 'male'").length
    rescue
      @female = ""
      @male = ""
    end
    render :layout => false
  end
  # GET /events/1
  # GET /events/1.json
  def show
    session[:oauth] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, SITE_URL + '/callback?event_id='+params[:id])
    @auth_url =  session[:oauth].url_for_oauth_code(:permissions=>"email, user_events, friends_events, rsvp_event")  
    puts session.to_s + "<<< session"
    

    if session[:user_id]
      @user = User.find_by_fb_id(session[:user_id])
    else
      @user = nil
    end

    @event = Event.find(params[:id])
    @json = @event.to_gmaps4rails
    #ver amigos facebook
    if session[:access_token]
    @api = Koala::Facebook::API.new(session[:access_token]) 
    @friends= @api.fql_query("SELECT name, pic_square FROM user WHERE uid IN (
SELECT uid2 FROM friend WHERE uid2 in (select uid from event_member where eid = #{@event.fb_id} AND  rsvp_status = 'attending') AND uid1 = me() )") 
 
    @list_friends = ""
    @friends.each do |friend|
      @list_friends += "<p>"+friend["name"]+"</p>"
      end
  end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  def add_to_list
    user = User.find_by_fb_id(session[:user_id])
    if user 
      user.events.push(Event.find(params[:event_id]))
    end
  end

  def remove_from_list
    user = User.find_by_fb_id(session[:user_id])
    if user
      user.events.delete(Event.find(params[:event_id]))
    end
  end

  def admin_events


  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  # POST /events.xml
  def create
    @event = Event.new(params[:event])    

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
         format.xml do
         render :xml => "<result>sucess</result>", :status => :created 
      end

        
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }

      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])
    @event.tags.clear()
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end
