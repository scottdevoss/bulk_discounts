class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, :in_progress, :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def discounted_revenue
    discounted_revenue = invoice_items.sum("unit_price * quantity * CASE WHEN quantity >= 10 THEN 0.8 WHEN quantity >= 5 THEN 0.9 ELSE 1.0 END")
  end
end
