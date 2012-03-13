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

  key :voters, Array
  has_many :rate_votes
  many :comments

  validates_presence_of :user_id, :title, :body


  validate :on => :create do
    self.errors.add(:user_id, "User cannot create post.") if !user.admin?
  end

  def to_param
    "#{id}-#{type_of.parameterize}-#{slug}"
  end

  def self.random(id = nil, user = nil)
    query = {}
    query[:_id.ne] = id if id
    query[:voters.ne] = user.id if user
    query[:skip] = rand(Entry.count(query))
    query[:limit] = 1
    entry = Entry.first(query)
  end

  def vote(user, type)
    # has the voter voted elsewhere?
    # if so take them out

    vote = rate_votes.first(:user_id => user.id)

    if vote
      return if vote.type_of == type
      vote.destroy
    end

    rate_votes.create(
      :user_id => user.id,
      :type_of => type.to_sym
    )
  end

  def vote_by(user)
    rate_votes.first(:user_id => user.id)
  end

  def comment(user, message)
    comment = comments.build(
      :body => message
    )
    comment.user_id = user.id
    comment.save

    comment
  end
end
