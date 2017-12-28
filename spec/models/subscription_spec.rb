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

require 'rails_helper'

RSpec.describe Subscription, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
