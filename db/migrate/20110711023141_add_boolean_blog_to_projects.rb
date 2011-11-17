class AddBooleanBlogToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :blog_enabled, :boolean
  end
end
