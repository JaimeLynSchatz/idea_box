require './idea'

class IdeaBoxApp < Sinatra::Base
  not_found do
    erb :error
  end

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index
  end

  post '/' do
    idea = Idea.new(params['idea_title'], params['idea_description'])
    idea.save
    redirect '/'
  end

end
