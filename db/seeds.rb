unless Surah.first
  surahs = YAML.load_file("#{Rails.root}/db/seeds/surahs.yml")
  surahs.each do |surah|
    Surah.find_or_create_by!(id: surah['id']) do |s|
      s.id = surah['id']
      s.number_of_ayahs = surah['number_of_ayahs'] 
      s.order_of_revelation = surah['order_of_revelation']
      s.revelation_type = surah['revelation_type']
      s.permalink = surah['permalink']
      s.transliterated_name = surah['transliterated_name']
      s.arabic_name = surah['arabic_name']
      s.english_name = surah['english_name']
      s.character_length = surah['character_length']
      s.percent_of_total = surah['percent_of_total']
    end
  end
end

# add languages
unless Language.first
  languages = YAML.load_file("#{Rails.root}/db/seeds/languages.yml")
  languages.each do |lang|
    Language.find_or_create_by!(lang)
  end
end