require 'spec_helper'

describe V1::UploadsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:upload) { FactoryGirl.create(:upload, user: user) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:upload) }

  context 'logged out' do
    describe 'GET index' do
      before { get :index, format: :json }

      it { should respond_with(:unauthorized) }
    end

    describe 'GET show' do
      before { get :show, id: upload.id, format: :json }

      it { should respond_with(:unauthorized) }
    end

    describe 'POST create' do
      before { post :create, upload: valid_attributes, format: :json }

      it { should respond_with(:unauthorized) }
    end
  end

  context 'logged in' do
    before { basic_auth(user) }

    describe 'GET index' do
      before { get :index, format: :json }

      it { should respond_with(:success) }
    end

    describe 'GET show' do
      before { get :show, id: upload.id, format: :json }

      it { should respond_with(:success) }
      it { should render_template('uploads/show') }
    end

    describe 'POST create' do
      context 'with valid attributes' do
        before { post :create, upload: valid_attributes, format: :json }

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
          post :create, upload: { midi_file: "I'm not a midi file" },
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
