require 'rails_helper'

RSpec.describe Topic, type: :model do
  before { @topic = FactoryGirl.build(:topic) }
  
  specify { expect(@topic).to be_valid }
  specify { expect(@topic).to respond_to :subject }
  specify { expect(@topic).to respond_to :content }
  specify { expect(@topic).to validate_presence_of(:subject) }
  specify { expect(@topic).to validate_presence_of(:content) }
end
