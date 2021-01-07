require 'minitest/autorun'
require 'minitest/pride'
require './lib/exhibit'
require './lib/patron'
require './lib/museum'

class MuseumTest < Minitest::Test
  def test_it_exists_and_has_attributes
    dmns = Museum.new("Denver Museum of Nature and Science")

    assert_instance_of Museum, dmns
    assert_equal "Denver Museum of Nature and Science", dmns.name
    assert_equal [], dmns.exhibits
  end

  def test_add_exhibit_adds_exhibit
    dmns = Museum.new("Denver Museum of Nature and Science")

    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    assert_equal [gems_and_minerals, dead_sea_scrolls, imax], dmns.exhibits
  end

  def test_recommended_exhibits_recommends_patron_interest_exhibits
    dmns = Museum.new("Denver Museum of Nature and Science")

    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    patron_1 = Patron.new("Bob", 20)

    patron_1.add_interest("Dead Sea Scrolls")
    patron_1.add_interest("Gems and Minerals")

    patron_2 = Patron.new("Sally", 20)

    patron_2.add_interest("IMAX")

    expected_1 = [gems_and_minerals, dead_sea_scrolls]

    assert_equal expected_1, dmns.recommend_exhibits(patron_1)

    expected_2 = [imax]

    assert_equal expected_2, dmns.recommend_exhibits(patron_2)
  end

  def test_admit_takes_any_patron
    dmns = Museum.new("Denver Museum of Nature and Science")

    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})

    patron_1 = Patron.new("Bob", 0)

    patron_1.add_interest("Gems and Minerals")
    patron_1.add_interest("Dead Sea Scrolls")

    patron_2 = Patron.new("Sally", 20)

    patron_2.add_interest("Dead Sea Scrolls")

    patron_3 = Patron.new("Johnny", 5)

    patron_3.add_interest("Dead Sea Scrolls")

    dmns.admit(patron_1)
    dmns.admit(patron_2)
    dmns.admit(patron_3)

    expected = [patron_1, patron_2, patron_3]

    assert_equal expected, dmns.patrons
  end

  def test_patrons_exhibit_by_interest_displays_exhibits_with_patrons_interested
    dmns = Museum.new("Denver Museum of Nature and Science")

    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    dmns.patrons

    patron_1 = Patron.new("Bob", 0)

    patron_1.add_interest("Gems and Minerals")
    patron_1.add_interest("Dead Sea Scrolls")

    patron_2 = Patron.new("Sally", 20)

    patron_2.add_interest("Dead Sea Scrolls")

    patron_3 = Patron.new("Johnny", 5)

    patron_3.add_interest("Dead Sea Scrolls")

    dmns.admit(patron_1)
    dmns.admit(patron_2)
    dmns.admit(patron_3)

    expected = {gems_and_minerals => [patron_1], dead_sea_scrolls => [patron_1, patron_2, patron_3], imax => []}

    assert_equal expected, dmns.patrons_by_exhibit_interest
  end

  def test_ticket_lottery_contestants
    dmns = Museum.new("Denver Museum of Nature and Science")

    gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
    dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
    imax = Exhibit.new({name: "IMAX",cost: 15})

    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    dmns.patrons

    patron_1 = Patron.new("Bob", 0)

    patron_1.add_interest("Gems and Minerals")
    patron_1.add_interest("Dead Sea Scrolls")

    patron_2 = Patron.new("Sally", 20)

    patron_2.add_interest("Dead Sea Scrolls")

    patron_3 = Patron.new("Johnny", 5)

    patron_3.add_interest("Dead Sea Scrolls")

    dmns.admit(patron_1)
    dmns.admit(patron_2)
    dmns.admit(patron_3)

    expected = [patron_1, patron_3]

    assert_equal expected, dmns.ticket_lottery_contestants(dead_sea_scrolls)
  end
end

# dmns = Museum.new("Denver Museum of Nature and Science")
# # => #<Museum:0x00007fb20205d690...>
#
# gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
# # => #<Exhibit:0x00007fb202238618...>
#
# dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
# # => #<Exhibit:0x00007fb202248748...>
#
# imax = Exhibit.new({name: "IMAX",cost: 15})
# # => #<Exhibit:0x00007fb20225f8d0...>
#
# dmns.add_exhibit(gems_and_minerals)
#
# dmns.add_exhibit(dead_sea_scrolls)
#
# dmns.add_exhibit(imax)
#
# dmns.patrons
# # => []
#
# patron_1 = Patron.new("Bob", 0)
# # => #<Patron:0x00007fb2011455b8...>
#
# patron_1.add_interest("Gems and Minerals")
#
# patron_1.add_interest("Dead Sea Scrolls")
#
# patron_2 = Patron.new("Sally", 20)
# # => #<Patron:0x00007fb20227f8b0...>
#
# patron_2.add_interest("Dead Sea Scrolls")
#
# patron_3 = Patron.new("Johnny", 5)
# # => #<Patron:0x6666fb20114megan...>
#
# patron_3.add_interest("Dead Sea Scrolls")
#
# dmns.admit(patron_1)
#
# dmns.admit(patron_2)
#
# dmns.admit(patron_3)
#
# dmns.patrons
# # => [#<Patron:0x00007fb2011455b8...>, #<Patron:0x00007fb20227f8b0...>, #<Patron:0x6666fb20114megan...>]
#
# #Patrons are added even if they don't have enough money for all/any exhibits.
#
# dmns.patrons_by_exhibit_interest
# # =>
# # {
# #   #<Exhibit:0x00007fb202238618...> => [#<Patron:0x00007fb2011455b8...>],
# #   #<Exhibit:0x00007fb202248748...> => [#<Patron:0x00007fb2011455b8...>, #<Patron:0x00007fb20227f8b0...>, #<Patron:0x6666fb20114megan...>],
# #   #<Exhibit:0x00007fb20225f8d0...> => []
# # }
#
# dmns.ticket_lottery_contestants(dead_sea_scrolls)
# # => [#<Patron:0x00007fb2011455b8...>, #<Patron:0x6666fb20114megan...>]
#
# dmns.draw_lottery_winner(dead_sea_scrolls)
# # => "Johnny" or "Bob" can be returned here. Fun!
#
# dmns.draw_lottery_winner(gems_and_minerals)
# # => nil
#
# #If no contestants are elgible for the lottery, nil is returned.
#
# dmns.announce_lottery_winner(imax)
# # => "Bob has won the IMAX edhibit lottery"
#
# # The above string should match exactly, you will need to stub the return of `draw_lottery_winner` as the above method should depend on the return value of `draw_lottery_winner`.
#
# dmns.announce_lottery_winner(gems_and_minerals)
# # => "No winners for this lottery"
