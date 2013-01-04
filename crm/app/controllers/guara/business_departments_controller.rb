module Guara
  class BusinessDepartmentsController < BaseController
    load_and_authorize_resource
=begin  
  # GET /business_departments
  # GET /business_departments.json
  def index
    @business_departments = BusinessDepartment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @business_departments }
    end
  end

  # GET /business_departments/1
  # GET /business_departments/1.json
  def show
    @business_department = BusinessDepartment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @business_department }
    end
  end

  # GET /business_departments/new
  # GET /business_departments/new.json
  def new
    @business_department = BusinessDepartment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @business_department }
    end
  end

  # GET /business_departments/1/edit
  def edit
    @business_department = BusinessDepartment.find(params[:id])
  end

=end

    # POST /business_departments
    # POST /business_departments.json
    def create
      #@business_department = BusinessDepartment.new(params[:business_department])

      respond_to do |format|
        if @business_department.save
          format.html { redirect_to @business_department, notice: 'Business department was successfully created.' }
          format.json { render json: @business_department, status: :created, location: @business_department }
        else
          format.html { render action: "new" }
          format.json { render json: @business_department.errors, status: :unprocessable_entity }
        end
      end
    end
  
=begin
  # PUT /business_departments/1
  # PUT /business_departments/1.json
  def update
    @business_department = BusinessDepartment.find(params[:id])

    respond_to do |format|
      if @business_department.update_attributes(params[:business_department])
        format.html { redirect_to @business_department, notice: 'Business department was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @business_department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /business_departments/1
  # DELETE /business_departments/1.json
  def destroy
    @business_department = BusinessDepartment.find(params[:id])
    @business_department.destroy

    respond_to do |format|
      format.html { redirect_to business_departments_url }
      format.json { head :no_content }
    end
  end
=end
  end
end