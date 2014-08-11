class Collaboration < ActiveRecord::Base

  belongs_to :project
  belongs_to :employee

end
