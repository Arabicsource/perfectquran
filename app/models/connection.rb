# frozen_string_literal: true

class Connection < ApplicationRecord
  belongs_to :account
  belongs_to :translation, class_name: 'Quran::Translation'

  before_validation :prepare_hashtags

  validates :name, presence: true
  validates :provider, presence: true
  validates :provider_uid, presence: true, uniqueness: { scope: :provider }
  validates :token, presence: true
  validates :secret, presence: true
  validates :hashtags, length: { maximum: 60 }

  scope :all_active, -> { where(active: true) }
  scope :daily_active, -> { where active: true, frequency: :daily }
  scope :hourly_active, -> { where active: true, frequency: :hourly }

  enum frequency: %i[daily hourly]

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

  def last_ayah_reference
    if last_ayah_id.positive?
      "[#{last_ayah.surah_id}:#{last_ayah.number}]"
    else
      '[0:0]'
    end
  end

  def account_name
    account.name || account.email
  end

  private

  def last_ayah
    @last_ayah ||= Quran::Ayah.find(last_ayah_id)
  end

  def prepare_hashtags
    return unless hashtags.present?

    result = '#' + hashtags.delete(' ')
    self.hashtags = result.gsub('##', '#')
  end
end
