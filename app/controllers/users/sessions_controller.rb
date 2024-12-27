class Users::SessionsController < Devise::SessionsController

  include RackSessionsFix
  respond_to :json

  def respond_with(current_user, _opts = {})
  token = request.env['warden-jwt_auth.token']
    render json: {
    status: {
      token: token,
      code: 200, message: 'Logged in successfully.',
      data: { user: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
     }
    }
  }, status: :ok
  end

  def respond_to_on_destroy
    current_user = check_current_user
    if current_user
      render json: {
        status: 200,
        message: 'Logged out successfully.'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end

  private
  
  def check_current_user
    if request.headers['Authorization'].present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, Rails.application.credentials.devise_jwt_secret_key!).first
      current_user = User.find(jwt_payload['sub'])
    end
    current_user
  end
end




















































  # def create
  #   self.resource = warden.authenticate!(auth_options)

  #   if resource
  #     sign_in(resource_name, resource)

  #     token = request.env['warden-jwt_auth.token']
  
  #     render json: {
  #       status: {
  #         code: 200,
  #         user: current_user,
  #         message: 'Logged in successfully babe'
  #       },
  #       data: {
  #         user: resource,
  #         token: token
  #       }
  #     }
  #   else
  #     render json: {
  #     status: {
  #       code: 401,
  #       message: 'Invalid email or password'
  #     }
  #   }, status: :unauthorized
  #   end
  # end

  # def destroy

  #   if current_user

  #     token = request.env['HTTP_AUTHORIZATION']&.split&.last
  #     payload = JWT.decode(token, Rails.application.credentials.secret_key_base, true, { algorithm: 'HS256' }).first
      
  #     current_user.update_column(:jwt_revocation_token, payload['jti'])
      
  #     sign_out(resource_name)

  #     render json: {
  #       status: {
  #         code: 200,
  #         message: 'Logged out successfully'
  #       }
  #     }, status: :ok
  #   else
  #     render json: {
  #       status: {
  #         code: 401,
  #         message: 'No active session'
  #       }
  #     }, status: :unauthorized
  #   end
  # end

  # private

  # def auth_options
  #   { scope: resource_name, recall: "#{controller_path}#new" }
  # end