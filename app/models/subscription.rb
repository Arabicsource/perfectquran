# frozen_string_literal: true

# == Schema Information
#
# Table name: subscriptions
#
#  id                 :integer          not null, primary key
#  account_id         :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  customer_token     :string
#  subscription_token :string
#

# :nodoc:
class Subscription < ApplicationRecord
  belongs_to :account
end
