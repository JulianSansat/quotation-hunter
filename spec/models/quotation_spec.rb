require 'rails_helper'

RSpec.describe Quotation, type: :model do
  let(:quotation) { build(:quotation) }

  it { is_expected.to validate_presence_of :currency_code }
  it { is_expected.to validate_presence_of :buy }


  it { is_expected.to respond_to(:currency_code) }
  it { is_expected.to respond_to(:buy) }
  it { is_expected.to respond_to(:sell) }
end
