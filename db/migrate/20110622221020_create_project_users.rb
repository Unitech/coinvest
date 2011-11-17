class CreateProjectUsers < ActiveRecord::Migration
  def change
    create_table :project_users do |t|
      t.references :user
      t.references :project

      t.string :role
      t.timestamps
    end
  end
end
