class DosesController < ApplicationController
  def index
    @cocktail = Cocktail.find(params[cocktail_id])
    @doses = Cocktail.doses
  end

  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new(dose_strong_params)
    @dose.cocktail_id = @cocktail.id

    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    index = @dose.cocktail_id
    @cocktail = Cocktail.find(index)
    @dose.delete
    redirect_to cocktail_path(@cocktail)
  end

  private

  def dose_strong_params
    params.require(:dose).permit(:description, :ingredient_id)
  end
end
