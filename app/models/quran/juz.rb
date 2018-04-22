# frozen_string_literal: true

# == Schema Information
#
# Table name: juzs
#
#  id               :bigint(8)        not null, primary key
#  character_length :integer
#

module Quran
  class Juz < ApplicationRecord
    include Ayahable

    include Pageable # depends on Ayahable

    def description
      "#{first_ayah.surah_name}: #{first_ayah.number}"\
      " - #{last_ayah.surah_name}: #{last_ayah.number}"
    end

    def to_s
      "Juz #{id}"
    end
  end
end
