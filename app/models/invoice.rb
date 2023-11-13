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

    best_bulk_discounts = InvoiceItem.joins(item: { merchant: :bulk_discounts })
                               .where("bulk_discounts.quantity_threshold <= invoice_items.quantity")
                               .select("invoice_items.id, MAX(bulk_discounts.percentage_discount / 100.0 * invoice_items.unit_price * invoice_items.quantity) AS total_discount")
                               .group("invoice_items.id")

    best_bulk_discounts
    
    # require 'pry'; binding.pry
    # max_discounts = invoice_items.select("invoice_items.id, MAX(bulk_discount.percentage_discount / 100) * invoice_items.unit_price * invoice_items.quantity as total_discount")
    #               .joins(item: {merchant: :bulk_discounts})
    #               .where("bulk_discounts.threshold_quantity <= invoice_items.quantity")
    #               .group("invoice_items.id")


    # max_discounts.sum { |invoice_item| invoice_item.total_discount}

    # invoice_items.sum("unit_price * quantity * CASE WHEN quantity >= 10 THEN 0.8 WHEN quantity >= 5 THEN 0.9 ELSE 1.0 END")
    
    
    # discounted_revenue = invoice_items.sum("price * quantity * CASE WHEN quantity >= #{quantity_threshold} THEN (1 - #{percentage_discount.to_f / 100}) WHEN quantity >= #{quantity_threshold} THEN (1 - #{percentage_discount.to_f / 100}) ELSE 1 END")
    
    
    # merchants.each do |merchant|
    #   merchants.bulk_discounts.first
    # end
  end

  def total_discount
    best_bulk_discounts = discounted_revenue

    best_bulk_discounts.sum(&:total_discount)
  end

  def total_discounted_revenue
    total_revenue - total_discount
  end


end
