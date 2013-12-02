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
    # 1. Create an idea based on the form parameters submitted
    idea = Idea.new
    # 2. Store it
    idea.save
    # 3. Send us back to the index page to see all the ideas
    "Creating an IDEA!"
  end

end
