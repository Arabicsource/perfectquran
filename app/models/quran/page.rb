# frozen_string_literal: true

module Quran
  class Page < ApplicationRecord
    include Ayahable

    belongs_to :juz

    def previous
      @previous ||= if id == 1
                      Quran::Page.last
                    else
                      Quran::Page.find id - 1
                    end
    end

    def next
      @next ||= if id == 604
                  Quran::Page.first
                else
                  Quran::Page.find id + 1
                end
    end

    def reference; end

    def to_s
      "Page #{id}"
    end
  end
end
