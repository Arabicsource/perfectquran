# frozen_string_literal: true

# == Schema Information
#
# Table name: charges
#
#  id              :integer          not null, primary key
#  account_id      :integer
#  amount_in_cents :integer
#  payment_brand   :string
#  payment_last4   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

# :nodoc:
class Charge < ApplicationRecord
  belongs_to :account
end
