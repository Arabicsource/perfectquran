# frozen_string_literal: true

class TagsController < ApplicationController
  before_action :authenticate_account!
  before_action :load_taggable

  def create
    @tag = Tag.find_or_create_by(name: taggable_params[:name])

    unless @tag.valid?
      return respond_to do |format|
        format.html { redirect_to @taggable, flash: { error: @tag.errors.full_messages.first } }
        format.js
      end
    end

    tagging = @tag.taggings.build(account: Current.account, taggable: @taggable)

    if tagging.save
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

  def load_taggable
    taggable_id = taggable_params[:taggable_id]
    taggable_type = taggable_params[:taggable_type]

    @taggable = taggable_type.constantize.find(taggable_id)
  end

  def taggable_params
    params.require(:tag).permit(:name, :taggable_id, :taggable_type)
  end
end
