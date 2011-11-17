class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|

      t.column :title, :string, :limit => 128
      t.column :wish_money, :integer
      t.column :min_money, :integer

      t.column :date_end_wish, :datetime
      
      t.column :capital_stock_type, :boolean
      t.column :personalized_reward, :boolean

      t.timestamps
    end
    
    add_index :projects, :title, :unique => true
  end
end
