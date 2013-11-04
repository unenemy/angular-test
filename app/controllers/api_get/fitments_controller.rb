class ApiGet::FitmentsController < ApiGet::BaseController
  def index
    respond_with client.get_vehicle_fitments(params[:year_id], params[:make_id], params[:model_id], params[:option_id])
  end
end