# frozen_string_literal: true

# == Schema Information
#
# Table name: users
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
#  name                   :string
#  username               :string
#  bio                    :string
#
class User < ApplicationRecord
  default_scope { order('id desc') }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: {
              with: /\A\w+\z/,
              message: 'only Letters, numbers and underscores'
            }

  has_many :rolings
  has_many :roles, through: :rolings

  def role
    return 'Admin' if role? :admin
    return 'Member' if role? :member
    'Validating'
  end

  def role?(role)
    user_role = :validating unless confirmed?
    user_role = :member if confirmed?
    user_role = :admin if roles.where(name: :admin).first
    user_role == role
  end
end
