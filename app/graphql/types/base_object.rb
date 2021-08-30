module Types
  class BaseObject < GraphQL::Schema::Object
    edge_type_class(Types::BaseEdge)
    connection_type_class(Types::BaseConnection)
    field_class Types::BaseField

    def self.field_accounts
      field :accounts, [Types::AccountHolderType], null: false do
        # API filters
        argument :first_name, String, required: false
        argument :last_name, String, required: false
        argument :country, String, required: false
        argument :mfa, String, required: false
        
        # API sorting
        argument :sort, [Types::Enum::AccountHolderSort], required: false, default_value: []
      end
    end
  end
end
