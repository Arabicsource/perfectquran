# frozen_string_literal: true

# :nodoc:
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

  def reference; end

  def to_s
    "Page #{id}"
  end

  def memorized?
    character_length == page_memory.character_length
  end

  def memorized_percentage
    (page_memory.character_length / character_length.to_f) * 100
  end

  def memorize
    ayahs.each do |ayah|
      return false unless ayah.memorize
    end
  end

  private

  def page_memory
    if Current.account.guest?
      PageMemory.new
    else
      PageMemory.find_or_initialize_by(account: Current.account, page: self)
    end
  end
end
