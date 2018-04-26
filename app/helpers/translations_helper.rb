# frozen_string_literal: true

module TranslationsHelper
  def translation_select_options
    option_groups_from_collection_for_select(
      Quran::Language.reading,
      :translations_reading, :name, :id, :name, nil
    )
  end
end
