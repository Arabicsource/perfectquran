class AccountTranslation < ApplicationRecord
  default_scope { order(order: :asc) }

  belongs_to :account
  belongs_to :translation
end
