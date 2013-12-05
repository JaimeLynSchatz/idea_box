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

  get '/:id/edit' do |id|
    idea = Idea.find(id.to_i)
    # call up the erb view and send it these local variables to work with
    erb :edit, locals: {id: id, idea: idea}
  end

  put '/:id' do |id|
    # update the idea in the database
    Idea.update(id.to_i, params[:idea])
    #redirect to the index page
    redirect '/'
  end

  post '/' do
    idea = Idea.new(params[:idea])
    idea.save
    redirect '/'
  end

  delete '/:id' do |id|
    Idea.delete(id.to_i)
    redirect '/'
    "DELETING an idea!"
  end
end
