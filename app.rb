require './idea'

class IdeaBoxApp < Sinatra::Base
  # allows us to override verbs
  set :method_override, true
  
  # replaces 404 file to include useful params for debugging
  not_found do
    erb :error
  end

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index, locals: {ideas: Idea.all}
  end

  post '/' do
    idea = Idea.new(params['idea_title'], params['idea_description'])
    idea.save
    redirect '/'
  end

  delete '/:id' do |id|
    "DELETING an idea!"
  end
end
