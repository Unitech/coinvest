class CreateCounterpartUsers < ActiveRecord::Migration
  def change
    create_table :counterpart_users do |t|
      t.references :user
      t.references :counterpart
      t.timestamps
    end
  end
end
