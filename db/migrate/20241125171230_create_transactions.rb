class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.references :source_wallet, null: false, foreign_key: true
      t.references :target_wallet, null: false, foreign_key: true
      t.decimal :amount, :precision => 15, :scale => 2
      t.string :transaction_type
      t.string :status

      t.timestamps
    end
  end
end
