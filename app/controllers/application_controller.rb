
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override, true
  end

  get '/' do

  end

  get '/articles/new' do
    #@article = Article.new
    erb :new
  end

  post '/articles' do
    @article = Article.new(params)
    if @article.save
      redirect "/articles/#{@article.id}"
    else
      redirect "/todos/new"
    end
    erb :show
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/:id' do
    @article = Article.find_by_id(params[:id])

    if @article
      erb :show
    else
      redirect '/articles'
    end
  end

  get '/articles/:id/edit' do
    @article = Article.find(params["id"])


    erb :edit
  end

  patch '/articles/:id' do
     #article = Article.find(id: params[:id])
     #article.title = params[:title]
     #article.content = params[:content]
     #article.update(params)
     #article.save
     id = params["id"]
     new_params = {}
     old_article = Article.find(id)
     new_params[:title] = params["title"]
     new_params[:content] = params["content"]
     old_article.update(new_params)

     redirect "/articles/#{id}"

    #erb :show
   end


  delete '/article/:id/delete' do
    @article = Article.find_by_id(params[:id])
    @article.destroy
    redirect to("/articles")

    erb :show
  end


end
