class EventsController < ApplicationController
  # GET /events
  # GET /events.json



  def refreshlist
    @limit = 10
    @active_filters = params[:filter]
    @offset = params[:offset]
    
    @events = Event.find(:all, :order => "atenders DESC" , :conditions => ["start_time < ?", Time.now + 10.days], :limit => 10, :offset => @offset )
    
      
    render :file => 'events/refreshList', :layout => false    
  end
  
  def lists
     @events = Event.find(:all, :order => "atenders DESC" , :conditions => ["start_time < ?", Time.now + 10.days], :limit => 10 )
     #@events = Event.find(:all, :limit => 10)
  end
    
    
  def filter
    if params[:time].nil?
    	respond_to do |format|      
    	format.json { render json: @data }
    	end
    	return
    end
    
    if params[:data]
       @array = params[:data].split(',')
       @events = Event.get_events_with_time(params[:time]).joins(:tags).where(:tags => {:id => @array }).group(:id)
       @data = @events.to_gmaps4rails
    else
       @events = Event.get_events_with_time(params[:time])
       @data = @events.to_gmaps4rails
    end
          
    respond_to do |format|      
    format.json { render json: @data }
    end       
    
  end
  
  
  def index
    session[:oauth] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, SITE_URL + '/callback')
    @auth_url =  session[:oauth].url_for_oauth_code(:permissions=>"email, user_events, friends_events")  
    puts session.to_s + "<<< session"
    
  @events = Event.find :all, :order => 'atenders DESC', :conditions => ['start_time > ?',  Time.now]
	@json = @events.to_gmaps4rails
	
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end
  
  
  def maps
    session[:oauth] = Koala::Facebook::OAuth.new(APP_ID, APP_SECRET, SITE_URL + '/callback')
    @auth_url =  session[:oauth].url_for_oauth_code(:permissions=>"email, user_events, friends_events")  
    puts session.to_s + "<<< session"
    
  @events = Event.find :all, :order => 'atenders DESC', :conditions => ['start_time > ?', Time.now]
  @json = @events.to_gmaps4rails
  
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
    
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
     @json = @event.to_gmaps4rails

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
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
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
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
