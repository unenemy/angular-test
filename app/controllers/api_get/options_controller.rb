class ApiGet::OptionsController < ApiGet::BaseController
  def index
    respond_with client.get_options(params[:year_id], params[:make_id], params[:model_id])
  end
end