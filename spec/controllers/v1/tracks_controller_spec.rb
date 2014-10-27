require 'spec_helper'

describe V1::TracksController do
  let(:user) { FactoryGirl.create(:user) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:track) }

  context 'logged out' do
    describe 'GET index' do
      before { get :index, format: :json }

      it { should respond_with(:unauthorized) }
    end
  end

  context 'logged in' do
    before { basic_auth(user) }

    describe 'GET index' do
      before { get :index, format: :json }

      it { should respond_with(:ok) }
      it { should render_template('tracks/index') }
    end
  end
end
