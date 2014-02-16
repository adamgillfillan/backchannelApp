class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :post_votes
  validates :user_id, presence: true
  validates :content, presence: true
  def up_votes
    self.post_votes.count
  end
  def upvoteable(user_id_no)
    return self.post_votes.where(:user_id => user_id_no).count == 0 && self.user !=User.find(user_id_no)
  end

  def upvote(user_id_no)
    @post_vote = PostVote.new
    @post_vote.user = User.find user_id_no
    @post_vote.post = self
    @post_vote.save
  end

end
