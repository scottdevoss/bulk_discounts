require "rails_helper"

RSpec.describe "Merchant Bulk Discounts Index" do
  before :each do

  end
  
  #User Story 1
  describe "When I visit my merchant dashboard then I see a link to view all my discounts" do
    describe "When I click this link then I am taken to my bulk discounts index page" do
      it "Where I see all of my bulk discounts including their percentage discount and quantity thresholds and each bulk discount listed includes a link to its show page" do
        visit "/merchants/:merchant_id/dashboard"

        
      end
    end
  end
end