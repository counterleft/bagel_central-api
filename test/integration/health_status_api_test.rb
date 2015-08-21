require "test_helper"
require 'minitest/mock'

class HealthStatusApiTest < ActionDispatch::IntegrationTest
  def test_get_statuses
    get '/health-statuses'

    assert_response 200

    actual = ActiveSupport::JSON.decode(@response.body)
    assert_not_nil(actual['data']['id'])
    assert_equal('health-statuses', actual['data']['type'])
    assert_equal('up', actual['data']['attributes']['services'])
  end

  def test_cannot_create_status
    post '/health-statuses', {}, { 'content-type': 'application/vnd.api+json' }
    assert_response 405
  end

  def test_cannot_update_status
    patch '/health-statuses', {}, { 'content-type': 'application/vnd.api+json' }
    assert_response 405
  end

  def test_cannot_delete_status
    delete '/health-statuses'
    assert_response 405
  end

  def test_bagels_service_down
    Bagel.stub :first, nil do
      get '/health-statuses'

      assert_response 200

      actual = ActiveSupport::JSON.decode(@response.body)
      assert_not_nil(actual['data']['id'])
      assert_equal('health-statuses', actual['data']['type'])
      assert_equal('down', actual['data']['attributes']['services'])
    end
  end

  def test_players_service_down
    Player.stub :first, nil do
      get '/health-statuses'

      assert_response 200

      actual = ActiveSupport::JSON.decode(@response.body)
      assert_not_nil(actual['data']['id'])
      assert_equal('health-statuses', actual['data']['type'])
      assert_equal('down', actual['data']['attributes']['services'])
    end
  end

  def test_heartbeats
    get '/health-statuses/heartbeats'
    assert_response 200
  end

  def test_services_down_heartbeats_fail
    Player.stub :first, nil do
      get '/health-statuses/heartbeats'
      assert_response 503
    end

    Bagel.stub :first, nil do
      get '/health-statuses/heartbeats'
      assert_response 503
    end
  end
end
