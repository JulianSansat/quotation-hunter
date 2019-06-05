require 'rails_helper'

RSpec.describe Currency, type: :model do
  let(:currency) { build(:currency) }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :code }
  it { is_expected.to validate_presence_of :symbol }


  it { is_expected.to respond_to(:name) }
  it { is_expected.to respond_to(:code) }
  it { is_expected.to respond_to(:symbol) }
  it { is_expected.to respond_to(:logo_url) }
end
