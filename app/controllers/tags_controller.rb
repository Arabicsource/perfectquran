# frozen_string_literal: true

class TagsController < ApplicationController
  before_action :authenticate_account!
  before_action :load_tag
  before_action :load_taggable
  before_action :check_tag_validity
  before_action :load_tagging

  def create
    if @tagging.save
      notification = { success: 'Alhamdulillah, the tag was added' }
    else
      notification = { error: 'Tag has already been used' }
      @tag.errors.add :tag, 'has already been used'
    end

    respond_to do |format|
      format.html { redirect_to @taggable, flash: notification }
      format.js
    end
  end

  private

  def load_tag
    @tag = Tag.find_or_create_by(name: taggable_params[:name])
  end

  def check_tag_validity
    return if @tag.valid?
    respond_to do |format|
      format.html do
        redirect_to(
          @taggable, flash: { error: @tag.errors.full_messages.first }
        )
      end
      format.js
    end
  end

  def load_taggable
    taggable_id = taggable_params[:taggable_id]
    taggable_type = taggable_params[:taggable_type]

    @taggable = "Quran::#{taggable_type}".constantize.find(taggable_id)
  end

  def load_tagging
    @tagging = @tag.taggings.build(
      account: Current.account, taggable: @taggable
    )
  end

  def taggable_params
    params.require(:tag).permit(:name, :taggable_id, :taggable_type)
  end
end
