require_relative '../spec_helper'
require 'ruby-debug'
describe SessionsController do
  before :all do
    @user = User.new :name=>'Name', :email=>'Email@site.com'
    @user.password = 'password'
    @user.save

    @sessions_controller = SessionsController.new
  end

  describe 'authenticating user' do
    it 'should check the database for a match' do
      @newUser = User.authenticate @user.email, @user.password
      assert_equal @newUser.email, @user.email
    end
  end
end