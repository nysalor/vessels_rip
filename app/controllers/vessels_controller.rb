class VesselsController < ApplicationController
  def index
    @vessels = Vessel.page params[:page]
  end

  def show
    @vessel = Vessel.find params[:id]
  end

  def new
    @vessel = Vessel.new
  end

  def edit
    @vessel = Vessel.find params[:id]
  end
end
