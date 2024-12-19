class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    
    self.resource = warden.authenticate!(auth_options)

    if resource
      sign_in(resource_name, resource)

      token = request.env['warden-jwt_auth.token']
  
      render json: {
        status: {
          code: 200,  
          message: 'Logged in successfully babe'
        },
        data: {
          user: resource,
          token: token
        }
      }
    else
      render json: {
      status: {
        code: 401,
        message: 'Invalid email or password'
      }
    }, status: :unauthorized
    end
  end

  def destroy

    if current_user

      token = request.env['HTTP_AUTHORIZATION']&.split&.last
      payload = JWT.decode(token, Rails.application.credentials.secret_key_base, true, { algorithm: 'HS256' }).first
      
      current_user.update_column(:jwt_revocation_token, payload['jti'])
      
      sign_out(resource_name)

      render json: {
        status: {
          code: 200,
          message: 'Logged out successfully'
        }
      }, status: :ok
    else
      render json: {
        status: {
          code: 401,
          message: 'No active session'
        }
      }, status: :unauthorized
    end
  end

  private

  def auth_options
    { scope: resource_name, recall: "#{controller_path}#new" }
  end
end