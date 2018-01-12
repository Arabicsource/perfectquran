class AddTranslationToConnections < ActiveRecord::Migration[5.1]
  def change
    add_reference :connections, :translation, foreign_key: true
  end
end
