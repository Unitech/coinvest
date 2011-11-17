class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      t.confirmable

      # Type of user (investissor...)
      t.string :user_type 
      # t.encryptable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable

      # User specific
      t.string :f_name
      t.string :l_name

      t.datetime :birth_date
      t.string :birth_place
      t.string :nationality
      
      t.string :address
      t.string :postal_code
      t.string :city

      t.string :phone_number
      t.string :web_site

      t.string :photo_path
      
      t.boolean :receive_newsletter, :default => false

      
      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :confirmation_token,   :unique => true
    add_index :users, :user_type
    add_index :users, :f_name
    add_index :users, :l_name

    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
  end

  def self.down
    drop_table :users
  end
end
