require 'spec_helper'

describe V1::TracksController do
  let(:user) { FactoryGirl.create(:user) }
  let(:track) { FactoryGirl.create(:track) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:track) }

  shared_examples_for 'index and show' do
    describe 'GET index' do
      before { get :index }

      it { should respond_with(:success) }
      it { should render_template('tracks/index') }
    end

    describe 'GET show' do
      before { get :show, id: track.id }

      it { should respond_with(:success) }
      it { should render_template('tracks/show') }
    end    
  end

  context 'logged out' do
    it_behaves_like 'index and show'

    describe 'POST create' do
      before { post :create, valid_attributes }

      it { should respond_with(:unauthorized) }
    end
  end

  context 'logged in' do
    before { basic_auth(user) }

    it_behaves_like 'index and show'

    describe 'POST create' do
      context 'with valid attributes' do
        before { post :create, valid_attributes }

        it { should respond_with(:success) }
        it { should render_template('tracks/create') }
      end

      context 'with invalid attributes' do
        before { post :create, valid_attributes.except(:title) }

        it { should respond_with(:unprocessable_entity) }

        it 'returns validation errors' do
          expect(response.body).to include 'errors'
        end
      end
    end

    describe 'PUT update' do
      let(:track) { FactoryGirl.create(:track) }

      before do
        put :update, id: track.id, title: 'New Title'
      end

      it { should respond_with(:unauthorized) }
    end

    describe 'DELETE destroy' do
      before do
        delete :destroy, id: track.id
      end

      it { should respond_with(:unauthorized) }
    end
  end
end
