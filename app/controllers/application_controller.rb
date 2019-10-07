
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/articles/new' do
    erb :new
  end

  post '/articles' do

    article_title = params[:title]
    article_content = params[:content]
    @article = Article.create(title:article_title, content:article_content)
    redirect to "/articles/#{Article.last.id}"
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  patch '/articles/:id' do
    @article = Article.last
    @article.update(title:params[:title])
    @article.update(content:params[:content])
    redirect to "/articles/#{Article.last.id}"
  end

  delete '/articles/:id' do
    @article = Article.last
    @article.destroy
    redirect to '/articles'
  end

end
