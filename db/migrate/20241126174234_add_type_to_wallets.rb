class AddTypeToWallets < ActiveRecord::Migration[8.0]
  def change
    add_column :wallets, :type, :string
  end
end
