require 'spec_helper'

describe V1::TracksController do
  let(:user) { FactoryGirl.create(:user) }
  let(:attributes) { FactoryGirl.attributes_for(:track) }

  describe 'GET /tracks' do
    it 'gets a list of all tracks' do
      3.times { FactoryGirl.create(:track) }

      xhr :get, '/v1/tracks'

      expect(response).to be_success

      body = JSON.parse(response.body)
      expect(body.length).to eq 3
      expect(body[0]['id']).to be_present
      expect(body[0]['title']).to be_present
      expect(body[0]['artist']).to be_present
    end
  end

  describe 'POST /tracks' do
    it 'creates a track if credentials are valid' do
      expect(Track.count).to eq 0

      xhr :post, '/v1/tracks', attributes, basic_auth(user)

      expect(response).to be_success
      expect(Track.count).to eq 1

      body = JSON.parse(response.body)
      expect(body['id']).to be_present
      expect(body['artist']).to eq attributes[:artist]
      expect(body['title']).to eq attributes[:title]
    end

    it 'responds with unauthorized if credentials are invalid' do
      xhr :post, '/v1/tracks', attributes

      expect(response).to be_unauthorized
    end
  end

  context do
    let(:track) { FactoryGirl.create(:track) }
    let(:id) { track.id }

    describe 'GET /track/:id' do
      it 'gets a track' do
        xhr :get, "/v1/tracks/#{id}"

        expect(response).to be_success

        body = JSON.parse(response.body)
        expect(body['id']).to eq track.id
        expect(body['artist']).to eq track.artist
        expect(body['title']).to eq track.title
      end
    end

    describe 'PUT /track/:id' do
      it 'responds with unauthorized' do
        xhr :put, "/v1/tracks/#{id}", { title: 'asdf' }, basic_auth(user)

        expect(response).to be_unauthorized
      end
    end

    describe 'DELETE /track/:id' do
      it 'responds with unauthorized' do
        xhr :delete, "/v1/tracks/#{id}", {}, basic_auth(user)

        expect(response).to be_unauthorized
      end
    end
  end
end
