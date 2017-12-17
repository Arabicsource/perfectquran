# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  content    :text
#  account_id :integer
#  article_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# :nodoc:
class Comment < ApplicationRecord
  belongs_to :account
  belongs_to :article, counter_cache: true
  validates :content, presence: true
end
