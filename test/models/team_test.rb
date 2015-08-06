require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  def setup
    @alice = build(:alice)
    @sally = build(:sally)
    @jane = build(:jane)
    @team = Team.new(offense: @alice, defense: @sally)
  end

  def test_equality
    assert(@team.eql?(Team.new(offense: @alice, defense: @sally)))
    refute(@team.eql?(Team.new(offense: @sally, defense: @alice)))
  end

  def test_include_player
    assert(@team.include_player?(@alice))
    assert(@team.include_player?(@sally))
    refute(@team.include_player?(@jane))
  end

  def test_position
    assert_equal(:offense, @team.position(@alice))
    assert_equal(:defense, @team.position(@sally))
    assert_nil(@team.position(@jane))
  end
end
