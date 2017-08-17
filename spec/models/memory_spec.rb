# == Schema Information
#
# Table name: memories
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  ayah_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Memory, type: :model do
  before { @memory = FactoryGirl.build(:memory) }
  
  specify { expect(@memory).to be_valid }
  specify { expect(@memory).to respond_to(:user) }
  specify { expect(@memory).to respond_to(:ayah) }
  specify { expect(@memory).to belong_to(:user) }
  specify { expect(@memory).to belong_to(:ayah).counter_cache(true) }
end
