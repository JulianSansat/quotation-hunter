class Api::V1::QuotationsController < Api::V1::ApiController
  def index
  	quotations = Quotation.all
  end

  def variation
  	variation_data = QuotationsByDateService.quotations_variation(params[:moment], params[:currency_code])
  	render json: {variation_data: variation_data}, status: 200
  end

  def fetch_quotations
    response = QuotationsFetchService.fetch_quotations
    if(response)
      render json: {result: response, status: '200'}
    else
      render json: { error: 'error saving quotations' }, status: 422
    end
  	  
  end
end