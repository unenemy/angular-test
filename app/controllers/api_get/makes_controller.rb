class ApiGet::MakesController < ApiGet::BaseController
  def index
    respond_with client.get_makes(params[:year_id])
  end
end