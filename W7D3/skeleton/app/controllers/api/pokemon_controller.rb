
class Api::PokemonController < ApplicationController

  def index
    @pokemons = Pokemon.all
    render :index
  end

  def show
    @pokemon = Pokemon.find(params[:id])
    render :show
  end

  def create
    @pokemon = Pokemon.new(poke_params)
    if @pokemon.save
      render :show
    else
      render json: @pokemon.errors.full_messages
    end
  end

  private
  def poke_params
    params.require(:pokemon).permit(:name, :attack, :defense, :poke_type, :moves, :image_url)
  end



end
