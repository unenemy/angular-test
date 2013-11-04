class ApiGet::ModelsController < ApiGet::BaseController
  def index
    respond_with client.get_models(params[:year_id], params[:make_id])
  end
end