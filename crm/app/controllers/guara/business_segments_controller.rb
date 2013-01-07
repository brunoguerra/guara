module Guara
  class BusinessSegmentsController < BaseController
  
    load_and_authorize_resource
=begin  
  # GET /business_segments
  # GET /business_segments.json
  def index
    @business_segments = BusinessSegment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @business_segments }
    end
  end

  # GET /business_segments/1
  # GET /business_segments/1.json
  def show
    @business_segment = BusinessSegment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @business_segment }
    end
  end

  # GET /business_segments/new
  # GET /business_segments/new.json
  def new
    @business_segment = BusinessSegment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @business_segment }
    end
  end

  # GET /business_segments/1/edit
  def edit
    @business_segment = BusinessSegment.find(params[:id])
  end
=end

    # POST /business_segments
    # POST /business_segments.json
    def create
      #@business_segment = BusinessSegment.new(params[:business_segment])

      respond_to do |format|
        if @business_segment.save
          format.html { redirect_to @business_segment, notice: 'Business segment was successfully created.' }
          format.json { render json: @business_segment, status: :created, location: @business_segment }
        else
          format.html { render action: "new" }
          format.json { render json: @business_segment.errors, status: :unprocessable_entity }
        end
      end
    end

    # PUT /business_segments/1
    # PUT /business_segments/1.json
    def update
      #@business_segment = BusinessSegment.find(params[:id])

      respond_to do |format|
        if @business_segment.update_attributes(params[:business_segment])
          format.html { redirect_to @business_segment, notice: 'Business segment was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @business_segment.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /business_segments/1
    # DELETE /business_segments/1.json
    def destroy
      #@business_segment = BusinessSegment.find(params[:id])
      @business_segment.destroy

      respond_to do |format|
        format.html { redirect_to business_segments_url }
        format.json { head :no_content }
      end
    end
  end
end
