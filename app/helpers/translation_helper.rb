# frozen_string_literal: true

module TranslationHelper
  def translation_select_options
    option_groups_from_collection_for_select(
      Language.available_for_study,
      :translations_available_for_study, :name, :id, :name, nil
    )
  end
end
