module Types
  class QueryType < Types::BaseObject
   
    field :messages, [Types::MessageType], null: false

    def messages
      Message.all
    end
   
    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    field :users, [Types::UserType], null: false

    def users
      User.all
    end

    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end

    def user(id:)
      User.find(id)
    end
  end
end
