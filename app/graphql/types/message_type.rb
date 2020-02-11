# frozen_string_literal: true

module Types
  class MessageType < Types::BaseObject
    field :id, ID, null: false
    field :content, String, null: true
    field :origin, String, null: true
    field :destination, String, null: true

    # batch loading by active record - local data
    def origin
      BatchLoader::GraphQL.for(object.from_user_id).batch do |user_ids, loader|
        User.where(id: user_ids).select(:id, :name).each { |user| loader.call(user.id, user.name) }
      end
    end

    # batch loading by graphql client - remote data
    def destination
      BatchLoader::GraphQL.for(object.to_user_id).batch do |user_ids, loader|
        UserService.users(user_ids).each { |user| loader.call(user.id.to_i, user.name) }
      end
    end
  end
end
