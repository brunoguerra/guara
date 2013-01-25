
module Guara
  class ProductsController < Guara::StoreBaseController
    load_and_authorize_resource :class => "Guara::Product"

    def index
	    @search = Product.search(params[:search])
	    @products = @search.result().paginate(page: params[:page], :per_page => 10)
	    params[:search] = {} if params[:search].nil?
	end

	def new 
		@product    = Product.new
		@categories = StoreCategory.all
	end

	def edit
		@product 	= Product.find params[:id]
		@categories = StoreCategory.find(:all)
	end

	def create
	    @product = Product.new
	    @product.attributes = params[:product]

	    if @product.save
	      flash[:success] = t("helpers.forms.new_sucess")
	      redirect_to product_path(@product.id)
	      #redirect_to :action=>'show'
	    else
	      render :new
	    end
	end

	def update
		@product = Product.find params[:id]
		if @product.update_attributes(params[:product])
			flash[:success] = t("helpers.forms.edit_sucess")
	    	#redirect_to products_path(@product.id)
	    	redirect_to :controller=>'products',:action=>'show'
	    else	
	    	redirect_to edit_product_path
	    end
	end

	def multiselect_categories_products
	    render :json => StoreCategory.where(["name ilike ?", "%"+params[:tag]+"%"] ).collect { |c| { :key => c.id.to_s, :value => c.name } }
	end

  end
end
