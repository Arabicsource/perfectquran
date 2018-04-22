# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id                     :bigint(8)        not null, primary key
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

class Account < ApplicationRecord
  default_scope { order('id desc') }

  after_create :create_profile!
  after_create :create_email_preference!
  after_create :subscribe_to_newsletter

  has_one :profile, dependent: :destroy
  has_one :email_preference

  has_many :articles, dependent: :destroy
  has_many :connections
  has_many :account_translations, dependent: :destroy
  has_many :translations, through: :account_translations

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

  def guest?
    false
  end

  private

  def subscribe_to_newsletter
    ::MailingList::Updater.new(email).subscribe
  end
end
