# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'associations' do
    it { is_expected.to belong_to(:article).counter_cache true }
  end

  context 'validations' do
    it { is_expected.to validate_presence_of :content }
  end
end
