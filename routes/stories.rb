get '/add_story' do
    erb :add_story
  end

  post '/add_story' do
    redirect '/login' unless session[:user_id]
    story = Story.new
    story.name = params[:name]
    story.email = params[:email]
    story.story =params[:story]
    story.save
    redirect '/redirect_story'
    end
  
  
  get '/redirect_story' do
    erb :redirect_story
  end

get '/stories/:id' do
    redirect '/login' if session[:user_id]== nil
    #redirect '/login' unless session[:user_id]#reversed if 
    @story = Story.find(params[:id])
  erb :show
  end
  get '/stories/:id/edit' do
    @story = Story.find(params[:id])
  
    erb :edit
  end

put '/stories/:id' do
    story = Story.find(params[:id]) 
    story.name = params[:name]
    story.email = params[:email]
    story.story = params[:story]
    story.save
    redirect"/stories/#{story.id}"
    end
    
delete "/stories/:id" do
    story = Story.find(params[:id])
    story.destroy
    redirect '/stories'
 end