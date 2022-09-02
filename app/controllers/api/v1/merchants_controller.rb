class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    if Merchant.exists?(params[:id])
      render json: MerchantSerializer.new(Merchant.find(params[:id]))
    else
      render json: { error: 'No merchant found' }, status: 404
    end 
  end


  # def find
  #   if params[:name]
  #     found = Merchant.search(params[:name])
  #     first = found.first
  #     render json: MerchantSerializer.new(first)
  #   else
  #   end
  # end
end
