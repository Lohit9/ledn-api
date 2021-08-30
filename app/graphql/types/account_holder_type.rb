class Types::AccountHolderType < Types::BaseObject
  field :first_name, String, null: true  
  field :last_name, String, null: true
  field :country, String, null: true   
  field :email, String, null: false 
  field :dob, String, null: true 
  field :mfa, String, null: true 
  field :amt, Integer, null: false 
  field :createdDate, String, null: false 
  field :referredBy, String, null: true 
end
