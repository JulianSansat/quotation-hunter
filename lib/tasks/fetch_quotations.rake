# run by doing:
# rake fetch_quotations:fetch
namespace :fetch_quotations do
  desc "Fetch Quotations from API"
  task :fetch => :environment do
    QuotationsFetchService.fetch_quotations
  end
end