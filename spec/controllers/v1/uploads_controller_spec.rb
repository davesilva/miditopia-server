require 'spec_helper'

describe V1::UploadsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:track) { FactoryGirl.create(:track) }
  let(:upload) { FactoryGirl.create(:upload, user: user, track: track) }
  let(:valid_attributes) do
    FactoryGirl.attributes_for(:upload).merge(track_id: track.id)
  end

  shared_examples_for 'index and show' do
    describe 'GET index' do
      before { get :index, format: :json }

      it { should respond_with(:success) }
      it { should render_template('uploads/index') }
    end

    describe 'GET show' do
      before { get :show, id: upload.id, format: :json }

      it { should respond_with(:success) }
      it { should render_template('uploads/show') }
    end    
  end

  context 'logged out' do
    it_behaves_like 'index and show'

    describe 'POST create' do
      before { post :create, valid_attributes.merge(format: :json) }

      it { should respond_with(:unauthorized) }
    end
  end

  context 'logged in' do
    before { basic_auth(user) }

    it_behaves_like 'index and show'

    describe 'POST create' do
      context 'with valid attributes' do
        before { post :create, valid_attributes.merge(format: :json) }

        it { should respond_with(:success) }
        it { should render_template('uploads/create') }

        it 'creates the upload' do
          expect(Upload.count).to eq 1
        end

        it 'sets the upload user_id' do
          expect(Upload.first.user_id).to eq user.id
        end
      end

      context 'with invalid attributes' do
        before do
          post :create, midi_file: "I'm not a midi file",
                        format: :json
        end

        it { should respond_with(:unprocessable_entity) }
      end
    end

    describe 'DELETE destroy' do
      context 'with an authorized user' do
        before { delete :destroy, id: upload.id }

        it { should respond_with(:success) }

        it 'destroys the upload' do
          expect(Upload.count).to eq 0
        end
      end

      context 'with an unauthorized user' do
        let(:other_user) { FactoryGirl.create(:user) }
        let(:upload) { FactoryGirl.create(:upload, user: other_user) }

        before { delete :destroy, id: upload.id }

        it { should respond_with(:unauthorized) }

        it 'does not destroy the upload' do
          expect(Upload.count).to eq 1
        end
      end
    end
  end
end
