require "test_helper"

class BagelTest < ActiveSupport::TestCase
  def test_players_must_be_unique
    duplicate_player = create(:duplicate_player)

    refute build(:bagel, owner: duplicate_player, teammate: duplicate_player).valid?, "duplicate owner & teammate"
    refute build(:bagel, owner: duplicate_player, opponent_1: duplicate_player).valid?, "duplicate owner & opponent 1"
    refute build(:bagel, owner: duplicate_player, opponent_2: duplicate_player).valid?, "duplicate owner & opponent 2"
    refute build(:bagel, teammate: duplicate_player, opponent_1: duplicate_player).valid?, "duplicate teammate & opponent 1"
    refute build(:bagel, teammate: duplicate_player, opponent_2: duplicate_player).valid?, "duplicate teammate & opponent 2"
    refute build(:bagel, opponent_1: duplicate_player, opponent_2: duplicate_player).valid?, "duplicate opponent_1 & opponent 2"
  end
end
