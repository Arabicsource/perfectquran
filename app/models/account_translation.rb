# frozen_string_literal: true

class AccountTranslation < ApplicationRecord
  default_scope { order(order: :asc) }

  belongs_to :account
  belongs_to :translation, class_name: 'Quran::Translation'
end
