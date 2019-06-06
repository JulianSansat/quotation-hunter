class Api::V1::QuotationsController < Api::V1::ApiController

  def index
  	quotations = QuotationsByDateService.quotations_of(params[:moment], params[:currency_code])
    render json: {quotations: quotations}, status: 200
  end
end