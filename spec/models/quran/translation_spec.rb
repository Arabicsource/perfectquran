# frozen_string_literal: true

# == Schema Information
#
# Table name: translations
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  language_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Quran::Translation, type: :model do
  subject { Quran::Translation.first }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to :language }
end
