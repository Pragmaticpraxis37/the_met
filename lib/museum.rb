require './lib/exhibit'
require './lib/patron'

class Museum
  attr_reader :name,
              :exhibits,
              :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
    @lottery_contestants = []
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

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_exhibit_interest
    exhibit_interest = {}
    exhibits.each do |exhibit|
      patrons.each do |patron|
        patron.interests.each do |interest|
          if exhibit.name == interest
            if exhibit_interest[exhibit].nil?
              exhibit_interest[exhibit] = [patron]
            else
              exhibit_interest[exhibit] << patron
            end
          end
        end
      end
    end
    exhibit_interest
  end

  def ticket_lottery_contestants(exhibit)
    contestants = []
    patrons.each do |patron|
      if patron.spending_money < exhibit.cost
        contestants << patron
      end
    end
    contestants
  end
end
