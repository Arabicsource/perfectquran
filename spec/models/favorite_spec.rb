# == Schema Information
#
# Table name: favorites
#
#  id         :integer          not null, primary key
#  ayah_id    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Favorite, type: :model do
  before { @favorite = FactoryGirl.build(:favorite) }

  specify { expect(@favorite).to be_valid }

  specify { expect(@favorite).to respond_to(:user) }
  specify { expect(@favorite).to respond_to(:ayah) }
  specify { expect(@favorite).to belong_to(:user) }
  specify { expect(@favorite).to belong_to(:ayah).counter_cache(true) }

end
