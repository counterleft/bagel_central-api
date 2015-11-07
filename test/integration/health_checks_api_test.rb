require "test_helper"
require 'minitest/mock'

class HealthChecksApiTest < ActionDispatch::IntegrationTest
  def test_get_health_checks
    get '/health-checks'

    assert_response 200

    actual = ActiveSupport::JSON.decode(@response.body)
    assert_not_nil(actual['data']['id'])
    assert_equal('health-checks', actual['data']['type'])
    assert_equal('up', actual['data']['attributes']['services'])
  end

  def test_cannot_create_health_checks
    post '/health-checks', {}, { 'content-type': 'application/vnd.api+json' }
    assert_response 405
  end

  def test_cannot_update_health_checks
    patch '/health-checks', {}, { 'content-type': 'application/vnd.api+json' }
    assert_response 405
  end

  def test_cannot_delete_health_checks
    delete '/health-checks'
    assert_response 405
  end

  def test_bagels_service_down
    Bagel.stub :first, nil do
      get '/health-checks'

      assert_response 200

      actual = ActiveSupport::JSON.decode(@response.body)
      assert_not_nil(actual['data']['id'])
      assert_equal('health-checks', actual['data']['type'])
      assert_equal('down', actual['data']['attributes']['services'])
    end
  end

  def test_players_service_down
    Player.stub :first, nil do
      get '/health-checks'

      assert_response 200

      actual = ActiveSupport::JSON.decode(@response.body)
      assert_not_nil(actual['data']['id'])
      assert_equal('health-checks', actual['data']['type'])
      assert_equal('down', actual['data']['attributes']['services'])
    end
  end

  def test_heart_beats
    get '/health-checks/heart-beats'
    assert_response 200
  end

  def test_services_down_heart_beats_fail
    Player.stub :first, nil do
      get '/health-checks/heart-beats'
      assert_response 503
    end

    Bagel.stub :first, nil do
      get '/health-checks/heart-beats'
      assert_response 503
    end
  end
end
