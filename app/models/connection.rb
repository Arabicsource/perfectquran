# frozen_string_literal: true

# == Schema Information
#
# Table name: connections
#
#  id             :integer          not null, primary key
#  name           :string
#  provider       :string
#  provider_uid   :string
#  token          :string
#  secret         :string
#  account_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  last_ayah_id   :integer          default(0)
#  active         :boolean          default(FALSE)
#  translation_id :integer
#  hashtags       :string
#

# :nodoc:
class Connection < ApplicationRecord
  belongs_to :account
  belongs_to :translation, class_name: 'Quran::Translation'

  validates :name, presence: true
  validates :provider, presence: true
  validates :provider_uid, presence: true, uniqueness: { scope: :provider }
  validates :token, presence: true
  validates :secret, presence: true
  validates :hashtags, length: { maximum: 60 }

  scope :all_active, -> { where(active: true) }

  def self.create_with_omniauth!(auth_hash, account)
    create! do |c|
      c.name = auth_hash[:info][:nickname]
      c.provider = 'twitter'
      c.provider_uid = auth_hash[:uid]
      c.token = auth_hash[:credentials][:token]
      c.secret = auth_hash[:credentials][:secret]
      c.account = account
      c.translation_id = 3
    end
  end
end
