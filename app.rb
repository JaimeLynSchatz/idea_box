require 'bundler'
Bundler.require

class IdeaBoxApp < Sinatra::Base
  get '/' do
    "Hello, world!"
  end

  run! if app_file == $0
end