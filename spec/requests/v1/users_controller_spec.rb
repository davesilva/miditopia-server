require 'spec_helper'

describe V1::UsersController do
  let(:attributes) { FactoryGirl.attributes_for(:user) }

  describe 'POST /users' do
    it 'creates a user' do
      expect(User.count).to eq 0

      xhr :post, '/v1/users', attributes

      expect(response).to be_success
      expect(User.count).to eq 1

      body = JSON.parse(response.body)
      expect(body['id']).to be_present
      expect(body['email']).to eq attributes[:email]
      expect(body['username']).to eq attributes[:username]
    end
  end

  context do
    let(:user) { FactoryGirl.create(:user) }
    let(:id) { user.id }
    let(:username) { user.username }
    let(:password) { user.password }

    describe 'GET /users/:id' do
      it 'gets a user if the credentials match' do
        xhr :get, "/v1/users/#{id}", {}, basic_auth(user)

        expect(response).to be_success

        body = JSON.parse(response.body)
        expect(body['id']).to be_present
        expect(body['email']).to eq user.email
        expect(body['username']).to eq user.username
      end

      it 'responds with unauthorized if the credentials do not match' do
        other_user = FactoryGirl.create(:user)

        xhr :get, "/v1/users/#{id}", {}, basic_auth(other_user)

        expect(response).to be_unauthorized
      end
    end

    describe 'PUT /users/:id' do
      it 'updates the user if the credentials match' do
        xhr :put, "/v1/users/#{id}", { email: 'asdf@test.com' }, basic_auth(user)

        expect(response).to have_http_status(:no_content)
        expect(response.body).to be_empty

        expect(User.find(id).email).to eq 'asdf@test.com'
      end

      it 'responds with unauthorized if the credentials do not match' do
        other_user = FactoryGirl.create(:user)

        xhr :put, "/v1/users/#{id}", { email: 'asdf@test.com' }, basic_auth(other_user)

        expect(response).to be_unauthorized
      end
    end
  end
end
