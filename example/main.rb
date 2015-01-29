require 'sinatra'

get '/' do 
  @time = Time.new.ctime
  @animals = ["Cow", "Bear", "Horse", "dog"]
  @title= "Animals"
  erb :index

end

get '/hello/ :word' do
    @word =params[:word]
    erb :index

  end

get '/about' do
  @title = "about"
    erb :about
  end
