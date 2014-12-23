class FederationsController < ApplicationController

  before_action :load_federation, only: [:show, :edit, :update, :delete]

  def index
    @federations = Federation.all
  end

  def show
  end

  def new
    @federation = Federation.new
  end

  def create
    @federation = Federation.new(federation_params)
    if @federation.save
      render :show
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @federation.update_attributes(federation_params)
      render :show
    else
      render :edit
    end
  end

  private

  def load_federation
    @federation = Federation.find(params[:id])
  end

  def federation_params
    params.require(:federation).permit(:name)
  end

end
