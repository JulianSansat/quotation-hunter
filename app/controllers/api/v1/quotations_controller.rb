class Api::V1::QuotationsController < Api::V1::ApiController
  
  def index
    if(params[:currency_code].present?)
      quotations = QuotationsByDateService.get_quotations_of_by_code(params[:moment], params[:currency_code])
    else
      quotations = QuotationsByDateService.get_quotations_of(params[:moment])
    end
    render json: {quotations: quotations}, status: 200
  end

  def variation
  	variation_data = QuotationsByDateService.quotations_variation(params[:moment], params[:currency_code])
  	if (variation_data.length > 0)
      render json: {variation_data: variation_data}, status: 200  
    else
      render json: {msg: 'not enought records'}, status: 204
    end
      
  end

  def preview
    quotations = QuotationsByDateService.quotations_preview
    if (quotations.length > 0)
      render json: {quotations: quotations}, status: 200  
    else
      render json: {msg: 'not enought records'}, status: 204
    end
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