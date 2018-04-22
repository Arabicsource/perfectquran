# frozen_string_literal: true

module TranslationsHelper
  def translation_select_options
    option_groups_from_collection_for_select(
      Quran::Language.available_for_quran,
      :translations_available_for_quran, :name, :id, :name, nil
    )
  end
end
