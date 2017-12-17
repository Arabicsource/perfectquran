# frozen_string_literal: true

# == Schema Information
#
# Table name: translations
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  language_id :integer
#

require 'rails_helper'

RSpec.describe Quran::Translation, type: :model do
  it { is_expected.to belong_to :language }
end
