class AddFieldsToProjects < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      # Projets sont en attentes de confirmation
      t.boolean :submited
      t.boolean :validated
      t.string :region
      t.string :pres_doc_path
      t.integer :progress
    end
  end
end
