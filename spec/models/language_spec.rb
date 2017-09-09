# frozen_string_literal: true

# == Schema Information
#
# Table name: languages
#
#  id         :integer          not null, primary key
#  name       :string
#  direction  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Language, type: :model do
  before { @language = FactoryGirl.build(:language) }

  specify { expect(@language).to be_valid }
  specify { expect(@language).to respond_to :name }
  specify { expect(@language).to respond_to :direction }
end
