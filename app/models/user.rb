class User < ActiveRecord::Base
  # Use friendly_id on Users
  extend FriendlyId
  friendly_id :friendify, use: :slugged

  has_many :user_tags
  has_many :tags, through: :user_tags

  # necessary to override friendly_id reserved words
  def friendify
    if username.downcase == "admin"
      "user-#{username}"
    else
      "#{username}"
    end
  end

  # Use a secure password
  has_secure_password

  # Basic validations
  validates :username,:email, presence: true
  validates :username, length: { in: 4..10 }
  validates :username, uniqueness: { case_sensitive: false }
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 4 }, on: :create
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create
  validates_format_of :username, with: /\A[a-zA-Z0-9]*\z/, on: :create, message: "can only contain letters and digits"

  def loves?(tag)
    tags.include?(tag)
  end

  def test_search
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "gIQV1TLhYf28r0cprQWew"
      config.consumer_secret     = "vFPkeSExWO1j313whH13EMQP0VrGblHirZz7uRb9Vw"
      config.access_token        = "48444221-x1bINwLjRKYyFbv2GCIlBbu0EPg5qABYxXzfqZMV6"
      config.access_token_secret = "oA5xj0zDTeAzth0Wp1G1FXFw6b52ZkZIRnFgo7ls"
    end

    client.search("#mayonnaise").collect do |tweet|
      puts "#{tweet.text} - @#{tweet.user.screen_name}"
    end
  end

end