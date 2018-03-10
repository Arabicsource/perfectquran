# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Share, type: :model do
  subject { build_stubbed :share }

  it { is_expected.to belong_to :ayah }
end
