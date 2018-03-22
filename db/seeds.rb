# frozen_string_literal: true

# texts = YAML.load_file("#{Rails.root}/db/seeds/texts/4.yml")
# texts.each do |t|
#   Text.find_or_create_by!(t)
# end

# texts = File.open("#{Rails.root}/db/seeds/texts/4.txt")
# yyaml = File.open("#{Rails.root}/db/seeds/texts/4.yml", 'w')
# texts.each_with_index do |line, number|
#   yyaml.puts "- translation_id: 4"
#   yyaml.puts "  content: >"
#   yyaml.puts "    #{line.split('|')[2]}"
#   yyaml.puts "  ayah_id: #{number + 1}"
# end

# ayahs = YAML.load_file("#{Rails.root}/db/seeds/ayahs.yml")
# ayahs.each do |ayah|
#   a = Ayah.find(ayah['id'])
#   a.update_attribute(:juz_id, ayah['juz_id'])
# end

# pages = YAML.load_file("#{Rails.root}/db/seeds/pages.yml")
# pages.each do |page|
#   Page.find_or_create_by! page
# end

# juzs = YAML.load_file("#{Rails.root}/db/seeds/juzs.yml")
# juzs.each do |juz|
#   Juz.find_or_create_by! juz
# end

# unless Surah.first
#   surahs = YAML.load_file("#{Rails.root}/db/seeds/surahs.yml")
#   surahs.each do |surah|
#     Surah.find_or_create_by!(id: surah['id']) do |s|
#       s.id = surah['id']
#       s.number_of_ayahs = surah['number_of_ayahs']
#       s.order_of_revelation = surah['order_of_revelation']
#       s.revelation_type = surah['revelation_type']
#       s.permalink = surah['permalink']
#       s.transliterated_name = surah['transliterated_name']
#       s.arabic_name = surah['arabic_name']
#       s.english_name = surah['english_name']
#       s.character_length = surah['character_length']
#       s.percent_of_total = surah['percent_of_total']
#     end
#   end
# end

# # add languages
# unless Language.first
#   languages = YAML.load_file("#{Rails.root}/db/seeds/languages.yml")
#   languages.each do |lang|
#     Language.find_or_create_by!(lang)
#   end
# end

# # add qurans
# unless Translation.first
#   translations = YAML.load_file("#{Rails.root}/db/seeds/translations.yml")
#   translations.each do |translation|
#     Translation.find_or_create_by!(translation)
#   end
# end

# # add ayahs
# unless Ayah.first
#   ayahs = YAML.load_file("#{Rails.root}/db/seeds/ayahs.yml")
#   ayahs.each do |ayah|
#     Ayah.find_or_create_by!(ayah)
#   end
# end

# # add Uthmani text
# unless Text.where(translation_id: 1).first
#   one = YAML.load_file("#{Rails.root}/db/seeds/texts/1.yml")
#   one.each do |t|
#     Text.find_or_create_by!(t)
#   end
# end

# unless Text.where(translation_id: 2).first
#   one = YAML.load_file("#{Rails.root}/db/seeds/texts/2.yml")
#   one.each do |t|
#     Text.find_or_create_by!(t)
#   end
# end

# unless Text.where(translation_id: 3).first
#   sql = File.read("#{Rails.root}/db/seeds/texts/3.sql")
#   sql.each_line do |query|
#     puts query
#     ActiveRecord::Base.connection.execute(query)
#   end
# end
