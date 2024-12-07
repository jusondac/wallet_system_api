class CreateWallets < ActiveRecord::Migration[8.0]
  def change
    create_table :wallets do |t|
      t.references :entity, null: false, polymorphic: true
      t.decimal :balance, :precision => 15, :scale => 2, :default => 0.0, null: false
      #Ex:- :default =>''

      t.timestamps
    end
  end
end
