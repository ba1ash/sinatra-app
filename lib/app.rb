require 'sinatra'
require 'active_record'
require 'sinatra/activerecord'
require 'slim'

require_relative 'models/account'

get %r{^(/|/accounts)$} do
  @accounts = Account.all
  slim :'accounts/index'
end

get '/accounts/new' do
  slim :'accounts/new'
end

post '/accounts' do
  Account.create(
    email: params[:email],
    name: params[:name],
    password: params[:password]
  )
  redirect to('/accounts')
end

get '/accounts/:id/delete' do
  Account.delete(params[:id])
  redirect to('/accounts')
end
