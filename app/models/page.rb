class Page < ApplicationRecord
  belongs_to :juz

  def reference

  end

  def to_s
    "Page #{id}"
  end
end
