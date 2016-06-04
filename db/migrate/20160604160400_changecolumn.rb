class Changecolumn < ActiveRecord::Migration
  def change
    remove_column :subs, :moderator_id
    add_column :subs, :moderator_id, :integer
    change_column :subs, :moderator_id, :integer, null: false
  end
end
