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

  def activity
    @votes_from_posts = self.up_votes
    @votes_from_comments = 0
    self.comments.each {|c| @votes_from_comments += c.up_votes}
    @activity = (@votes_from_comments + @votes_from_posts)
    puts "total votes: " + @activity.to_s
    @time_difference = self.created_at.to_time - Time.now.to_time
    puts "Time difference is: " + @time_difference.to_s;
    if (@time_difference < 86400)
      @activity+= 5
    end
    else if (@time_difference < 604800)
      @activity+= 2
         end
    return @activity
  end

end
