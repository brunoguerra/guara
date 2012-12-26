
class Tests::AjaxesController < BaseController
  load_and_authorize_resource :class => "Tests::Ajax"
  respond_to :html, :xml, :json
  
  
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ajaxes }
    end
  end

  # GET /tests/ajaxes/1
  # GET /tests/ajaxes/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ajaxes }
    end
  end

  # GET /tests/ajaxes/new
  # GET /tests/ajaxes/new.json
  def new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ajaxes }
    end
  end

  # GET /tests/ajaxes/1/edit
  def edit
  end

  # POST /tests/ajaxes
  # POST /tests/ajaxes.json
  def create
    @ajaxes = Tests::Ajax.new(params[:tests_ajaxis])

    respond_to do |format|
      if @ajaxes.save
        format.html { redirect_to @ajaxes, notice: 'Ajax was successfully created.' }
        format.json { render json: @ajaxes, status: :created, location: @ajaxes }
      else
        format.html { render action: "new" }
        format.json { render json: @ajaxes.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tests/ajaxes/1
  # PUT /tests/ajaxes/1.json
  def update
    @ajaxes = Tests::Ajax.find(params[:id])

    respond_to do |format|
      if @ajaxes.update_attributes(params[:tests_ajaxis])
        format.html { redirect_to @ajaxes, notice: 'Ajax was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ajaxes.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tests/ajaxes/1
  # DELETE /tests/ajaxes/1.json
  def destroy
    @ajaxes = Tests::Ajax.find(params[:id])
    @ajaxes.destroy

    respond_to do |format|
      format.html { redirect_to tests_ajaxes_url }
      format.json { head :no_content }
    end
  end
  
  
  #test add and update
  def add_and_update
    
    respond_to do |format|
      format.html #
      format.json { head :no_content }
    end
  end
  
  def add
    respond_to do |format| 
      format.json do
        @ajax = Tests::Ajax.create!(name: (((Tests::Ajax.last ? Tests::Ajax.last.id : 0) + 1).to_s))
        all
      end
    end
  end
  
  def all
    respond_to do |format|
      format.json do
        #@template.template_format = :html
        @content = render_to_string( :partial => "tests/ajaxes/list", :formats => :html, :layout => false, :locals => { ajaxes: Tests::Ajax.all })
        render :json => { success: true, content: @content }
      end
      format.js do
        render "all", :layout => false, :content_type => 'application/javascript'
      end
    end
  end
  
  
end
