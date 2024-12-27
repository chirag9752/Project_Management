class Users::RegistrationsController < Devise::RegistrationsController
  
  include RackSessionsFix
  respond_to :json

  def respond_with(current_user, _opts = {})
    if resource.persisted?
      render json: {
        status: {code: 200, message: 'Signed up successfully.'},
        data: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        status: {message: "User couldn't be created successfully. #{current_user.errors.full_messages.to_sentence}"}
      }, status: :unprocessable_entity
    end
  end

  # Override create method for custom user registration
  # def create
  #   # Build resource from params
  #   build_resource(sign_up_params)
  
  #   # Attempt to save the resource
  #   if resource.save
  #     # If save is successful

  #     sign_in(resource_name, resource)

  #     token = request.env['warden-jwt_auth.token']

  #     render json: {
  #       status: { 
  #         code: 201, 
  #         message: 'Signed up successfully' 
  #       },
  #       data: {
  #         user: resource,
  #         token: token
  #       }
  #     }, status: :created
  #   else
  #     render json: {
  #       status: { 
  #         code: 422, 
  #         message: 'User could not be created successfully',
  #         errors: resource.errors.full_messages
  #       }
  #     }, status: :unprocessable_entity
  #   end
  # end

  # Override update method for profile updates
  # def update
  #   # Ensure user is authenticated
  #   return render_unauthorized unless current_user

  #   # Attempt to update resource
  #   if update_resource(current_user, account_update_params)
  #     render json: {
  #       status: { 
  #         code: 200, 
  #         message: 'Account updated successfully' 
  #       },
  #       data: {
  #         user: current_user
  #       }
  #     }
  #   else
  #     render json: {
  #       status: { 
  #         code: 422, 
  #         message: 'Could not update account',
  #         errors: current_user.errors.full_messages
  #       }
  #     }, status: :unprocessable_entity
  #   end
  # end

  # # Override destroy method for account deletion
  # def destroy
  #   # Ensure user is authenticated
  #   return render_unauthorized unless current_user

  #   # Attempt to delete resource
  #   if current_user.destroy
  #     render json: {
  #       status: { 
  #         code: 200, 
  #         message: 'Account deleted successfully' 
  #       }
  #     }, status: :ok
  #   else
  #     render json: {
  #       status: { 
  #         code: 422, 
  #         message: 'Could not delete account',
  #         errors: current_user.errors.full_messages
  #       }
  #     }, status: :unprocessable_entity
  #   end
  # end

  private

  # Strong parameters for sign up
  # def sign_up_params
  #   params.require(:user).permit(:email, :password, :password_confirmation, :name, :role, :employee_type)
  # end

  # Strong parameters for account update
  # def account_update_params
  #   params.require(:user).permit(
  #     :email, 
  #     :password, 
  #     :password_confirmation, 
  #     :current_password, 
  #     # Add any additional fields you want to allow during update
  #     :first_name, 
  #     :last_name
  #   )
  # end

  # Render unauthorized response
  # def render_unauthorized
  #   render json: {
  #     status: { 
  #       code: 401, 
  #       message: 'Unauthorized' 
  #     }
  #   }, status: :unauthorized
  # end

  # Override default devise methods to skip certain validations if needed
  # def update_resource(resource, params)
  #   # Allows updating without current password if using JWT
  #   if params[:password].present?
  #     resource.update_with_password(params)
  #   else
  #     # Remove password-related keys to avoid validation
  #     params.delete(:current_password)
  #     resource.update_without_password(params)
  #   end
  # end
end