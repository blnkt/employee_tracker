class Employee < ActiveRecord::Base

  belongs_to :division
  has_many :collaborations
  has_many :projects, :through => :collaborations
end
