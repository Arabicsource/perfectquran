# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :string           default("validating")
#

# :nodoc:
class Account < ApplicationRecord
  default_scope { order('id desc') }

  after_create :create_profile!
  after_create :subscribe_to_newsletter

  has_one :profile
  has_one :subscription
  has_many :connections
  has_many :memories

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  def after_confirmation
    update_attribute(:role, 'member')
  end

  def role?(role)
    role.to_s == self.role
  end

  def name
    profile.name || 'Anonymous'
  end

  def patron?
    subscription
  end

  def memorized_ayahs(surah)
    memorized_ayahs = []

    Quran::Ayah.where(surah: surah).each do |ayah|
      memorized_ayahs << ayah if Memory.find_by(ayah: ayah, account: self)
    end

    memorized_ayahs
  end

  def not_memorized_ayahs(surah)
    not_memorized_ayahs = []

    Quran::Ayah.where(surah: surah).each do |ayah|
      unless Memory.find_by(ayah: ayah, account: self)
        not_memorized_ayahs << ayah
      end
    end

    not_memorized_ayahs
  end

  private

  def subscribe_to_newsletter
    list_id = '3821a40607'
    gibbon = Gibbon::Request.new
    hashed_email = Digest::MD5.hexdigest email

    begin
      gibbon.lists(list_id).members(hashed_email).upsert(body: {email_address: email, status: "subscribed"})      
    rescue => exception
      false
    end
  end
end
