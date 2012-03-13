class Comment
  include MongoMapper::Document

  key :entry_id, ObjectId
  belongs_to :entry
  key :user_id, ObjectId
  belongs_to :user

  key :body, String
  attr_accessible :body

  validates_presence_of :entry_id, :user_id, :body
end
