class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: 'Wallet', optional: true
  belongs_to :target_wallet, class_name: 'Wallet', optional: true

  validates :amount, numericality: {greater_than: 0}
  validates :transaction_type, inclusion: { in: %w[credit debit transfer] }
  validate :validate_wallets
  after_create :update_wallet_balances

  private

  def validate_wallets
    if transaction_type == "credit" && source_wallet.present?
      errors.add(:source_wallet, "should be nil for credits")
    elsif transaction_type == "debit" && target_wallet.present?
      errors.add(:target_wallet, "should be nil for debits")
    elsif transaction_type == "transfer" && (source_wallet.nil? || target_wallet.nil?)
      errors.add(:base, "both wallet must be present for transfer")
    end
  end

  def update_wallet_balances
    Wallet.transaction do
      if transaction_type == 'credit'
        target_wallet.increment!(:balance, amount)
      elsif transaction_type == 'debit'
        source_wallet.decrement!(:balance, amount)
      elsif transaction_type == 'transfer'
        source_wallet.decrement!(:balance, amount)
        target_wallet.increment!(:balance, amount)
      end
    end
  end
  
end
