# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  username               :string
#

require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = FactoryGirl.build(:user) }
  subject { @user }
  
  specify { expect(@user).to be_valid }
  specify { expect(@user).to respond_to :name }
  specify { expect(@user).to respond_to :username }
  specify { expect(@user).to validate_presence_of(:name) }
  specify { expect(@user).to validate_length_of(:name).is_at_least(3).is_at_most(50) }
  specify { expect(@user).to validate_presence_of(:username) }
  specify { expect(@user).to validate_uniqueness_of(:username).case_insensitive }
  specify { expect(@user).to allow_value('username').for(:username) }
  it { is_expected.to allow_value('username1').for(:username) }
  it { is_expected.to allow_value('user_name').for(:username) }
  it { is_expected.to_not allow_value('user name').for(:username) }
  specify { expect(@user).to have_many(:rolings) }
  specify { expect(@user).to have_many(:roles).through(:rolings) }

  describe '#has_role?(:role)' do
    let(:admin) { FactoryGirl.create(:user, :admin) }
    let(:user) { FactoryGirl.create(:user) }
    specify { expect(admin.has_role?(:admin)).to be_truthy }
    specify { expect(user.has_role?(:admin)).to be_falsey }
  end
end
