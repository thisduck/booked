class RateVote
  include MongoMapper::Document

  key :user_id, ObjectId
  belongs_to :user

  key :entry_id, ObjectId
  belongs_to :entry

  key :type_of, String, :in => ['up', 'down', 'meh']

  after_create do
    entry.add_voter(user)
  end

  after_destroy do
    entry.remove_voter(user)
  end
end
