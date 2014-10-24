class VesselRevision < ActiveRecord::Base
  belongs_to :vessel
  belongs_to :cause
  belongs_to :classification
end
