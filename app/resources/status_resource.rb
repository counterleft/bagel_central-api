class StatusResource < JSONAPI::Resource
  attribute :services

  def self.verify_key(key, _context = nil)
    key && String(key)
  end

  def self.find_by_key(_key, options = {})
    context = options[:context]
    model = StatusService.status_check
    new(model, context)
  end

  def services
    status = 'down'
    status = 'up' if @model.services_up?
    status
  end
end
