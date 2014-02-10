require_relative '../spec_helper'
describe User do
  before :each do
    @user = User.new
  end

  describe "#new" do
    it "creates a User from a Name and Email" do
      @user.should be_an_instance_of User
    end
  end
end