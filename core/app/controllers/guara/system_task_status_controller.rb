module Guara
  class SystemTaskStatusController < BaseController
    # GET /system_task_status
    # GET /system_task_status.json
    def index
      @system_task_status = SystemTaskStatu.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @system_task_status }
      end
    end

    # GET /system_task_status/1
    # GET /system_task_status/1.json
    def show
      @system_task_statu = SystemTaskStatu.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @system_task_statu }
      end
    end

    # GET /system_task_status/new
    # GET /system_task_status/new.json
    def new
      @system_task_statu = SystemTaskStatu.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @system_task_statu }
      end
    end

    # GET /system_task_status/1/edit
    def edit
      @system_task_statu = SystemTaskStatu.find(params[:id])
    end

    # POST /system_task_status
    # POST /system_task_status.json
    def create
      @system_task_statu = SystemTaskStatu.new(params[:system_task_statu])

      respond_to do |format|
        if @system_task_statu.save
          format.html { redirect_to @system_task_statu, notice: 'System task statu was successfully created.' }
          format.json { render json: @system_task_statu, status: :created, location: @system_task_statu }
        else
          format.html { render action: "new" }
          format.json { render json: @system_task_statu.errors, status: :unprocessable_entity }
        end
      end
    end

    # PUT /system_task_status/1
    # PUT /system_task_status/1.json
    def update
      @system_task_statu = SystemTaskStatu.find(params[:id])

      respond_to do |format|
        if @system_task_statu.update_attributes(params[:system_task_statu])
          format.html { redirect_to @system_task_statu, notice: 'System task statu was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @system_task_statu.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /system_task_status/1
    # DELETE /system_task_status/1.json
    def destroy
      @system_task_statu = SystemTaskStatu.find(params[:id])
      @system_task_statu.destroy

      respond_to do |format|
        format.html { redirect_to system_task_status_url }
        format.json { head :no_content }
      end
    end
  end
end