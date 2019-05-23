module Api
  module V1
    class AuthController < Api::V1::ApplicationController
      def login
        user = User.find_by_email(login_params[:email])

        if user&.authenticate(login_params[:password])
          token = JsonWebToken.encode({ user_id: user.id })
          render json: { token: token }, status: :ok
        else
          render json: { error: 'unauthorized' }, status: :unauthorized
        end
      end

      private

      def login_params
        params.permit(:email, :password)
      end
    end
  end
end