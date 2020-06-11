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
    # 2.create the review with the strong params
    @dose = Dose.new(dose_strong_params)
    # 3. we want to assign the review to the restaureant of the url
    @dose.cocktail_id = @cocktail.id
    @dose.save!
    redirect_to cocktail_path(@cocktail)
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
