class FixTransactionForeignKeys < ActiveRecord::Migration[8.0]
  def up
    # SQLite sometimes uses table names like `main.target_wallets` internally
    execute <<-SQL
      PRAGMA foreign_keys = OFF; -- Temporarily disable foreign keys
    SQL

    # Attempt to remove the incorrect foreign keys
    remove_foreign_key :transactions, column: :source_wallet_id rescue nil
    remove_foreign_key :transactions, column: :target_wallet_id rescue nil

    execute <<-SQL
      PRAGMA foreign_keys = ON; -- Re-enable foreign keys
    SQL
  end

  def down
    
  end
  
end
