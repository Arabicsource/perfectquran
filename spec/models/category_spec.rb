# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :description }
  end
end
