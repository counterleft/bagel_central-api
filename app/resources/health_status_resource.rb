class HealthStatusResource < JSONAPI::Resource
  attribute :services

  key_type :uuid

  def self.find_by_key(_key, options = {})
    context = options[:context]
    model = HealthStatus.current_status
    new(model, context)
  end

  def services
    status = 'down'
    status = 'up' if @model.services_up?
    status
  end
end
