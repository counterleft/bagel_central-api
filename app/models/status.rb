require 'securerandom'

class Status
  attr_reader :id

  def initialize(services: false)
    @id = SecureRandom.uuid
    @services = services
  end

  def services_up?
    @services
  end

  def all_up?
    services_up?
  end
end
