# frozen_string_literal: true

class Account < ApplicationRecord
  default_scope { order('id desc') }

  after_create :create_profile!
  after_create :create_email_preference!
  after_create :subscribe_to_newsletter
  after_create :create_memory_total!

  has_one :profile, dependent: :destroy
  has_one :subscription
  has_one :email_preference
  has_one :memory_total, dependent: :destroy

  has_many :articles, dependent: :destroy
  has_many :connections
  has_many :memories
  has_many :surah_memories
  has_many :page_memories
  has_many :juz_memories
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
    if from.nil?
      (memory_total.character_length / 710_630.0) * 100
    else
      memories = Memory.where(account: self, created_at: from..Time.now)
      return 0 unless memories.any?

      characters = memories.map(&:ayah).map(&:character_length).reduce(:+)
      (characters / 710_630.0) * 100
    end
  end

  def memorized_ayahs_count
    memories.count
  end

  def memorized_surahs_count
    memory_total.surah_count
  end

  def memorized_pages_count
    memory_total.page_count
  end

  def memorized_juzs_count
    memory_total.juz_count
  end

  def guest?
    false
  end

  def group_memories_by_day_from(range_start, range_end = Time.now)
    memories.group_by_day(:created_at, range: range_start..range_end).count
  end

  private

  def subscribe_to_newsletter
    ::MailingList::Updater.new(email).subscribe
  end
end
