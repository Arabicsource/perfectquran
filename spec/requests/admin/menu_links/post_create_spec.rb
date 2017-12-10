# frozen_string_literal: true

require 'rails_helper'

describe 'Post Admin::MenuLinks#create', type: :request do
  let :valid_params do
    menu_link_attributes = attributes_for :menu_link
    { menu_link: menu_link_attributes }
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

  let :url do
    menu = create :menu
    "/admin/menus/#{menu.id}/menu_links"
  end

  context 'guest' do
    it 'redirects the user to the login page' do
      menu = create :menu
      post "/admin/menus/#{menu.id}/menu_links", params: valid_params

      expect(response).to redirect_to new_user_session_path
    end
  end

  context 'member' do
    it 'redirects the user to the root page' do
      login_as create(:member)

      menu = create :menu
      post "/admin/menus/#{menu.id}/menu_links", params: valid_params

      expect(response).to redirect_to root_path
    end
  end

  context 'admin' do
    describe 'successful submission' do
      it 'redirects to index' do
        login_as create :admin

        menu = create :menu
        post "/admin/menus/#{menu.id}/menu_links", params: valid_params

        expect(response).to redirect_to admin_menu_path(menu)
      end

      it 'increases count by 1' do
        login_as create :admin

        expect { post url, params: valid_params }
          .to change(MenuLink, :count).by(1)
      end
    end

    describe 'empty submission' do
      it 'does not change count' do
        login_as create :admin

        expect { post url, params: empty_params }
          .not_to change(MenuLink, :count)
      end

      it 'includes error messages' do
        login_as create :admin
        menu = create :menu

        post "/admin/menus/#{menu.id}/menu_links", params: empty_params

        error_messages.each do |message|
          expect(response.body).to include message
        end
      end
    end
  end
end
