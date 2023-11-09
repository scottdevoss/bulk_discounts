require "rails_helper"

RSpec.describe "Merchant Bulk Discounts Index" do
  before :each do
    @merchant1 = Merchant.create!(name: "Hair Care")
    @merchant2 = Merchant.create!(name: "Hair Care")

    @bulk_discount1 = BulkDiscount.create!(percentage_discount: 10, quantity_threshold: 5, merchant_id: @merchant1.id)
  end
  
  #User Story 1
  describe "When I visit my merchant dashboard then I see a link to view all my discounts" do
    describe "When I click this link then I am taken to my bulk discounts index page" do
      it "Where I see all of my bulk discounts including their percentage discount and quantity thresholds and each bulk discount listed includes a link to its show page" do
        
        require 'pry'; binding.pry
        visit "/merchants/#{@merchant1.id}/dashboard"

        expect(page).to have_link("View all my discounts")
        click_link("View all my discounts")

        expect(current_path).to eq "/merchants/#{@merchant1.id}/bulk_discounts"

        expect(page).to have_content(@bulk_discounts1)

      end
    end
  end
end