# frozen_string_literal: true

# == Schema Information
#
# Table name: menu_links
#
#  id         :integer          not null, primary key
#  name       :string
#  path       :string
#  menu_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe MenuLink, type: :model do
  context 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :path }
  end
end
