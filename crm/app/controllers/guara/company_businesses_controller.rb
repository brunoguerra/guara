module Guara
  class CompanyBusinessesController < BaseController
    load_and_authorize_resource


    # POST /company_businesses
    # POST /company_businesses.json
    def create

      respond_to do |format|
        if @company_business.save
          format.html { redirect_to @company_business, notice: 'Company business was successfully created.' }
          format.json { render json: @company_business, status: :created, location: @company_business }
        else
          format.html { render action: "new" }
          format.json { render json: @company_business.errors, status: :unprocessable_entity }
        end
      end
    end

    # PUT /company_businesses/1
    # PUT /company_businesses/1.json
    def update

      respond_to do |format|
        if @company_business.update_attributes(params[:company_business])
          format.html { redirect_to @company_business, notice: 'Company business was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @company_business.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /company_businesses/1
    # DELETE /company_businesses/1.json
    def destroy
      @company_business.destroy

      respond_to do |format|
        format.html { redirect_to company_businesses_url }
        format.json { head :no_content }
      end
    end
  end
end