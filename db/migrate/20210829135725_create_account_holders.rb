class CreateAccountHolders < ActiveRecord::Migration[6.1]
  def change
    create_table :account_holders do |t|
      t.string :first_name
      t.string :last_name
      t.string :country
      t.string :email
      t.string :dob
      t.string :mfa
      t.integer :amt
      t.string :createdDate
      t.string :referredBy

      t.timestamps
    end
  end
end
