require "test_helper"

class TeamServiceTest < ActiveSupport::TestCase
  def test_find_teams_for_invalid_player_id
    assert_raises(ArgumentError, "negative id") {
      TeamService.find_teams_for(-1)
    }

    assert_raises(ArgumentError, "zero") {
      TeamService.find_teams_for(0)
    }
  end

  def test_find_teams_for_player_with_no_bagels
    player = create(:player)
    actual = TeamService.find_teams_for(player.id)

    assert(actual.empty?)
  end

  def test_find_teams_for_player_id
    player = build(:alice)
    actual = TeamService.find_teams_for(player.id)

    refute(actual.empty?)
    actual.each do |team|
      assert(team.offense == player || team.defense == player)
      refute(team.offense == player && team.defense == player)
    end
  end
end
