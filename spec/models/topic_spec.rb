# == Schema Information
#
# Table name: topics
#
#  id               :integer          not null, primary key
#  subject          :string
#  content          :text
#  discussable_type :string
#  discussable_id   :integer
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe Topic, type: :model do
  before { @topic = FactoryGirl.build(:topic) }
  
  specify { expect(@topic).to be_valid }
  specify { expect(@topic).to respond_to :subject }
  specify { expect(@topic).to respond_to :content }
  specify { expect(@topic).to validate_presence_of(:subject) }
  specify { expect(@topic).to validate_length_of(:subject).is_at_least(3).is_at_most(100) }
  specify { expect(@topic).to validate_presence_of(:content) }
  specify { expect(@topic).to validate_length_of(:content).is_at_least(3) }
end
