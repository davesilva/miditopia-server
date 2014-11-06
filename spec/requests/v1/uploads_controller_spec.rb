require 'spec_helper'

describe V1::UploadsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:track) { FactoryGirl.create(:track) }
  let(:attributes) { FactoryGirl.attributes_for(:upload, track_id: track.id) }

  describe 'GET /uploads' do
    it 'gets a list of all uploads' do
      3.times { FactoryGirl.create(:upload) }

      xhr :get, '/v1/uploads'

      expect(response).to be_success

      body = JSON.parse(response.body)
      expect(body.length).to eq 3
      expect(body[0]['id']).to be_present
      expect(body[0]['track_id']).to be_present
      expect(body[0]['user_id']).to be_present
      expect(body[0]['url']).to be_present
    end
  end

  describe 'POST /uploads' do
    it 'creates an upload if credentials are valid' do
      expect(Upload.count).to eq 0

      xhr :post, '/v1/uploads', attributes, basic_auth(user)

      expect(response).to be_success

      body = JSON.parse(response.body)
      expect(body['id']).to be_present
      expect(body['track_id']).to eq attributes[:track_id]
      expect(body['user_id']).to eq user.id
      expect(body['url']).to be_present
    end

    it 'responds with unauthorized if credentials are invalid' do
      xhr :post, '/v1/uploads', attributes

      expect(response).to be_unauthorized
    end
  end

  context do
    let(:upload) { FactoryGirl.create(:upload) }

    describe 'GET /uploads/:id' do
      it 'gets an upload' do
        xhr :get, "/v1/uploads/#{upload.id}"

        expect(response).to be_success

        body = JSON.parse(response.body)
        expect(body['id']).to eq upload.id
        expect(body['track_id']).to eq upload.track_id
        expect(body['user_id']).to eq upload.user_id
        expect(body['url']).to eq upload.midi_file.url
      end
    end

    describe 'DELETE /uploads/:id' do
      it 'deletes the upload if credentials are valid' do
        xhr :delete, "/v1/uploads/#{upload.id}", {}, basic_auth(upload.user)

        expect(response).to have_http_status(:no_content)
        expect(response.body).to be_empty
      end

      it 'responds with unauthorized if credentials are invalid' do
        xhr :delete, "/v1/uploads/#{upload.id}"

        expect(response).to be_unauthorized
      end

      it 'responds with unauthorized if the user does not own the upload' do
        xhr :delete, "/v1/uploads/#{upload.id}", {}, basic_auth(user)

        expect(response).to be_unauthorized
      end
    end
  end
end
