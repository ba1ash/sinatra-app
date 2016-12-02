require 'spec_helper'

describe "Acounts application" do
  describe 'GET /, /accounts' do
    before do
      Account.create(
        email: 'email@gmail.com',
        name: 'user',
        password: '12345'
      )
    end

    it "renders accounts list" do
      get '/'

      expect(last_response.body).to match 'Accounts'
      expect(last_response.body).to match 'email@gmail.com'
      expect(last_response.body).to match 'user'
    end
  end
  describe 'GET /accounts/new' do
    it 'renders account creation form' do
      get '/accounts/new'

      %w(Email Name Password).each do |label|
        expect(last_response.body).to match label
      end
      %w(type="email" type="submit" type="text" type="password").each do |input|
        expect(last_response.body).to match input
      end
    end
  end
  describe 'POST /accounts' do
    it 'is responsible for creating accounts' do
      expect(Account.count).to eq 0

      post '/accounts', { email: 'email@gmail.com', name: 'Name', password: '12345' }

      created_account = Account.first
      expect(created_account.email).to eq 'email@gmail.com'
      expect(created_account.name).to eq 'Name'
      expect(created_account.password).to eq '12345'
    end

  end
  describe 'GET /accounts/:id/delete' do
    before do
      Account.create(
        email: 'email@gmail.com',
        name: 'user',
        password: '12345'
      )
    end

    it 'is responsible for deleting accounts by id' do
      expect(Account.count).to eq 1
      account_id = Account.first.id
      get "/accounts/#{account_id}/delete"

      expect(Account.count).to eq 0
    end
  end
end
