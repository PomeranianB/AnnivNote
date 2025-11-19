class AddColumnGroups < ActiveRecord::Migration[6.1]
  def change
    add_column :groups, :short_comment, :string, after: :introduction 
  end
end
