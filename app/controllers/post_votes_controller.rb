class PostVotesController < ApplicationController

  def index
    @post_votes = PostVote.all
  end
end