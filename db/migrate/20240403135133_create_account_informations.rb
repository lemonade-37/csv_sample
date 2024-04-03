class CreateAccountInformations < ActiveRecord::Migration[7.1]
  def change
    create_table :account_informations do |t|
      t.bigint :user_id, null: false
      t.string :bank_code                 # 銀行コード
      t.string :branch_code               # 支店コード
      t.integer :deposit_type, default: 1 # 預金種目
      t.string :account_number            # 口座番号
      t.string :bank_account              # 口座名義人名

      t.timestamps
    end

    add_foreign_key :account_informations, :users, column: :user_id
    add_index :account_informations, :user_id
  end
end
