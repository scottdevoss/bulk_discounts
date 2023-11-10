require "rails_helper"

RSpec.describe "Merchant Bulk Discounts Show Page" do
  before :each do
    @merchant1 = Merchant.create!(name: "Hair Care")
    @merchant2 = Merchant.create!(name: "Candles")

    @discount_a = BulkDiscount.create!(name: "Discount A", percentage_discount: 10, quantity_threshold: 5, merchant_id: @merchant1.id)
    @discount_b = BulkDiscount.create!(name: "Discount B", percentage_discount: 20, quantity_threshold: 10, merchant_id: @merchant1.id)
  end

  #User Story 4
  describe "When I visit my bulk discount show page" do
    it "I see the bulk discount's quantity threshold and percentage discount" do

      visit "/bulk_discounts/#{@discount_a.id}"

      expect(page).to have_content(@discount_a.name)
      expect(page).to have_content(@discount_a.percentage_discount)
      expect(page).to have_content(@discount_a.quantity_threshold)

      expect(page).to_not have_content(@discount_b.name)
    end
  end
end 