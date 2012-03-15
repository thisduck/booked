class User
  include MongoMapper::Document

  key :type_of, String, :default => "user"

  key :name, String
  key :email, String
  key :link, String
  key :handle, String

  key :auth_keys, Array
  attr_accessible :name, :email, :handle

  has_many :tag_votes
  has_many :rate_votes

  def self.fetch_by_auth_hash auth_hash
    find_with_auth_hash(auth_hash) || create_by_auth_hash(auth_hash)
  end

  def self.find_with_auth_hash auth_hash
    self.first :auth_keys => auth_key(auth_hash)
  end

  def self.create_by_auth_hash auth_hash
    Rails.logger.info auth_hash[:info].inspect
    Rails.logger.info auth_hash[:info][:name]
    Rails.logger.info auth_hash[:info][:email]
    handle = auth_hash[:info][:nickname]
    if !handle || handle.empty?
      handle = auth_hash[:info][:email].split("@").first if auth_hash[:info][:email].present?
    end
    user = self.new(
      :handle => handle || auth_hash[:info][:name],
      :name => auth_hash[:info][:name],
    )
    user.auth_keys = auth_key(auth_hash)
    user.save

    user
  end

  def self.auth_key auth_hash
    "#{auth_hash[:provider]}-#{auth_hash[:uid]}"
  end

  def admin?
    type_of == "admin"
  end

  def user?
    type_of == "user"
  end

  def editor?
    type_of == "editor"
  end

  def can_edit?
    admin? || editor?
  end
end
