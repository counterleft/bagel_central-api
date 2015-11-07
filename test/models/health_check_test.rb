class HealthCheckTest < ActiveSupport::TestCase
  def test_status_is_up
    assert(HealthCheck.current_status.services_up?, 'services up?')
  end

  def test_status_is_down_because_services_down
    Bagel.stub :first, nil do
      actual = HealthCheck.current_status
      refute(actual.services_up?, 'services up?')
      refute(actual.all_up?)
    end

    Player.stub :first, nil do
      actual = HealthCheck.current_status
      refute(actual.services_up?, 'services up?')
      refute(actual.all_up?)
    end
  end

  def test_id_is_not_nil
    refute_nil(HealthCheck.new.id)
  end
end
