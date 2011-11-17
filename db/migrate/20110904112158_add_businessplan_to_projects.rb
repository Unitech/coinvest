class AddBusinessplanToProjects < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.text :business_plan
    end
  end
end
