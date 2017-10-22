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

RSpec.describe Quran::Language, type: :model do
  subject { Quran::Language.first }

  it { is_expected.to be_valid }
end
