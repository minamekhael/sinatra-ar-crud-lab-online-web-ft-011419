require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

    get '/' do
    redirect to "/articles"
  end	

   get '/articles/new' do
  	erb :new
  end

   post '/articles' do
  	Article.create(params)

   	redirect "/articles/#{Article.last[:id]}"
  end

   get '/articles' do
  	@articles = Article.all

   	erb :index
  end

   get '/articles/:id' do
  	@article = Article.find(params[:id])

   	erb :show
  end

  get '/articles/:id/edit' do  #load edit form
    @article = Article.find_by_id(params[:id])
    erb :edit
  end

   patch '/articles/:id' do
  	@article = Article.find(params[:id])
  	@article.title = params[:title]
  	@article.content = params[:content]
  	@article.save

   	redirect to "/articles/#{@article.id}"
  end

   delete '/articles/:id' do
  	@article = Article.find(params[:id])
  	Article.delete(@article.id)

   	@articles = Article.all
  	erb :index
  end

 end	