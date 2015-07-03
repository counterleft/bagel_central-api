class PlayersController < ApplicationController
  def destroy
    head :method_not_allowed
  end

  def show
    if params["include"] && params["include"].split(",").include?("bagels")
      raise JSONAPI::Exceptions::InvalidInclude.new("players", "bagels")
    end

    super
  rescue => e
    handle_exceptions(e)
  end
end
