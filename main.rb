     
require 'sinatra'
require'sinatra/reloader'
require 'pry'
require_relative 'database_config'
require_relative 'models/user'
require_relative 'models/stories'
require_relative 'models/contact'

Dir.glob('models/*.rb').each do |file|
  require_relative file
end

enable :sessions
get '/login' do
  erb :login
end

post "/session" do
  
  user = User.find_by(email: params[:email])
 
  if user && user.authenticate(params[:password])
      
      session[:user_id] = user.id 
      redirect '/'
   else
      erb :login
  end
  
end
delete '/session' do
  #1.destroy the session
  session[:user_id] = nil
  #2.redirect
  redirect '/login'
end

helpers do
  def logged_in? 
    if current_user
      true
    else 
      false
    end
  end
end

def current_user
  User.find_by(id: session[:user_id])
end
after do 
  ActiveRecord::Base
end

get '/createaccount' do
  erb :createaccount
end

post "/createaccount" do
    user = User.new
    user.name = params[:name]
    user.email = params[:email]
    user.password =params[:password]
    user.save
  # erb :redirect_login
  redirect '/redirect_login'
end

get '/redirect_login' do
  erb :redirect_login
end

get '/' do
  erb :index
end

get '/contact' do
  erb :contact
end


post '/contact' do
  contact = Contact.new
  contact.name = params[:name]
  contact.email = params[:email]
  contact.message =params[:message]
  contact.save
# erb :redirect_login
redirect '/redirect_contact'

end
get '/redirect_contact' do
  erb :redirect_contact
end

get '/about' do
  erb :about
end
get '/mock_test' do
  erb :mock_test
end
get '/testimonal' do
  erb :testimonal
end


get '/success_stories' do
  @stories = Story.all
  erb :success_stories
end
binding.pry
require_relative 'routes/stories'
