# frozen_string_literal: true

module Quran
  module Ayahs
    # :nodoc:
    class TagsController < Quran::BaseController
      before_action :authenticate_account!, :load_ayah, :load_tag

      def create
        return render :new unless @tag.valid?

        @tagging = @tag.taggings.build(
          account: current_account, taggable: @ayah
        )
        if @tagging.save
          render :create
        else
          @tag.errors.add(:name, 'has been taken')
          render :new
        end
      end

      private

      def tag_params
        params.require(:tag).permit(:name)
      end

      def load_ayah
        @ayah = Ayah.find(params[:ayah_id])
      end

      def load_tag
        @tag = Tag.find_or_create_by(tag_params)
      end
    end
  end
end
