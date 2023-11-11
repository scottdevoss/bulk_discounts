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

    #User Story 5
    describe "I see a link to edit the bulk discount" do
      describe "When I click the link I am taken to a new page with a form to edit the discount" do
        describe "And I see that the discounts current attributes are pre-populated in the form" do
          it "When I change any/all of the information and click submit I am redirected to the show page and see the attribues have been updated" do
            
            visit "/bulk_discounts/#{@discount_a.id}"

            expect(page).to have_link("Edit this Bulk Discount")
            click_link("Edit this Bulk Discount")

            expect(current_path).to eq("/bulk_discounts/#{@discount_a.id}/edit")
            
            expect(find_field("Name").value).to eq "Discount A"
            expect(find_field("Percentage discount").value).to eq "10"
            expect(find_field("Quantity threshold").value).to eq "5"

            fill_in :quantity_threshold, with: 14
            click_button "Submit"

            expect(current_path).to eq("/bulk_discounts/#{@discount_a.id}")

            expect(page).to have_content(@discount_a.name)
            expect(page).to have_content(@discount_a.percentage_discount)
            expect(page).to have_content("Quantity Threshold: 14")
          end
        end
      end
    end
  end
end 