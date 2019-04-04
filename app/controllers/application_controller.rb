
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :method_override, 'true'

  end

  get '/articles/new' do          #NEW ARTICLE FORM
    erb :new
  end

  post '/articles' do            #NEW ARTICLE CREATION AND REDIRECT
    article_title = params[:title]
    article_content = params[:content]
    @article = Article.create(title: article_title, content: article_content)
    # binding.pry
    redirect '/articles/' + @article.id.to_s
  end

  get '/' do                     #REDIRECT TO INDEX
    redirect '/articles'
  end

  get '/articles/:id' do          #READ AND SHOW AN ARTICLE
    # binding.pry
    @article = Article.find(params[:id])
    erb :show
  end

  get '/articles' do              #READ AND SHOW ALL ARTICLES
    @all_articles = Article.all # this 
    # binding.pry

    erb :index
  end

  get '/articles/:id/edit' do     #EDIT FORM FOR AND ARTICLE
    @article = Article.find(params[:id])
    # binding.pry
    erb :edit
  end

  patch '/articles/:id' do       #APPLY AND REDIRECT EDITS TO AN ARTICLE
    @article = Article.find(params[:id])
    # binding.pry
    @article.update(params[:article])#   next param then update
    # binding.pry
    redirect '/articles/' + @article.id.to_s
    # redirect to '/articles/' + params[:id].to_s# redirect    
  end

  delete '/articles/:id' do       #APPLY AND REDIRECT EDITS TO AN ARTICLE
    @article = Article.find(params[:id])
    # binding.pry
    Article.delete(params[:id])#   next param then update
    # redirect '/articles/#{params[:id].to_i}'# redirect
    redirect to '/'# redirect to index
  end

end
