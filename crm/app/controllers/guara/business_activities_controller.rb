module Guara
  class BusinessActivitiesController < BaseController
    load_and_authorize_resource
=begin  
  # GET /business_activities
  # GET /business_activities.json
  def index
    @business_activities = BusinessActivity.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @business_activities }
    end
  end

  # GET /business_activities/1
  # GET /business_activities/1.json
  def show
    @business_activity = BusinessActivity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @business_activity }
    end
  end

  # GET /business_activities/new
  # GET /business_activities/new.json
  def new
    @business_activity = BusinessActivity.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @business_activity }
    end
  end

  # GET /business_activities/1/edit
  def edit
    @business_activity = BusinessActivity.find(params[:id])
  end
=end

    # POST /business_activities
    # POST /business_activities.json
    def create
      #@business_activity = BusinessActivity.new(params[:business_activity])

      respond_to do |format|
        if @business_activity.save
          format.html { redirect_to @business_activity, notice: 'Business activity was successfully created.' }
          format.json { render json: @business_activity, status: :created, location: @business_activity }
        else
          format.html { render action: "new" }
          format.json { render json: @business_activity.errors, status: :unprocessable_entity }
        end
      end
    end

    # PUT /business_activities/1
    # PUT /business_activities/1.json
    def update
      #@business_activity = BusinessActivity.find(params[:id])

      respond_to do |format|
        if @business_activity.update_attributes(params[:business_activity])
          format.html { redirect_to @business_activity, notice: 'Business activity was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @business_activity.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /business_activities/1
    # DELETE /business_activities/1.json
    def destroy
      #@business_activity = BusinessActivity.find(params[:id])
      @business_activity.destroy

      respond_to do |format|
        format.html { redirect_to business_activities_url }
        format.json { head :no_content }
      end
    end
  end
end