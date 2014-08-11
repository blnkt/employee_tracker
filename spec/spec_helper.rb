require 'active_record'
require 'rspec'
require 'pry'

require 'project'
require 'employee'
require 'division'
require 'collaboration'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

RSpec.configure do |config|
  config.after(:each) do
    Division.all.each { |division| division.destroy }
    Employee.all.each { |employee| employee.destroy }
    Project.all.each { |project| project.destroy }
    Collaboration.all.each { |collaboration| collaboration.destroy }
  end
end
