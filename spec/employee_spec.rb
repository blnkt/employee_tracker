require 'spec_helper'

describe Employee do
  it 'correctly attaches a division id to an employee' do
    new_division = Division.create({:name => 'Engineering'})
    new_employee = Employee.create({:name => 'Bob the Builder', :division_id => new_division.id})
    expect(new_employee.division_id).to eq new_division.id
  end

  it 'belongs to a division' do
    new_division = Division.create({:name => 'Engineering'})
    new_employee = Employee.create({:name => 'Bob the Builder', :division_id => new_division.id})
    expect(new_employee.division).to eq new_division
  end

  # it 'has managers and subordinates' do
  #   new_employee = Employee.create({:name => 'Bob the Builder', :manager => new_employee})
  #   #new_employee
  #   expect(new_employee.manager).to eq new_employee
  # end

  it 'has many projects' do
    new_project = Project.create({:name => 'New Bridge'})
    another_project = Project.create({:name => 'New Tunnel'})
    new_employee = Employee.create({:name => 'Bob'})
    another_employee = Employee.create({:name => 'Janice'})
    new_collaboration = Collaboration.create({:employee_id => new_employee.id, :project_id => new_project.id, :contribution => 'Struts'})
    another_collaboration = Collaboration.create({:employee_id => another_employee.id, :project_id => new_project.id, :contribution => 'Slats'})
    expect(new_employee.projects).to eq [new_project]
    expect(another_employee.projects).to eq [new_project]
  end

end
