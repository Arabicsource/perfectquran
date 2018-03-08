# frozen_string_literal: true

# == Schema Information
#
# Table name: memories
#
#  id         :integer          not null, primary key
#  account_id :integer
#  ayah_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# :nodoc:
class Memory < ApplicationRecord
  belongs_to :account
  belongs_to :memorable, polymorphic: true
end
