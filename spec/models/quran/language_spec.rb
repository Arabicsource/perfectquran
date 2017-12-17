# frozen_string_literal: true

# == Schema Information
#
# Table name: languages
#
#  id        :integer          not null, primary key
#  name      :string
#  direction :string
#

require 'rails_helper'

RSpec.describe Quran::Language, type: :model do
  it { is_expected.to be_valid }
end
