class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :bulk_discounts, through: :merchants

  enum status: [:cancelled, :in_progress, :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def discounted_revenue
    invoice_items.sum("unit_price * quantity * CASE WHEN quantity >= 10 THEN 0.8 WHEN quantity >= 5 THEN 0.9 ELSE 1.0 END")
    # discounted_revenue = invoice_items.sum("price * quantity * CASE WHEN quantity >= #{quantity_threshold} THEN (1 - #{percentage_discount.to_f / 100}) WHEN quantity >= #{quantity_threshold} THEN (1 - #{percentage_discount.to_f / 100}) ELSE 1 END")
    
    
    # merchants.each do |merchant|
    #   merchants.bulk_discounts.first
    # end
  end

  def discount_applied
    
  end
end
