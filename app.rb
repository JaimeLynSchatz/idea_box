class IdeaBoxApp < Sinatra::Base
  get '/' do
    erb :index
  end
end
