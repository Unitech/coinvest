class AddYoutubeToProjects < ActiveRecord::Migration
  def change
    change_table :projects do |t|
      t.string :you_tube
    end
  end
end
