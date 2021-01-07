require './lib/exhibit'
require './lib/patron'

class Museum
  attr_reader :name,
              :exhibits

  def initialize(name)
    @name = name
    @exhibits = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    recommend_exhibits_list = []
    exhibits.each do |exhibit|
      if patron.interests.include?(exhibit.name)
        recommend_exhibits_list << exhibit
      end
    end
    recommend_exhibits_list
  end

end
