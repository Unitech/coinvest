class CreateCreditHistorics < ActiveRecord::Migration
  def change
    create_table :credit_historics do |t|
      t.string :historic_type
      t.boolean :validated
      t.integer :value
      t.references :user
      t.timestamps
    end
  end
end
