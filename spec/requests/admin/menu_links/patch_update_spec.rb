# frozen_string_literal: true

require 'rails_helper'

describe 'PATCH Admin::MenuLinks#update', type: :request do
  let :update_params do
    { menu_link:
      { name: 'name123', path: 'path123' } }
  end

  let :empty_params do
    { menu_link: { name: '', path: '' } }
  end

  let :error_messages do
    [
      'Name can&#39;t be blank',
      'Path can&#39;t be blank'
    ]
  end

  context 'guest' do
    it 'redirects the user to the login page' do
      menu = create :menu
      menu_link = create :menu_link, menu: menu

      patch(
        "/admin/menus/#{menu.id}/menu_links/#{menu_link.id}",
        params: update_params
      )

      expect(response).to redirect_to new_user_session_path
    end
  end

  context 'member' do
    it 'redirects the user to the root page' do
      menu = create :menu
      menu_link = create :menu_link, menu: menu

      login_as create(:member)

      patch(
        "/admin/menus/#{menu.id}/menu_links/#{menu_link.id}",
        params: update_params
      )

      expect(response).to redirect_to root_path
    end
  end

  context 'admin' do
    describe 'successful submission' do
      it 'redirects to show' do
        menu = create :menu
        menu_link = create :menu_link, menu: menu

        login_as create :admin

        patch(
          "/admin/menus/#{menu.id}/menu_links/#{menu_link.id}",
          params: update_params
        )

        expect(response).to redirect_to admin_menu_path(menu)
      end

      it 'changes the name' do
        menu = create :menu
        menu_link = create :menu_link, menu: menu, name: 'name'

        login_as create :admin

        patch(
          "/admin/menus/#{menu.id}/menu_links/#{menu_link.id}",
          params: update_params
        )

        expect { menu_link.reload.name }.to(
          change { menu_link.name }.from('name').to('name123')
        )
      end

      it 'changes the path' do
        menu = create :menu
        menu_link = create :menu_link, menu: menu, path: 'path'

        login_as create :admin

        patch(
          "/admin/menus/#{menu.id}/menu_links/#{menu_link.id}",
          params: update_params
        )

        expect { menu_link.reload.path }.to(
          change { menu_link.path }.from('path').to('path123')
        )
      end
    end

    describe 'empty submission' do
      it 'does not change the name' do
        menu = create :menu
        menu_link = create :menu_link, menu: menu, name: 'name'

        login_as create :admin

        patch(
          "/admin/menus/#{menu.id}/menu_links/#{menu_link.id}",
          params: empty_params
        )

        expect { menu_link.reload.name }.not_to(change { menu_link.name })
      end

      it 'does not change the path' do
        menu = create :menu
        menu_link = create :menu_link, menu: menu, path: 'path'

        login_as create :admin

        patch(
          "/admin/menus/#{menu.id}/menu_links/#{menu_link.id}",
          params: empty_params
        )

        expect { menu_link.reload.path }.not_to(change { menu_link.path })
      end

      it 'includes error messages' do
        menu = create :menu
        menu_link = create :menu_link, menu: menu

        login_as create :admin

        patch(
          "/admin/menus/#{menu.id}/menu_links/#{menu_link.id}",
          params: empty_params
        )

        error_messages.each do |message|
          expect(response.body).to include message
        end
      end
    end
  end
end
