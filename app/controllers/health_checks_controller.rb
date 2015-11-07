class HealthChecksController < ApplicationController
  skip_before_action :setup_request, only: [:create, :update, :destroy]
  before_action :method_not_allowed, only: [:create, :update, :destroy]

  def heart_beats
    http_status_code = :service_unavailable
    http_status_code = :ok if HealthCheck.current_status.all_up?
    head http_status_code
  end

  private

  def method_not_allowed
    head :method_not_allowed
  end
end
