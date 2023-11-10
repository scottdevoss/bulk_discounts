class BulkDiscountsController < ApplicationController
  def index
    @discounts = BulkDiscount.all
    @merchant = Merchant.find(params[:id])
  end

  def show 
    @discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:id])
  end

  def create
    @merchant = Merchant.find(params[:id])
    BulkDiscount.create!(percentage_discount: params[:percentage_discount], quantity_threshold: params[:quantity_threshold], name: params[:name], merchant_id: params[:id])
    redirect_to "/merchants/#{@merchant.id}/bulk_discounts"
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    discount = BulkDiscount.find(params[:id])
    discount.destroy
    redirect_to "/merchants/#{@merchant.id}/bulk_discounts"
  end
end