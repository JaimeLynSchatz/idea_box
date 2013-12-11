require 'yaml/store'

class IdeaStore
  def self.delete(position)
      database.transaction do
        database['ideas'].delete_at(position)
      end
  end

  def self.database
      return @database if @database

      @database = YAML::Store.new('db/indeabox')
      @database.transaction do
        @database['ideas'] ||= []
      end
      @database
  end

  def self.find(id)
      raw_idea = find_raw_idea(id)
      Idea.new(raw_idea.merge("id" => id))
  end

  def self.find_raw_idea(id)
      database.transaction do
        database['ideas'].at(id)
      end
  end

  def self.raw_ideas
      database.transaction do |db|
        db['ideas'] || []
      end
  end


  def self.update(id, data)
      database.transaction do
        database['ideas'][id] = data
      end
  end

  def self.all
    ideas = []
    raw_ideas.each_with_index do |data, i|
      ideas << Idea.new(data.merge("id" => i))
    end
    ideas
  end

  def self.create(data)
    database.transaction do
      database['ideas'] << data
    end
  end
end