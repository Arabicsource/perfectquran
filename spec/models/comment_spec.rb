require 'rails_helper'

RSpec.describe Comment, type: :model do
  before { @comment = FactoryGirl.build(:comment) }

  specify { expect(@comment).to be_valid }
  specify { expect(@comment).to respond_to :content }
  specify { expect(@comment).to validate_presence_of(:content) }  
  specify { expect(@comment).to validate_length_of(:content).is_at_least(3) }
end