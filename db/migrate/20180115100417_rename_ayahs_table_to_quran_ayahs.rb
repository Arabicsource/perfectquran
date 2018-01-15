class RenameAyahsTableToQuranAyahs < ActiveRecord::Migration[5.1]
  def change
    rename_table :ayahs, :quran_ayahs
  end
end
