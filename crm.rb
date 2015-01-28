require 'sinatra'
require './rolodex'
require './contact'

$rolodex = Rolodex.new    #create a global var

get '/'  do
  @crm_name = "My CRM"
  erb :index
end

get "/contacts" do
  @contacts = $rolodex.contacts
  erb :contacts
end

get '/contacts/new' do
  erb :new_contact
end

post '/contacts' do
  contact = Contact.new(params[:id], params[:first_name], params[:last_name], params[:email], params[:note])
  $rolodex.add_contact(contact)
  redirect to('/contacts')
end
