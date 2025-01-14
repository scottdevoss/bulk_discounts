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
        
        within("#discounts-index") do
          expect(page).to have_link(@discount_a.name)
          expect(page).to have_content(@discount_a.percentage_discount)
          expect(page).to have_content(@discount_a.quantity_threshold)
          
          expect(page).to have_link(@discount_b.name)
          expect(page).to have_content(@discount_b.percentage_discount)
          expect(page).to have_content(@discount_b.quantity_threshold)
        end

        click_link(@discount_a.name)

        expect(current_path).to eq "/bulk_discounts/#{@discount_a.id}"

        expect(page).to have_content(@discount_a.name)
        expect(page).to have_content(@discount_a.percentage_discount)
        expect(page).to have_content(@discount_a.quantity_threshold)

        expect(page).to_not have_content(@discount_b.name)
      end
    end
  end

  #User Story 2
  describe "Merchant Bulk Discount Create" do
    describe "When I visit my bulk discounts index, then I see a link to create a new discount" do
      describe "When I click this link, I am taken to a new page where I see a form to add a new bulk discount" do
        it "I fill in the form and am redirected back to the bulk discount index and I see my new bulk discount listed" do
         
          visit "/merchants/#{@merchant1.id}/bulk_discounts"
          expect(page).to have_link("Create a new bulk discount")
          click_link("Create a new bulk discount")
          
          expect(current_path).to eq("/merchants/#{@merchant1.id}/bulk_discounts/new")
          # save_and_open_page
          # click_button "Submit"
          # expect(page).to have_content("Bulk Discount not created: Required information missing")
          
          fill_in :name, with: "Discount C"
          fill_in :percentage_discount, with: 20
          fill_in :quantity_threshold, with: 12
          click_button "Submit"
        
          
          expect(current_path).to eq("/merchants/#{@merchant1.id}/bulk_discounts")
          expect(page).to have_link("Discount C")
          expect(page).to have_content("Percentage Discount: 20%")
          expect(page).to have_content("Quantity Threshold: 12")
        end
      end
    end
  end

  #User Story 3
  describe "Merchant Buld Discount Delete" do
    describe "When I visit my bulk discounts index" do
      describe "Next to each bulk discount I see a button to delete it" do
        it "When I click delete, I am redirected to the bulk discounts index page and I no longer see the discount listed" do

          visit "/merchants/#{@merchant1.id}/bulk_discounts"

          expect(page).to have_link(@discount_a.name)
          expect(page).to have_content(@discount_a.percentage_discount)
          expect(page).to have_content(@discount_a.quantity_threshold)

          expect(page).to have_button("Delete #{@discount_a.name}")
          expect(page).to have_button("Delete #{@discount_b.name}")

          click_button("Delete #{@discount_a.name}")
          expect(current_path).to eq("/merchants/#{@merchant1.id}/bulk_discounts")

          expect(page).to_not have_link(@discount_a.name)
        end
      end
    end

    it "redirects the user to fill in every field" do
      visit "/merchants/#{@merchant1.id}/bulk_discounts/new"
      # save_and_open_page
      fill_in :name, with: "Discount C"
      click_button "Submit"
      expect(page).to have_content("Bulk Discount not created: Required information missing")

      expect(current_path).to eq("/merchants/#{@merchant1.id}/bulk_discounts/new")
      
      fill_in :name, with: "Discount C"
      fill_in :percentage_discount, with: 20
      fill_in :quantity_threshold, with: 12
      click_button "Submit"
    
      expect(current_path).to eq("/merchants/#{@merchant1.id}/bulk_discounts")
      expect(page).to have_link("Discount C")
      expect(page).to have_content("Percentage Discount: 20%")
      expect(page).to have_content("Quantity Threshold: 12")
        
    end
  end
end