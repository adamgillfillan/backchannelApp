require_relative '../spec_helper'
require 'ruby-debug'
describe User do
  before :each do
    #debugger
    @user = User.new :name=>'Name', :email=>'Email@site.com'
  end

  describe '#new' do
    it 'should create a User from Name and Email' do
      @user.should be_an_instance_of User
    end
  it 'should have an encrypted password'
  end
end