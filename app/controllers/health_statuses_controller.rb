class HealthStatusesController < ApplicationController
  skip_before_action :setup_request, only: [:create, :update, :destroy]
  before_action :method_not_allowed, only: [:create, :update, :destroy]

  def heartbeats
    http_status_code = :service_unavailable
    http_status_code = :ok if HealthStatus.current_status.all_up?
    head http_status_code
  end

  private

  def method_not_allowed
    head :method_not_allowed
  end
end
