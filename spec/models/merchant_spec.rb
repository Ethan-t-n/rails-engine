require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoices) }
    it { should have_many(:customers).through(:invoices) }
  end
  describe 'model methods' do
    describe '#search_merchant' do
      it 'finds merchants by name' do
        create_list(:merchant, 5)

        name_search = Merchant.first.name

        Merchant.search_merchant(name_search).each do |merchant|
          expect(name_search).to eq(merchant.name)
        end
      end

      it 'returns empty if no search matches name' do
        create_list(:merchant, 5)

        name_search = 'lotr'

        Merchant.search_merchant(name_search).each do |merchant|
          expect(name_search).to eq nil
        end
      end
    end
  end
end

