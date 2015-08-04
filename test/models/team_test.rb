require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  def test_eql
    team = Team.new(build(:alice), build(:sally))
    assert(team.eql?(Team.new(build(:alice), build(:sally))))
    refute(team.eql?(Team.new(build(:sally), build(:alice))))
  end
end
