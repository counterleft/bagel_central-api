class PlayerResource < JSONAPI::Resource
  attributes :name, :surname, :created_at, :updated_at, :active, :plus_minus
  attribute :full_name

  def full_name
    if @model.surname
      "#{@model.name} #{@model.surname}"
    else
      @model.name
    end
  end

  def self.updatable_fields(context)
    super - [:full_name, :created_at, :updated_at, :plus_minus]
  end

  def self.creatable_fields(context)
    super - [:full_name, :created_at, :updated_at, :plus_minus, :active]
  end
end
