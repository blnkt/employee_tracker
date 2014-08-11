require 'active_record'
require './lib/collaboration'
require './lib/employee'
require './lib/division'
require './lib/project'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def splash
  puts 'Welcome to The Weyland Corporation'
  menu
end

def menu
  choice = nil
  until choice == 'x'
    puts "Enter 'd' to add a division, 'e' to add an employee, or 'p' to add a project."
    puts "Enter 'ld' to list all divisions, 'lpd' to list projects by division, 'le' to list all employees, or 'lp' to list all projects."
    puts "Enter 'ed' to add an employee to a division, or 'ep' to add an employee to a project."
    puts "Enter 'x' to exit."
    choice = gets.chomp
    case choice
      when 'd'
        add_division
      when 'e'
        add_employee
      when 'p'
        add_project
      when 'ld'
        list_divisions
      when 'le'
        list_employees
      when 'lp'
        list_projects
      when 'lpd'
        projects_by_division
      when 'ed'
        add_employee_division
      when 'ep'
        add_employee_project
      when 'x'
        puts "Good-bye!"
      else
        puts "Sorry, that wasn't a valid option."
    end
  end
end

def add_division
  puts "What is the name of the new division?"
  division_name = gets.chomp
  division = Division.create({:name => division_name})
  puts "'#{division_name}' has been added."
end

def list_divisions
  Division.all.each do |division|
    puts division.name
  end
end

def add_employee_division
  list_divisions
  puts "Enter the name of a division."
  division_name = gets.chomp.to_s
  list_employees
  puts "Enter the name of an employee to add them to '#{division_name}'."
  employee_name = gets.chomp.to_s
  Employee.find_by(name: employee_name).update(division_id: Division.find_by(name: division_name).id)
  puts "Successfully added."
end

def add_employee
  puts "What is the name of the new employee?"
  employee_name = gets.chomp
  employee = Employee.create({:name => employee_name})
  puts "Successfully added."
end


def list_employees
  Employee.all.each do |employee|
    puts employee.name
  end
end

def add_employee_project
  list_projects
  puts "Enter the name of a project."
  project_name = gets.chomp.to_s
  list_employees
  puts "Enter the name of an employee to add them to '#{project_name}'."
  employee_name = gets.chomp.to_s
  Employee.find_by(name: employee_name).projects << Project.find_by(name: project_name)
  puts "What role will '#{employee_name} have in '#{project_name}'."
  contribution = gets.chomp
  # Employee.find_by(name: employee_name).contributions
  Collaboration.find_by(employee_id: Employee.find_by(name: employee_name).id).update(contribution: contribution)
  puts "Successfully added."
end

def add_project
  puts "What is the name of the new project?"
  project_name = gets.chomp
  project = Project.create({:name => project_name})
  puts "'#{project_name}' has been added."
end

def list_projects
  Project.all.each do |project|
    puts project.name
  end
end

def projects_by_division
  list_divisions
  puts "Choose a division to see what projects that division have completed."
  division = gets.chomp
  Division.find_by(name: division)
  Employee.where(division_id: Division.find_by(name: division)).map {|employee| employee.projects.each {|project| puts project.name}}
end

menu
