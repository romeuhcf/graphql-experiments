# frozen_string_literal: true

module UserService
  class << self
    def users(ids)
      query = <<-GRAPHQL
        query($ids: [ID!]!) {
          users(ids: $ids) {
            id
            name
          }
        }
      GRAPHQL
      variables = { ids: ids }

      client.query(query, variables).data.users
    end

    private

    def client
      @client ||= Graphlient::Client.new('http://users:3000/graphql',
                                         headers: {
                                           # 'Authorization' => 'Bearer 123'
                                         },
                                         http_options: {
                                           read_timeout: 20,
                                           write_timeout: 30
                                         })
    end
  end
end
