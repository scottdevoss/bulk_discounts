require "rails_helper"

RSpec.describe "Merchant Bulk Discounts Index" do
  before :each do
    @merchant1 = Merchant.create!(name: "Hair Care")
    @merchant2 = Merchant.create!(name: "Candles")

    @discount_a = BulkDiscount.create!(name: "Discount A", percentage_discount: 10, quantity_threshold: 5, merchant_id: @merchant1.id)
    @discount_b = BulkDiscount.create!(name: "Discount B", percentage_discount: 20, quantity_threshold: 10, merchant_id: @merchant1.id)
  end
  
  #User Story 1
  describe "When I visit my merchant dashboard then I see a link to view all my discounts" do
    describe "When I click this link then I am taken to my bulk discounts index page" do
      it "Where I see all of my bulk discounts including their percentage discount and quantity thresholds and each bulk discount listed includes a link to its show page" do
        
        visit "/merchants/#{@merchant1.id}/dashboard"

        expect(page).to have_link("View all my discounts")
        click_link("View all my discounts")

        expect(current_path).to eq "/merchants/#{@merchant1.id}/bulk_discounts"

        expect(page).to have_link(@discount_a.name)
        expect(page).to have_content(@discount_a.percentage_discount)
        expect(page).to have_content(@discount_a.quantity_threshold)

        expect(page).to have_link(@discount_b.name)
        expect(page).to have_content(@discount_b.percentage_discount)
        expect(page).to have_content(@discount_b.quantity_threshold)

        click_link(@discount_a.name)

        expect(current_path).to eq "/bulk_discounts/#{@discount_a.id}"

      end
    end
  end
end