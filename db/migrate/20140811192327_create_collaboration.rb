class CreateCollaboration < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|
      t.belongs_to :employee
      t.belongs_to :project
      t.string :contribution
      t.timestamps
    end
  end
end
