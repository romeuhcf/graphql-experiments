module Types
  class MessageType < Types::BaseObject
    field :id, ID, null: false
    field :content, String, null: true
    field :origin, String, null: true
    field :destination, String, null: true

    def origin
      User.find(object.from_user_id).name
    end
    def destination
      User.find(object.to_user_id).name
    end
  end
end
