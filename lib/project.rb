class Project < ActiveRecord::Base

  has_many :collaborations
  has_many :employees, :through => :collaborations
end
