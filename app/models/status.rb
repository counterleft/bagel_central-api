require 'securerandom'

class Status
  attr_reader :id

  def self.current_status
    services_available = (Bagel.first.nil? || Player.first.nil?) ? false : true
    new(services: services_available)
  end

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
