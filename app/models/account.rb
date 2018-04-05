# frozen_string_literal: true

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
