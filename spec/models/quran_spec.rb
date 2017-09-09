# frozen_string_literal: true

# == Schema Information
#
# Table name: qurans
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  language_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Quran, type: :model do
  before { @quran = FactoryGirl.build(:quran) }

  specify { expect(@quran).to be_valid }
  specify { expect(@quran).to respond_to :name }
  specify { expect(@quran).to respond_to :description }
  specify { expect(@quran).to respond_to :language }

  specify { expect(@quran).to belong_to :language }
end
