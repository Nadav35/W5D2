class CreatePostSubs < ActiveRecord::Migration[5.1]
  def change
    create_table :post_subs do |t|
      t.integer :sub_id, null: false, index: true
      t.integer :post_id, null: false, index: true

      t.timestamps
    end
    add_index :post_subs, [:sub_id, :post_id], unique: true
  end
end
