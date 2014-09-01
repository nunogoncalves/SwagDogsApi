module Api
  module V0
    class DogsController < Api::V0::ApiController

      def index
        render json: { dogs: Dog.all }, status: :ok
      end

      def show
        dog = Dog.where(id: params[:id]).first
        if dog
          render json: dog, status: :ok
        else
          render json: {}, status: :not_found
        end
      end

      def create
        return render json: {}, status: :not_acceptable unless params.has_key? 'dog'

        dog = Dog.new(params[:dog])
        render json: dog, status: dog.save? ? :created : :unprocessable_entity
      end

    end
  end
end