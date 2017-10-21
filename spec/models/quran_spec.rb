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
  subject { Quran.first }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to :language }
end
