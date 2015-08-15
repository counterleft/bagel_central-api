class StatusService
  def self.status_check
    services = false
    services = true unless Bagel.first.nil? || Player.first.nil?
    Status.new(services: services)
  end
end
