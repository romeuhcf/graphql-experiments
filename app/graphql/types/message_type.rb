module Types
  class MessageType < Types::BaseObject
    field :id, ID, null: false
    field :content, String, null: true
    field :origin, String, null: true
    field :destination, String, null: true

    def origin
      BatchLoader::GraphQL.for(object.from_user_id).batch do |user_ids, loader|
        User.where(id: user_ids).select(:id, :name).each { |user| loader.call(user.id, user.name) }    
      end
    end
    
    def destination
      User.find(object.to_user_id).name
    end
  end
end
