class ApplicationsController < ApplicationController
  def index
  end

  def new
  end

  def create
    application = Application.new(application_params)

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to '/applications/new'
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  def show
    @applicant = Application.find(params[:id])

    if params[:pet_name]
      @pets = Pet.search(params[:pet_name])
    else
      @pets =[]
    end
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zipcode, :description, :status)
  end
end
