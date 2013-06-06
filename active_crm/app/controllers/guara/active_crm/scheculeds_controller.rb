require_dependency "guara/active_crm/application_controller"

module Guara
  class ActiveCrm::ScheculedsController < ApplicationController
    # GET /active_crm/scheculeds
    # GET /active_crm/scheculeds.json
    def index
      @active_crm_scheculeds = ActiveCrm::Scheculed.all
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @active_crm_scheculeds }
      end
    end
  
    # GET /active_crm/scheculeds/1
    # GET /active_crm/scheculeds/1.json
    def show
      @active_crm_scheculed = ActiveCrm::Scheculed.find(params[:id])
  
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @active_crm_scheculed }
      end
    end
  
    # GET /active_crm/scheculeds/new
    # GET /active_crm/scheculeds/new.json
    def new
      @active_crm_scheculed = ActiveCrm::Scheculed.new
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @active_crm_scheculed }
      end
    end
  
    # GET /active_crm/scheculeds/1/edit
    def edit
      @active_crm_scheculed = ActiveCrm::Scheculed.find(params[:id])
    end
  
    # POST /active_crm/scheculeds
    # POST /active_crm/scheculeds.json
    def create
      @active_crm_scheculed = ActiveCrm::Scheculed.new(params[:active_crm_scheculed])
  
      respond_to do |format|
        if @active_crm_scheculed.save
          format.html { redirect_to @active_crm_scheculed, notice: 'Scheculed was successfully created.' }
          format.json { render json: @active_crm_scheculed, status: :created, location: @active_crm_scheculed }
        else
          format.html { render action: "new" }
          format.json { render json: @active_crm_scheculed.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PUT /active_crm/scheculeds/1
    # PUT /active_crm/scheculeds/1.json
    def update
      @active_crm_scheculed = ActiveCrm::Scheculed.find(params[:id])
  
      respond_to do |format|
        if @active_crm_scheculed.update_attributes(params[:active_crm_scheculed])
          format.html { redirect_to @active_crm_scheculed, notice: 'Scheculed was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @active_crm_scheculed.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /active_crm/scheculeds/1
    # DELETE /active_crm/scheculeds/1.json
    def destroy
      @active_crm_scheculed = ActiveCrm::Scheculed.find(params[:id])
      @active_crm_scheculed.destroy
  
      respond_to do |format|
        format.html { redirect_to active_crm_scheculeds_url }
        format.json { head :no_content }
      end
    end
  end
end
