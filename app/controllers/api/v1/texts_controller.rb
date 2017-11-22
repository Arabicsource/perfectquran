# frozen_string_literal: true

module Api
  module V1
    # :nodoc:
    class TextsController < Api::V1::BaseController
      # :nodoc:
      class Text < Quran::Text
        def as_json(options = {})
          super.merge(surah_id: ayah.surah_id, ayah_number: ayah.number)
        end
      end

      # Example GET /api/v1/text/ayah/1/quran/1
      def show
        render json: Text.find_by!(
          ayah_id: params[:ayah_id],
          translation_id: params[:translation_id]
        )
      end
    end
  end
end
