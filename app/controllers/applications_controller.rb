class ApplicationsController < ApplicationController

  def show
    @applicant = Application.find(params[:id])
  end

  def new
  end

  def create
    @application = Application.new({
                    name: params[:name],
                    address: params[:address],
                    city: params[:city],
                    state: params[:state],
                    zipcode: params[:zipcode]})
    if @application.save
        redirect_to "/applications/#{@application.id}"
    else
        redirect_to "/applications/new"
        flash[:alert] = "Error: #{error_message(@application.errors)}"
    end

  end
end
