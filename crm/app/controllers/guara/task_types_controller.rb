module Guara
  class TaskTypesController < ApplicationController
    load_and_authorize_resource 
    # GET /task_types
    # GET /task_types.json
    def index
      @task_types = TaskType.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @task_types }
      end
    end

    # GET /task_types/1
    # GET /task_types/1.json
    def show
      @task_type = TaskType.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @task_type }
      end
    end

    # GET /task_types/new
    # GET /task_types/new.json
    def new
      @task_type = TaskType.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @task_type }
      end
    end

    # GET /task_types/1/edit
    def edit
      @task_type = TaskType.find(params[:id])
    end

    # POST /task_types
    # POST /task_types.json
    def create
      @task_type = TaskType.new(params[:task_type])

      respond_to do |format|
        if @task_type.save
          format.html { redirect_to @task_type, notice: 'Task type was successfully created.' }
          format.json { render json: @task_type, status: :created, location: @task_type }
        else
          format.html { render action: "new" }
          format.json { render json: @task_type.errors, status: :unprocessable_entity }
        end
      end
    end

    # PUT /task_types/1
    # PUT /task_types/1.json
    def update
      @task_type = TaskType.find(params[:id])

      respond_to do |format|
        if @task_type.update_attributes(params[:task_type])
          format.html { redirect_to @task_type, notice: 'Task type was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @task_type.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /task_types/1
    # DELETE /task_types/1.json
    def destroy
      @task_type = TaskType.find(params[:id])
      @task_type.destroy

      respond_to do |format|
        format.html { redirect_to task_types_url }
        format.json { head :no_content }
      end
    end
  end
end