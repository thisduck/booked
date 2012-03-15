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

  key :tags, Array
  has_many :tag_votes

  key :score, Float, :default => 0

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

  def tag_vote(user, tag)
    tag = tag.downcase
    vote = tag_votes.first(:user_id => user.id, :tag => tag)

    if vote
      vote.destroy
    else
      vote = tag_votes.create(
        :user_id => user.id,
        :tag => tag
      )
    end

    vote
  end

  def vote_by(user)
    rate_votes.first(:user_id => user.id)
  end

  def tags_by(user)
    tag_votes.all(:user_id => user.id)
  end

  def set_score
    value = {'up' => 1.0, 'meh' => -0.5, 'down' => -1.0}
    votes = rate_votes.group_by(&:type_of)
    total = 0
    count = 0
    votes.each do |type, group|
      c = (group || []).count
      total += c * value[type]
      count += c
    end

    self.score = total.to_f
    self.voters = rate_votes.collect &:user_id
  end

  def comment(user, message)
    comment = comments.build(
      :body => message
    )
    comment.user_id = user.id
    comment.save

    comment
  end

  def add_voter(user)
    set_score
    save
  end

  def remove_voter(user)
    set_score
    save
  end
end
