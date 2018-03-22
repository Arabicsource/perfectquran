module AccountHelper
  def translation_select_options
    option_groups_from_collection_for_select(Language.all, :translations, :name, :id, :name, nil)
  end
end