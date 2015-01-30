require 'sinatra'     # Include Sinatra Library
require './rolodex'   # Include rolodex.rb, which is in curretn Directory
require './contact'   # Include contact.rb also in the the current Dirctory

$rolodex = Rolodex.new    #create a global Class var to have access to Sinatra

$rolodex.add_contact(Contact.new("Johnny", "Bravo", "Johnny@bitmakerlabs.com", "Rockstar"))

# A route that coresponds with the above user
# A route to find and display the contact

get "/contacts/1000"  do
    @contact = $rolodex.find(1000)

    erb :show_contact
  end


# Above code is newly added code: HTML FORMS
# Bottom is the old Code from Jan 27 to Jan 29 HTML & CSS

get '/'  do               # root path/URL
  @title = "My CRM Application"    # Create an Instence Var and set it equal to string "my crm"
  erb :index              # Include/look into Views Directory for .erb file called index.erb
end

get "/contacts" do        # get/Show path/URL /contacts
  @contacts = $rolodex.contacts     # Create an instence @contacts and set it = to 
  erb :contacts
end

get '/contacts/new' do
  erb :new_contact
end

post '/contacts' do
  new_contact = Contact.new(params[:id], params[:first_name], params[:last_name], params[:email], params[:note])
  $rolodex.add_contact(new_contact)
  redirect to('/contacts')
end

