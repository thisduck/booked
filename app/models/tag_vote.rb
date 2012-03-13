class TagVote
  include MongoMapper::Document

  key :user_id, ObjectId
  belongs_to :user

  key :entry_id, ObjectId
  belongs_to :entry

  key :tag, String

  after_create do
    entry.add_to_set(:tags => tag)
  end
end
