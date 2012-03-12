class RateVote
  include MongoMapper::Document

  key :user_id, ObjectId
  belongs_to :user

  key :entry_id, ObjectId
  belongs_to :entry

  key :type_of, String, :in => ['up', 'down', 'meh']

  after_create do
    entry.add_to_set(:voters => user.id)
  end

  after_destroy do
    entry.pull(:voters => user.id)
  end
end
