# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :messages, [Types::MessageType], null: false

    def messages
      Message.all
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    field :users, [Types::UserType], null: false do
      argument :ids, [ID], required: true
    end

    def users(ids:)
      User.where(id: ids)
    end

    field :message, Types::MessageType, null: false do
      argument :id, ID, required: true
    end

    def message(id:)
      Message.find(id)
    end

    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end

    def user(id:)
      User.find(id)
    end
  end
end
