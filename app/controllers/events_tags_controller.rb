class EventsTagsController < ApplicationController
  # GET /events_tags
  # GET /events_tags.json
  def index
    @events_tags = EventsTag.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events_tags }
    end
  end

  # GET /events_tags/1
  # GET /events_tags/1.json
  def show
    @events_tag = EventsTag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @events_tag }
    end
  end

  # GET /events_tags/new
  # GET /events_tags/new.json
  def new
    @events_tag = EventsTag.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @events_tag }
    end
  end

  # GET /events_tags/1/edit
  def edit
    @events_tag = EventsTag.find(params[:id])
  end

  # POST /events_tags
  # POST /events_tags.json
  def create
    @events_tag = EventsTag.new(params[:events_tag])

    respond_to do |format|
      if @events_tag.save
        format.html { redirect_to @events_tag, notice: 'Events tag was successfully created.' }
        format.json { render json: @events_tag, status: :created, location: @events_tag }
      else
        format.html { render action: "new" }
        format.json { render json: @events_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events_tags/1
  # PUT /events_tags/1.json
  def update
    @events_tag = EventsTag.find(params[:id])

    respond_to do |format|
      if @events_tag.update_attributes(params[:events_tag])
        format.html { redirect_to @events_tag, notice: 'Events tag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @events_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events_tags/1
  # DELETE /events_tags/1.json
  def destroy
    @events_tag = EventsTag.find(params[:id])
    @events_tag.destroy

    respond_to do |format|
      format.html { redirect_to events_tags_url }
      format.json { head :no_content }
    end
  end
end
