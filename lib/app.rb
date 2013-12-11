require 'idea_box'
class IdeaBoxApp < Sinatra::Base
  # allows us to override verbs
  set :method_override, true
  set :root, 'lib/app'
  # replaces 404 file to include useful params for debugging
  not_found do
    erb :error
  end

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index, locals: {ideas: IdeaStore.all, idea: Idea.new}
  end

  get '/:id/edit' do |id|
    idea = IdeaStore.find(id.to_i)
    # call up the erb view and send it these local variables to work with
    erb :edit, locals: {id: id, idea: idea}
  end

  put '/:id' do |id|
    # update the idea in the database
    IdeaStore.update(id.to_i, params[:idea])
    #redirect to the index page
    redirect '/'
  end

  post '/' do
    IdeaStore.create(params[:idea])
    redirect '/'
  end

  delete '/:id' do |id|
    IdeaStore.delete(id.to_i)
    redirect '/'
    "DELETING an idea!"
  end

  post '/:id/like' do |id|
    idea = IdeaStore.find(id.to_i)
    idea.like!
    IdeaStore.update(id.to_i, idea.to_h)
    redirect '/'
  end
end
