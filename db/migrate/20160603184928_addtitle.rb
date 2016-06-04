class Addtitle < ActiveRecord::Migration
  def change
    add_column :subs, :title, :string
    add_column :subs, :description, :string
    add_column :subs, :moderator_id, :integer
  end
end
