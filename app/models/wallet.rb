class Wallet < ApplicationRecord
  belongs_to :entity, polymorphic: true
  has_many :source_transaction, class_name: 'Transaction', foreign_key: 'source_wallet_id'
  has_many :target_transaction, class_name: 'Transaction', foreign_key: 'target_wallet_id'

  validates :balance, numericality: { greater_than_or_equal_to: 0}
  def wallet_balance
    "Rp. #{balance}"
  end
end