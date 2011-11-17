class AddFinishedFieldToBugs < ActiveRecord::Migration
  def change
    add_column :bugs, :finished, :boolean
  end
end
