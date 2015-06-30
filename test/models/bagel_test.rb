require "test_helper"

class BagelTest < ActiveSupport::TestCase
  def test_players_must_be_unique
    duplicate_player = create(:duplicate_player)

    refute build(:bagel, owner: duplicate_player, teammate: duplicate_player).valid?, "owner & teammate"
    refute build(:bagel, owner: duplicate_player, offensive_opponent: duplicate_player).valid?, "owner & offensive opponent"
    refute build(:bagel, owner: duplicate_player, defensive_opponent: duplicate_player).valid?, "owner & defensive opponent"
    refute build(:bagel, teammate: duplicate_player, offensive_opponent: duplicate_player).valid?, "teammate & offensive opponent"
    refute build(:bagel, teammate: duplicate_player, defensive_opponent: duplicate_player).valid?, "teammate & defensive opponent"
    refute build(:bagel, offensive_opponent: duplicate_player, defensive_opponent: duplicate_player).valid?, "offensive opponent & defensive opponent"
  end
end
