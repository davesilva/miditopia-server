require 'spec_helper'

describe V1::UsersController do
  let(:valid_attributes) { FactoryGirl.attributes_for(:user) }

  describe 'POST create' do
    it "creates a new user with valid attributes" do
      expect(User.count).to eq 0

      post '/api/v1/users', user: valid_attributes

      expect(response).to be_success
      expect(User.count).to eq 1
    end
  end
end
