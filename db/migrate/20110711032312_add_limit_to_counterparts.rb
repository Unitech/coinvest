class AddLimitToCounterparts < ActiveRecord::Migration
  def change
    add_column :counterparts, :limit_products, :integer
  end
end
