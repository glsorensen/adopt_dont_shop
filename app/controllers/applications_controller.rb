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
    elsif params[:add_pet]
      @applicant.pets << Pet.find(params[:add_pet])
      @pets = @applicant.pets
    else
      @pets =[]
    end
  end

  def update
    @applicant = Application.find(params[:id])
    @applicant.update({
            description: params[:description],
            status: "Pending"})
    redirect_to "/applications/#{@applicant.id}"
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zipcode, :description, :status)
  end
end
