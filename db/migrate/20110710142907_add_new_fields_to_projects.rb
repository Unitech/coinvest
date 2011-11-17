class AddNewFieldsToProjects < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.text :description
      t.string :url_path
    end
  end
end
