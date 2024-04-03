class CreateSales < ActiveRecord::Migration[7.1]
  def change
    create_table :sales do |t|
      t.bigint :user_id, null: false
      t.integer :price

      t.timestamps
    end

    add_foreign_key :sales, :users, column: :user_id
    add_index :sales, :user_id
  end
end
