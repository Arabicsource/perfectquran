# frozen_string_literal: true

module Quran
  class Page < ApplicationRecord
    include Ayahable

    belongs_to :juz

    def previous
      previous_id = id > 1 ? id - 1 : 604
      @previous ||= self.class.find previous_id
    end

    def next
      next_id = id == 604 ? 1 : id + 1
      @next ||= self.class.find next_id
    end

    def description
      "Page #{id}"
    end

    def to_s
      "Page #{id}"
    end
  end
end
