class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.column :name, :string
      t.timestamps
      t.belongs_to :division
      t.references :manager
    end
  end
end
