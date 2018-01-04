# frozen_string_literal: true

# == Schema Information
#
# Table name: connections
#
#  id           :integer          not null, primary key
#  name         :string
#  provider     :string
#  provider_uid :string
#  token        :string
#  secret       :string
#  account_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  status       :integer
#

# :nodoc:
class Connection < ApplicationRecord
  belongs_to :account

  validates :name, presence: true
  validates :provider, presence: true
  validates :provider_uid, presence: true, uniqueness: { scope: :provider }
  validates :token, presence: true
  validates :secret, presence: true
  validates :status, presence: true

  enum status: %i[inactive active]
end
