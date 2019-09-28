
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # get '/' do
  #   erb :index
  # end
  
  get '/articles' do 
    @articles = Article.all
    erb :index
  end
  
  get '/articles/new' do 
    erb :new
  end
  
  post '/articles' do 
    p params
    @article = Article.create(title: params["title"], content: params["content"]) 
    p @article
    redirect "articles/#{@article.id}"
  end
 
 get '/articles/:id' do 
  # p params
  @article = Article.find(params["id"].to_i)
   erb :show
 end 

 
  get "/articles/:id/edit" do
    @article = Article.find(params["id"].to_i)
    erb :edit
  end
  
  patch  '/articles/:id' do 
    p params["title"]
    @article = Article.find(params["id"].to_i)
    if @article.update(title: params["title"], content: params["content"])
    redirect "/articles/#{@article.id}"
  
    end
end

 
delete '/articles/:id/delete' do 
  @article = Article.find_by_id(params[:id])
  @article.delete
  redirect to '/articles'
end
    
end
