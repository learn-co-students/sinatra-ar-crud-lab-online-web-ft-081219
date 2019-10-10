
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do

  end

  get '/articles/new' do
    @article = Article.create
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
      #erb :show
    else
      redirect '/articles'
    end
  end

  get '/articles/:id/edit' do
    @article = Article.find_by(params[:id])


    erb :edit
  end

  patch '/articles/:id' do
     article = Article.find_by(params[:id])
     article.title = params[:title]
     article.content = params[:content]
     article.save
     redirect to "/articles/#{ params[:id] }"
   end


  get '/articles/:id/delete' do
    @article = Article.delete(params[:id])
    redirect to("/articles")

    erb :delete
  end


end
