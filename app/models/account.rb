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
  after_create :create_email_preference!
  after_create :subscribe_to_newsletter

  has_one :profile, dependent: :destroy
  has_one :subscription
  has_one :email_preference

  has_many :articles, dependent: :destroy
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

    Ayah.where(surah: surah).each do |ayah|
      memorized_ayahs << ayah if Memory.find_by(ayah: ayah, account: self)
    end

    memorized_ayahs
  end

  def not_memorized_ayahs(surah)
    not_memorized_ayahs = []

    Ayah.where(surah: surah).each do |ayah|
      unless Memory.find_by(ayah: ayah, account: self)
        not_memorized_ayahs << ayah
      end
    end

    not_memorized_ayahs
  end

  def memorized_percentage(from: nil)

  end

  def memorized_ayahs_count

  end

  def memorized_surahs_count

  end

  def memorized_pages_count

  end

  def memorized_juzs_count

  end

  private

  def subscribe_to_newsletter
    ::MailingList::Updater.new(email).subscribe
  end
end
