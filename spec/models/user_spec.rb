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
  
  specify { expect(@user).to be_valid }
  specify { expect(@user).to respond_to :name }
  specify { expect(@user).to respond_to :username }
  specify { expect(@user).to validate_presence_of(:name) }
  specify { expect(@user).to validate_length_of(:name).is_at_least(3).is_at_most(50) }
  specify { expect(@user).to validate_presence_of(:username) }
  specify { expect(@user).to validate_uniqueness_of(:username).case_insensitive }
  specify { expect(@user).to have_many(:rolings) }
  specify { expect(@user).to have_many(:roles).through(:rolings) }
end
