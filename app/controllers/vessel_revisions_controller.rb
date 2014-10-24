class VesselRevisionsController < ApplicationController
  def create
    @vessel_revision = VesselRevision.new create_params
    if @vessel_revision.save
      redirect_to vessels_path
    else
      redirect_to vessel_path(@vessel_revision.vessel)
    end
  end
end
