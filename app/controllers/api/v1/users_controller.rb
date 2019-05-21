module Api
  module V1
    class UsersController < Api::V1::ApplicationController
      def create
        user = User.new(user_params)
        if user.save
          render json: user.to_json(only: [:id, :name])
        else
          render json: { erros: user.errors.full_messages }, status: :bad_request
        end
      end

      def show
        user = User.find(params[:id])
        render json: user.to_json(only: [:id, :name])
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end
    end
  end
end
