require 'rails_helper'

RSpec.describe User, type: :model do
  # Password
  it { should have_secure_password }
  it { should ensure_length_of(:password).is_at_least(6) }

  # Email
  it { should validate_presence_of(:email) }
  it { should allow_value('user@test.com').for(:email) }
  it { should_not allow_value('test.com').for(:email) }
  it { should_not allow_value('user@test').for(:email) }

  it 'should downcase emails before saving' do
    u = FactoryGirl.create(:user, email: 'USER@test.com')
    expect(u.email).to eq 'user@test.com'
  end

  it 'should validate uniqueness of emails' do
    u1 = FactoryGirl.create(:user)
    u2 = FactoryGirl.build(:user, email: u1.email)

    expect(u2).to_not be_valid
  end

  # Username
  it { should validate_presence_of(:username) }

  it 'should validate uniqueness of emails' do
    u1 = FactoryGirl.create(:user)
    u2 = FactoryGirl.build(:user, email: u1.email)

    expect(u2).to_not be_valid
  end
end
