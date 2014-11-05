require 'spec_helper'

describe V1::UsersController do
  let(:valid_attributes) { FactoryGirl.attributes_for(:user) }

  describe 'POST create' do
    context 'with valid attributes' do
      before { post :create, valid_attributes }

      it { should respond_with(:success) }
      it { should render_template 'create' }
    end

    context 'with invalid attributes' do
      before { post :create,
                    valid_attributes.except(:username) }

      it { should respond_with(:unprocessable_entity) }

      it 'returns validation errors' do
        expect(response.body).to include 'errors'
      end
    end
  end

  context 'logged in' do
    let(:user) { FactoryGirl.create(:user) }
    before { basic_auth(user) }

    context 'PUT update' do
      context 'with valid attributes' do
        before do
          put :update, id: user.id, name: 'New Name'
        end

        it { should respond_with(:no_content) }
      end

      context 'with invalid attributes' do
        before do
          put :update, id: user.id, password: '123'
        end

        it { should respond_with(:unprocessable_entity) }

        it 'returns validation errors' do
          expect(response.body).to include 'errors'
        end
      end

      context 'with an unauthorized user' do
        let(:unauthorized) { FactoryGirl.create(:user) }

        before do
          put :update, id: unauthorized.id,
                       name: 'New Name'
        end

        it { should respond_with(:unauthorized) }
      end
    end

    context 'GET show' do
      context 'with an authorized user' do
        before { get :show, id: user.id }

        it { should respond_with(:ok) }
      end

      context 'with an unauthorized user' do
        let(:unauthorized) { FactoryGirl.create(:user) }
        before { get :show, id: unauthorized.id }

        it { should respond_with(:unauthorized) }
      end
    end
  end
end
