# == Schema Information
#
# Table name: rolings
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  role_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Roling, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
