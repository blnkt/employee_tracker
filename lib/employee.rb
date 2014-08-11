class Employee < ActiveRecord::Base

  belongs_to :division
  has_many :collaborations
  has_many :projects, :through => :collaborations

  has_many :subordinates, class_name: 'Employee', foreign_key: 'manager_id'
  belongs_to :manager, class_name: 'Employee'
end
