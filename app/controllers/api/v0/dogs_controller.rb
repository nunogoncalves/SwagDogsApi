module Api
  module V0
    class DogsController < Api::V0::ApiController

      swagger_controller :dogs_controller, 'Dogs Controller'

      swagger_api :index do
        summary "Get the list of all dogs"
        notes "It's possible to filter dogs"

        param :query, :name, :string, :optional, "Filter by dog name"

        response :ok
      end

      def index
        render json: { dogs: Dog.search(params[:q]).result }, status: :ok
      end

      swagger_api :show do
        summary "Display the dog object"
        notes "Get and display a dog"

        param :path, :id, :string, :required, "Dog id"

        response :ok
        response :not_found
      end

      def show
        dog = Dog.where(id: params[:id]).first
        if dog
          render json: dog, status: :ok
        else
          render json: {}, status: :not_found
        end
      end

      swagger_api :create do
        summary "Create a dog"
        notes "Create a dog."

        param :body, :dog, :Dog, :required, "a dog object to create"

        response :created
        response :not_acceptable
        response :unprocessable_entity
      end

      swagger_model :Dog do
        description "Dog Object"
        property :name, :string, :required, "Dog Name"
        property :breed, :string, :required, "Dog breed"
        property :color, :string, :required, "Dog color"
      end


      def create
        return render json: {}, status: :not_acceptable unless params.has_key? 'dog'

        dog = Dog.new(params[:dog])
        if dog.save
          render json: dog, status: dog.valid? ? :created : :unprocessable_entity
        else
          render json: { dog: dog,
                         errors: dog.errors.messages },
                        status: dog.valid? ? :created : :unprocessable_entity
        end
      end

      swagger_api :update do
        summary "Update a dog"
        notes "Update a dog."

        param :path, :id, :integer, :required, "id of dog to update"

        param :body, :dog, :Dog, :required, "a dog object to create"

        response :created
        response :not_acceptable
        response :unprocessable_entity
      end

      def update
        dog = Dog.where(id: params[:id]).first
        if dog
          if dog.update_attributes(params[:dog])
            render json: dog, status: dog.valid? ? :created : :unprocessable_entity
          else
            render json: { dog: dog,
                           errors: dog.errors.messages },
                          status: dog.valid? ? :created : :unprocessable_entity
          end
        else
          render json: {}, status: :not_found
        end
      end

      swagger_api :destroy do
        summary "Delete a dog"
        notes "Delete a dog."

        param :path, :id, :integer, :required, "id of dog to delete"

        response :created
        response :not_acceptable
        response :unprocessable_entity
      end

      def destroy
        dog = Dog.where(id: params[:id]).first
        if dog
          if dog.delete
            render json: {} ? :ok : :unprocessable_entity
          end
        else
          render json: {}, status: :not_found
        end
      end

    end
  end
end