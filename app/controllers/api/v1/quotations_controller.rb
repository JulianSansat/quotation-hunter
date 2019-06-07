class Api::V1::QuotationsController < Api::V1::ApiController

  def index
  	quotations = QuotationsByDateService.quotations_of(params[:moment], params[:currency_code])
    render json: {quotations: quotations}, status: 200
  end

  def variation
  	variation_data = QuotationsByDateService.quotations_variation(params[:moment], params[:currency_code])
  	render json: {variation_data: variation_data}, status: 200
  end
end