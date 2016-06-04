class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.integer :moderator_id, null: false

      t.timestamps null: false
    end
    add_index :subs, :title
    add_indes :subs, :moderator_id, unique: true
  end
end
