require 'rails_helper'
require "time"

RSpec.describe 'Quotations API', type: :request do
    let(:headers) do
        {
          'Accept' => 'application/json',
          'Content-Type' => Mime[:json].to_s,
        }
    end

    before { host! "localhost:3000/api/v1"}

    describe 'get quotations of last day' do
        before do
            before_last_day = Date.current-2
            last_day = Date.current.yesterday.beginning_of_day
            
            currency = 'USD'
            
            moment = 'yesterday'

            create_list(:quotation, 3, currency_code: currency, created_at: last_day)
            create(:quotation, currency_code: currency, created_at: before_last_day)
            create(:quotation, currency_code: currency)
            
            get '/quotations', params: {
                    'currency_code' => currency,
                    'moment' => moment
                }
        end

        it 'returns 3 quotations created from yesterday' do
            expect(json_body[:quotations].count).to eq(3)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end

    end

    describe 'get quotations of last week' do
        before do
            before_last_week = Date.current.last_month.beginning_of_month
            whithin_last_week = Date.current.last_week.beginning_of_week.end_of_day

            currency = 'USD'

            moment = 'last_week'
        
            create_list(:quotation, 3, currency_code: currency, created_at: whithin_last_week)
            create(:quotation, currency_code: currency, created_at: before_last_week)
            create(:quotation, currency_code: currency)
            
            get '/quotations', params: {
                    'currency_code' => currency,
                    'moment' => moment
                }
        end

        it 'returns 3 quotations created from last week' do
            expect(json_body[:quotations].count).to eq(3)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end

    end

    describe 'get quotations of last month' do
        before do
            before_last_month = Date.current-60
            whithin_last_month = Date.current.last_month.beginning_of_month.end_of_day

            currency = 'USD'

            moment = 'last_month'
        
            create_list(:quotation, 3, currency_code: currency, created_at: whithin_last_month)
            create(:quotation, currency_code: currency, created_at: before_last_month)
            create(:quotation, currency_code: currency)
            
            get '/quotations', params: {
                    'currency_code' => currency,
                    'moment' => moment
                }
        end

        it 'returns 3 quotations created from last month' do
            expect(json_body[:quotations].count).to eq(3)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end

    end
end