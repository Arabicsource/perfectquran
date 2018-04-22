# frozen_string_literal: true

# == Schema Information
#
# Table name: account_translations
#
#  id             :bigint(8)        not null, primary key
#  account_id     :bigint(8)
#  translation_id :bigint(8)
#  order          :integer          default(0)
#  primary        :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class AccountTranslation < ApplicationRecord
  default_scope { order(order: :asc) }

  belongs_to :account
  belongs_to :translation, class_name: 'Quran::Translation'
end
