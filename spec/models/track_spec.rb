require 'rails_helper'

RSpec.describe Track, :type => :model do
  it { should belong_to :user }

  it { should validate_presence_of(:title) }
  it 'should validate uniqueness of titles' do
    t1 = FactoryGirl.create(:track)
    t2 = FactoryGirl.build(:track, title: t1.title)

    expect(t2).to_not be_valid
  end

  it { should validate_presence_of(:artist) }
  it 'should validate uniqueness of artists' do
    t1 = FactoryGirl.create(:track)
    t2 = FactoryGirl.build(:track, artist: t1.artist)

    expect(t2).to_not be_valid
  end  
end
