class ApiGet::YearsController < ApiGet::BaseController
  respond_to :json

  def index
    respond_with client.get_years
  end
end