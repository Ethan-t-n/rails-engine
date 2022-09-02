require 'rails_helper'

# RSpec.describe "Merchant API requests" do
#   it "gets all merchants" do
#     create_list(:merchant, 5)

#     get "/api/v1/merchants"

#     expect(response).to be_successful

#     merchants = JSON.parse(response.body, symbolize_names: true)[:data]
    
#     expect(merchants.count).to eq(5)

#     merchants.each do |merchant|
#       expect(merchant[:attributes]).to have_key(:name)
#       expect(merchant[:attributes][:name]).to be_a(String)
#     end
#   end

#   it "finds one merchant" do
#     id = create(:merchant).id

#     get "/api/v1/merchants/#{id}"

#     expect(response).to be_successful

#     merchant = JSON.parse(response.body, symbolize_names: true)
    
#     expect(merchant.count).to eq(1)

#     expect(merchant[:data][:attributes]).to have_key(:name)
#     expect(merchant[:data][:attributes][:name]).to be_a(String)
#   end

#   it "finds one merchant's items" do
#     id = create(:merchant).id
#     items = create_list(:item, 10, merchant_id: id)

#     get "/api/v1/merchants/#{id}/items"

#     expect(response).to be_successful

#     items = JSON.parse(response.body, symbolize_names: true)[:data]

#     expect(items.count).to eq(10)
    
#     items.each do |item|
#       expect(item[:attributes]).to have_key(:name)
#       expect(item[:attributes][:name]).to be_a(String)
      
#       expect(item[:attributes]).to have_key(:description)
#       expect(item[:attributes][:description]).to be_a(String)
      
#       expect(item[:attributes]).to have_key(:unit_price)
#       expect(item[:attributes][:unit_price]).to be_a(Float)
      
#       expect(item[:attributes]).to have_key(:merchant_id)
#       expect(item[:attributes][:merchant_id]).to be_an(Integer)
#     end
#   end

#   it "returns 404 if merchant not found" do
#     get "/api/v1/merchants/1234567/items"
#     expect(response.status).to eq(404)
    
#     get "/api/v1/merchants/1234567"
#     expect(response.status).to eq(404)
    
#     get "/api/v1/merchants"
#     expect(response.status).to eq(404)
#   end

#   it "can find merchants by searching with query params" do
#     merchant_1 = create(:merchant, name: "pencil Store")
#     merchant_2 = create(:merchant, name: "Pen Store")

#     get "/api/v1/merchants/find?name=ducky"

#     expect(response).to be_successful
#     merchant = JSON.parse(response.body, symbolize_names: true)[:data]

#     expect(merchant[:attributes][:name]).to eq(merchant_1.name)
#   end
  
#   it "returns a message if no match found" do
#     merchant_1 = create(:merchant, name: "Pencil Store")
#     merchant_2 = create(:merchant, name: "Pen Store")

#     get "/api/v1/merchants/find?name=squiggly_piggly"

#     message = JSON.parse(response.body, symbolize_names: true)
#     expect(message).to have_key(:data)
#     expect(message[:data][:message]).to eq("No match found")
#   end

#   it "finds all merchants by name fragment" do
#     merchant_1 = create(:merchant, name: "Pencil Store")
#     merchant_2 = create(:merchant, name: "Feather Pen Store")
#     merchant_3 = create(:merchant, name: "Mechanical Pencil Store")
#     merchant_4 = create(:merchant, name: "Broken Pencil Store")

#     get "/api/v1/merchants/find_all?name=dU"

#     expect(response).to be_successful

#     merchants = JSON.parse(response.body, symbolize_names: true)[:data]
    
#     expect(merchants.count).to eq(3)

#     merchants.each do |merchant|
#       expect(merchant[:attributes]).to have_key(:name)
#       expect(merchant[:attributes][:name]).to be_a(String)
#     end
#   end
# end

# RSpec.describe "Merchants API Requests" do

#   describe 'Sends a List of Merchants' do
#     it 'sends a list of all merchants' do
#       create_list(:merchant, 5)

#       get '/api/v1/merchants'
      
#       merchants = JSON.parse(response.body, symbolize_names: true)
#       expect(response).to be_successful
#       expect(merchants).to have_key(:data)

#       merchants[:data].each do |merchant|
#         expect(merchant).to have_key(:id)
#         expect(merchant[:id]).to be_a String

#         expect(merchant[:attributes]).to have_key(:name)
#         expect(merchant[:attributes][:name]).to be_a String
#       end 

#       expect(merchants[:data].count).to eq(Merchant.all.count)
#     end 

#     it 'can get one merchant by its id' do
#       id = create(:merchant).id 

#       get "/api/v1/merchants/#{id}"

#       expect(response).to be_successful
      
#       merchant = JSON.parse(response.body, symbolize_names: true)[:data]
#       expect(merchant).to have_key(:id)
#       expect(merchant[:id]).to be_a String
      
#       expect(merchant).to have_key(:type)
#       expect(merchant[:type]).to eq('merchant')

#       expect(merchant[:attributes]).to have_key(:name)
#       expect(merchant[:attributes][:name]).to be_a String

#     end 

#   end 

# end 


describe 'Merchants API' do
  let!(:merchants) { create_list(:merchant, 3) }
  # let!(:merchants) { id = create(:merchant).id }
  it 'has a list of all merchants' do

    get '/api/v1/merchants'

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchants = response_body[:data]

    expect(merchants.count).to eq(3)

    merchants.each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes][:name]).to be_a(String)
      expect(merchant[:attributes]).to_not have_key(:created_at)
    end
  end

  it 'can get one merchant by its ID' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant = response_body[:data]

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_a(String)

    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes][:name]).to be_a(String)

    expect(merchant[:attributes]).to_not have_key(:created_at)
  end

  it 'returns error if no merchant is found by ID' do
    id = 4164616

    get "/api/v1/merchants/#{id}"

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant = response_body[:data]

    expect(response).to have_http_status(404)
  end

  it 'shows all items from the merchant' do
    id = create(:merchant).id
    create_list(:item, 5, merchant_id: id)

    get "/api/v1/merchants/#{id}/items"

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant_items = response_body[:data]

    expect(response).to be_successful

    merchant_items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to be_a(String)
      expect(item[:type]).to eq('item')

      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_a(Hash)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
      expect(item[:attributes]).to_not have_key(:created_at)
    end
  end

  it 'shows a message if no merchant matches search by name' do

    search_name = 'lotr'

    get "/api/v1/merchants/find?name=#{search_name}"

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant = response_body[:data]

    expect(merchant).to eq({:message => 'Merchant not found'})
  end

  it 'returns 404 if search by name is empty' do

    search_name = ''

    get "/api/v1/merchants/find?name=#{search_name}"

    expect(response).to_not be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant = response_body[:data]

    expect(merchant).to eq({})
  end
end