require 'yaml/store'

class Idea
  def save
    database.transaction do |db|
      db['ideas'] ||= []
      db['ideas'] << {title: 'diet', description: 'pizza all the time'}
    end
  end

  def database
    @database ||= YAML::Store.new "ideabox"
  end
end