class AccountHolder < ApplicationRecord
  validates :email, uniqueness: { case_sensitive: false }   

  scope :by_first_name, ->(first_name) { where("first_name ILIKE ?", "#{first_name}%") if first_name }
  scope :by_last_name, ->(last_name) { where("last_name ILIKE ?", "#{last_name}%") if last_name }
  scope :by_country, ->(country) { where("country ILIKE ?", "#{country}%") if country }
  scope :by_mfa, ->(mfa) { where("mfa ILIKE ?", "#{mfa}%") if mfa }

  def self.graphql_query(options)
    AccountHolder.all
      .by_first_name(options[:first_name])
      .by_last_name(options[:last_name])
      .by_country(options[:country])
      .by_mfa(options[:mfa])
      .order(options[:sort].to_h)
  end
end
