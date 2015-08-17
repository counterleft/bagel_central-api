require "test_helper"

class TeamMakerTest < ActiveSupport::TestCase
  def test_find_teams_for_invalid_player_id
    assert_raises(ArgumentError, "negative id") {
      TeamMaker.find_teams_for(-1)
    }

    assert_raises(ArgumentError, "zero") {
      TeamMaker.find_teams_for(0)
    }
  end

  def test_find_teams_for_player_with_no_bagels
    player = create(:player)
    actual = TeamMaker.find_teams_for(player.id)

    assert(actual.empty?)
  end

  def test_find_teams_for_player_id
    player = build(:alice)
    actual = TeamMaker.find_teams_for(player.id)

    refute(actual.empty?)
    actual.each do |team|
      assert(team.include_player?(player))
      assert_equal(:defense, team.position(player))
      refute(team.offense == player && team.defense == player)
    end
  end
end
