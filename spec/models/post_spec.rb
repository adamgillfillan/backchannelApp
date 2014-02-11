require_relative '../spec_helper'
describe Post do
  before :each do
    @post = Post.new :content=>'User', :user_id=>0
  end

  describe "#new" do
    it "should create a Post from Content and UserID" do
      @post.should be_an_instance_of Post
    end
  end
  it 'should have an activity based on votes, comment votes, time elapsed'
  it 'should decay in activity over time'

end
