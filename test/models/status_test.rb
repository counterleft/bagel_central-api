class StatusTest < ActiveSupport::TestCase
  def test_service_and_all_status
    actual = Status.new(services: true)
    assert(actual.services_up?)
    assert(actual.all_up?)
  end

  def test_service_and_all_status_down
    actual = Status.new
    refute(actual.services_up?)
    refute(actual.all_up?)
  end

  def test_id_is_not_nil
    refute_nil(Status.new.id)
  end
end
