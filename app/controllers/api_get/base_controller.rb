class ApiGet::BaseController < ActionController::Base
  respond_to :json

  private

    def client
      ApiClient.new(request.remote_ip)
    end
end
