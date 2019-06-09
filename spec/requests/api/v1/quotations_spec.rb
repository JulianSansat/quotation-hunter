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

    describe 'get currency variation of last day' do
        before do
            before_last_day = Date.current-2
            last_day = Date.current.yesterday
            
            currency = 'USD'
            
            moment = 'yesterday'

            openingPrice = Faker::Number.number(7).to_i
            closePrice = Faker::Number.number(7).to_i

            @expectedVariation = ((closePrice - openingPrice).to_f/openingPrice) * 100

            create(:quotation, currency_code: currency, buy: openingPrice, created_at: last_day.beginning_of_day)
            create(:quotation, currency_code: currency, buy: closePrice, created_at: last_day.end_of_day)

            create(:quotation, currency_code: currency, created_at: before_last_day)
            create(:quotation, currency_code: currency)
            
            get '/variation', params: {
                    'currency_code' => currency,
                    'moment' => moment
                }
        end

        it 'returns currency variation of last day' do
            expect(json_body[:variation_data][:variation]).to eq(@expectedVariation)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end

    end

    describe 'get currency variation of last week' do
        before do
            before_last_week = Date.current.last_month.beginning_of_month
            whithin_last_week = Date.current.last_week.beginning_of_week

            openingPrice = Faker::Number.number(7).to_i
            closePrice = Faker::Number.number(7).to_i

            @expectedVariation = ((closePrice - openingPrice).to_f/openingPrice) * 100

            currency = 'USD'

            moment = 'last_week'
        
            create(:quotation, currency_code: currency, buy: openingPrice, created_at: whithin_last_week.beginning_of_day)
            create(:quotation, currency_code: currency, buy: closePrice, created_at: whithin_last_week.end_of_day)

            create(:quotation, currency_code: currency, created_at: before_last_week)
            create(:quotation, currency_code: currency)
            
            get '/variation', params: {
                    'currency_code' => currency,
                    'moment' => moment
                }
        end

        it 'returns currency variation of last week' do
            expect(json_body[:variation_data][:variation]).to eq(@expectedVariation)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end

    end

    describe 'get currency variation of last month' do
        before do
            before_last_month = Date.current-60
            whithin_last_month = Date.current.last_month.beginning_of_month

            openingPrice = Faker::Number.number(7).to_i
            closePrice = Faker::Number.number(7).to_i

            @expectedVariation = ((closePrice - openingPrice).to_f/openingPrice) * 100

            currency = 'USD'

            moment = 'last_month'
        
            create(:quotation, currency_code: currency, buy: openingPrice, created_at: whithin_last_month.beginning_of_day)
            create(:quotation, currency_code: currency, buy: closePrice, created_at: whithin_last_month.end_of_day)

            create(:quotation, currency_code: currency, created_at: before_last_month)
            create(:quotation, currency_code: currency)
            
            get '/variation', params: {
                    'currency_code' => currency,
                    'moment' => moment
                }
        end

        it 'returns currency variation of last month' do
            expect(json_body[:variation_data][:variation]).to eq(@expectedVariation)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end

    end

    describe 'get yesterday currency variations with empty records' do 
        before do
            get '/variation', params: {
                'currency_code' => 'USD',
                'moment' => 'yesterday'
            }
        end
        it 'should return 204' do
            expect(response).to have_http_status(204)
        end
    end

    describe 'fetch quotations from api' do
        before do
            @before_count = Quotation.count
            get '/fetch_quotations'
        end

        it 'saves quotations after fetch' do
            expect(Quotation.count).not_to eq(@before_count)
        end
            
        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end

    describe 'get last quotations' do
        before do
            before_last_day = Date.current-2
            last_day = Date.current.yesterday.beginning_of_day

            create(:quotation, created_at: before_last_day)
            create(:quotation, created_at: last_day)
            create(:quotation, created_at: last_day)
            create(:quotation, created_at: last_day)
            
            get '/preview'
        end

        it 'returns 3 quotations created from yesterday' do
            expect(json_body[:quotations].count).to eq(3)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end

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