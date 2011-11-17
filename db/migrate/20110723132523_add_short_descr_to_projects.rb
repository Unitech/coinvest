class AddShortDescrToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :short_descr, :string
  end
end
