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
    @bulk_discount = BulkDiscount.new(percentage_discount: params[:percentage_discount], quantity_threshold: params[:quantity_threshold], name: params[:name], merchant_id: params[:id])
    if @bulk_discount.save
      redirect_to "/merchants/#{@merchant.id}/bulk_discounts"
    else 
      flash.notice = "Bulk Discount not created: Required information missing"
      redirect_to "/merchants/#{@merchant.id}/bulk_discounts/new"
    end 
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    discount = BulkDiscount.find(params[:id])
    discount.destroy
    redirect_to "/merchants/#{@merchant.id}/bulk_discounts"
  end

  def edit
    @discount = BulkDiscount.find(params[:id])
  end

  def update
    @discount = BulkDiscount.find(params[:id])
    @discount.update(percentage_discount: params[:percentage_discount], quantity_threshold: params[:quantity_threshold], name: params[:name])
    redirect_to "/bulk_discounts/#{@discount.id}"
  end
end