class AddPendingToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :pending, :boolean
  end
end
