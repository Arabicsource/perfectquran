class Page < ApplicationRecord
  include Ayahable

  belongs_to :juz

  def previous
    @previous ||= if id == 1
                    Page.last
                  else
                    Page.find id - 1
                  end
  end

  def next
    @next ||= if id == 604
                Page.first
              else
                Page.find id + 1
              end
  end

  def reference

  end

  def to_s
    "Page #{id}"
  end
end
