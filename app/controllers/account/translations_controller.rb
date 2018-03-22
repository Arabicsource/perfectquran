# frozen_string_literal: true

class Account
  class TranslationsController < Account::BaseController
    def create
      primary = Current.account.account_translations.any? ? false : true

      translation = Current.account.account_translations.build(translation_id: translation_params[:translation_id], primary: primary)

      if translation.save
        flash[:success] = 'Alhamdulillah'
      else
        flash[:error] = 'Alhamdulillah'
      end

      redirect_to edit_account_quran_preference_path
    end

    def destroy
      translation = AccountTranslation.find(params[:id])
      translation.delete
      flash[:success] = 'Alhamdulillah'
      redirect_to edit_account_quran_preference_path
    end

    def update
      AccountTranslation.update_all(primary: false)
      translation = AccountTranslation.find(params[:id])
      translation.update_attribute(:primary, true)
      redirect_to edit_account_quran_preference_path
    end

    private

    def translation_params
      params.require(:account_translation).permit(:translation_id, :primary)
    end
  end
end
