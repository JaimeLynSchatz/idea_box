class Idea

  attr_reader :title, :description

  def initialize(attributes = {})
    @title = attributes["title"]
    @description = attributes["description"]
  end

end