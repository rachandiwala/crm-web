require 'sinatra'     # Include Sinatra Library
require './rolodex'   # Include rolodex.rb, which is in curretn Directory
require 'data_mapper' # Translate Ruby code into SQL to talk to database


DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Contact
  Include DataMapper::Resource

  attr_accessor :id, :first_name, :last_name, :email, :note

  def initialize (id, first_name, last_name, email, note)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @email = email
    @note = note
  end

end


$rolodex = Rolodex.new              #create a global Class var to have access to Sinatra


get '/'  do                         # root path/URL
  @title = "My CRM Application"     # Create an Instence Var and set it equal to string "my crm"
  erb :index                        # Include/look into Views Directory for .erb file called index.erb
end

get "/contacts" do                  # get/Show path/URL /contacts
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


# Above is the old Code from Jan 27 to Jan 29 HTML & CSS
# Code below code is newly added code: HTML & FORMS



# A route to find and display contact by user id, in this case is 1000

get "/contacts/1000"  do
    @contact = $rolodex.find(1000)

    erb :show_contact
  end


# A route to find and dispaly contact using ids of any user, in this case the :id var stores the users ID

get "/contacts/:id" do
    @contact = $rolodex.find(params[:id].to_i)

      if @contact
    erb :show_contact
      else
        raise Sinatra::NotFound   #raise basically return an error 
      end
  end


# This route is used to display the edit form
# To access, creat a contact first than goto: localhost/1000/edit
post "/contacts/:id/edit" do

  erb :edit_contact
end


get "/contacts/:id/edit" do
  @contact = $rolodex.find(params[:id].to_i)
    if @contact 
      erb :edit_contact
    else
      raise Sinatra::NotFound
    end
  end


put "/contacts/:id" do
  @contact =$rolodex.find(params[:id].to_i)
  if @contact
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.note = params[:note]

    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
  end


# A route to delete a contact/user
  delete "/contacts/:id" do
    @contact = $rolodex.find(params[:id].to_i)

    if @contact
      $rolodex.remove_contact(@contact)
      redirect to("/contacts")
    else
      raise Sinatra::NotFound
    end
  end



