# frozen_string_literal: true

require 'rails_helper'

describe 'DELETE Admin::MenuLinks#destroy', type: :request do
  context 'guest' do
    it 'redirects the user to the login page' do
      menu = create :menu
      menu_link = create :menu_link, menu: menu

      delete "/admin/menus/#{menu.id}/menu_links/#{menu_link.id}"

      expect(response).to redirect_to new_user_session_path
    end
  end

  context 'member' do
    it 'redirects the user to the root page' do
      menu = create :menu
      menu_link = create :menu_link, menu: menu
      login_as create(:member)

      delete "/admin/menus/#{menu.id}/menu_links/#{menu_link.id}"

      expect(response).to redirect_to root_path
    end
  end

  context 'admin' do
    describe 'successful submission' do
      it 'redirects to show' do
        menu = create :menu
        menu_link = create :menu_link, menu: menu
        login_as create(:admin)

        delete "/admin/menus/#{menu.id}/menu_links/#{menu_link.id}"

        expect(response).to redirect_to admin_menu_path(menu)
      end

      it 'deletes the menu' do
        menu = create :menu
        menu_link = create :menu_link, menu: menu
        login_as create(:admin)

        expect { delete "/admin/menus/#{menu.id}/menu_links/#{menu_link.id}" }
          .to change(MenuLink, :count).by(-1)
      end
    end
  end
end
