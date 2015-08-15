require 'test_helper'
require 'minitest/mock'

class StatusServiceTest < ActiveSupport::TestCase
  def test_status_is_up
    assert(StatusService.status_check.services_up?, 'services up?')
  end

  def test_status_is_down_because_services_down
    Bagel.stub :first, nil do
      refute(StatusService.status_check.services_up?, 'services up?')
    end

    Player.stub :first, nil do
      refute(StatusService.status_check.services_up?, 'services up?')
    end
  end
end
