class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  has_many :comment_votes
  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :content, presence: true
  def up_votes
    self.comment_votes.count
  end
  def upvoteable(user_id_no)
    return self.comment_votes.where(:user_id => user_id_no).count == 0 && self.user !=User.find(user_id_no)
  end

  def upvote(user_id_no)
    @comment_vote = CommentVote.new
    @comment_vote.user = User.find user_id_no
    @comment_vote.comment = self
    @comment_vote.save
  end

end