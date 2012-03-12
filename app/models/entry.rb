class Entry
  include MongoMapper::Document
  plugin MongoMapper::Plugins::Sluggable

  key :user_id, ObjectId
  belongs_to :user

  key :type_of, String

  key :title, String
  sluggable :title

  key :body, String
  key :grouping, String
  key :day, Time

  validates_presence_of :user_id, :title, :body

  validate :on => :create do
    self.errors.add(:user_id, "User cannot create post.") if !user.admin?
  end

  def to_param
    "#{id}-#{type_of.parameterize}-#{slug}"
  end
end
