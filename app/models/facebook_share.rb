# == Schema Information
#
# Table name: facebook_shares
#
#  id         :integer          not null, primary key
#  ayah_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FacebookShare < ApplicationRecord
  belongs_to :ayah
end
