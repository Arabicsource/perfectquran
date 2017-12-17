# frozen_string_literal: true

require 'rails_helper'

describe 'DELETE Admin::Menus#destroy', type: :request do
  context 'guest' do
    it 'redirects the user to the login page' do
      menu = create :menu

      delete "/admin/menus/#{menu.id}"

      expect(response).to redirect_to new_account_session_path
    end
  end

  context 'member' do
    it 'redirects the user to the root page' do
      menu = create :menu
      login_as create(:member)

      delete "/admin/menus/#{menu.id}"

      expect(response).to redirect_to root_path
    end
  end

  context 'admin' do
    describe 'successful submission' do
      it 'redirects to show' do
        menu = create :menu

        login_as create :admin

        delete "/admin/menus/#{menu.id}"

        expect(response).to redirect_to admin_menus_path
      end

      it 'deletes the menu' do
        menu = create :menu

        login_as create :admin

        expect { delete "/admin/menus/#{menu.id}" }
          .to change(Menu, :count).by(-1)
      end
    end
  end
end
