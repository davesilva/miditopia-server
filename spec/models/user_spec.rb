require 'rails_helper'

RSpec.describe User, type: :model do
  # Associations
  it { should have_many :tracks }

  # Password
  it { should have_secure_password }
  it { should ensure_length_of(:password).is_at_least(6) }
  it { should validate_presence_of(:password) }

  it 'should require a matching password and confirmation' do
    u = FactoryGirl.build(:user, password: 'password123',
                                 password_confirmation: 'password124')
    expect(u).to_not be_valid
  end

  it 'should require a password_confirmation if password is present' do
    u = FactoryGirl.build(:user, password_confirmation: nil)
    expect(u).to_not be_valid
  end

  it 'should not require password if password_digest is present' do
    FactoryGirl.create(:user)

    u = User.first
    expect(u).to be_valid
  end

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
