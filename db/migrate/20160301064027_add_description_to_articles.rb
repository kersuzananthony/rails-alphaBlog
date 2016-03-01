class AddDescriptionToArticles < ActiveRecord::Migration
  def change
    # Add description column to articles table
    add_column :articles, :description, :string # == add_column('articles', 'description', 'string')
    add_timestamps :articles
  end
end
