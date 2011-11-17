class CreateCounterparts < ActiveRecord::Migration
  def change
    create_table :counterparts do |t|
      t.references :project
      t.integer :bearing
      t.text :description
      t.timestamps
    end
  end
end
