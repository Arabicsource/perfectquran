# == Schema Information
#
# Table name: shares
#
#  id         :integer          not null, primary key
#  ayah_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Share < ApplicationRecord
  belongs_to :ayah
end
