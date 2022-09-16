class PetsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]

  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find_by(id: params[:id])
  end

  def new
    @pet = Pet.new
    render template: "pets/new"
  end

  def create
    @pet = Pet.new(pet_params)

    if @pet.save
      redirect_to "/pets/#{@pet.id}"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @pet = Pet.find_by(id: params[:id])
    render template: "pets/edit"
  end

  def update
    @pet = Pet.find_by(id: params[:id])
    @pet.name = params[:pet][:name] || @pet.name
    @pet.breed = params[:pet][:breed] || @pet.breed
    @pet.image = params[:pet][:image] || @pet.image
    if @pet.save
      redirect_to "/pets/#{@pet.id}"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @pet = Pet.find_by(id: params[:id])
    @pet.destroy
    redirect_to "/pets", status: :see_other
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :breed, :image)
  end
end
