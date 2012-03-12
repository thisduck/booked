class Entry
  include MongoMapper::Document

  key :user_id, ObjectId
  belongs_to :user

  key :title, String
  key :body, String
  key :grouping, String
  key :day, Time

  validates_presence_of :user_id, :title, :body

  validate :on => :create do
    self.errors.add(:user_id, "User cannot create post.") if !user.admin?
  end
end
