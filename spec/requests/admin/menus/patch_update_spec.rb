# frozen_string_literal: true

require 'rails_helper'

describe 'PATCH Admin::Menus#update', type: :request do
  let :update_params do
    { menu:
      { name: 'name123', description: 'description123' } }
  end

  let :empty_params do
    { menu: { name: '', description: '' } }
  end

  let :error_messages do
    [
      'Name can&#39;t be blank',
      'Description can&#39;t be blank'
    ]
  end

  context 'guest' do
    it 'redirects the user to the login page' do
      menu = create :menu

      patch "/admin/menus/#{menu.id}", params: update_params

      expect(response).to redirect_to new_account_session_path
    end
  end

  context 'member' do
    it 'redirects the user to the root page' do
      menu = create :menu
      login_as create(:member)

      patch "/admin/menus/#{menu.id}", params: update_params

      expect(response).to redirect_to root_path
    end
  end

  context 'admin' do
    describe 'successful submission' do
      it 'redirects to show' do
        menu = create :menu

        login_as create :admin

        patch "/admin/menus/#{menu.id}", params: update_params

        expect(response).to redirect_to admin_menus_path
      end

      it 'changes the name' do
        menu = create :menu, name: 'name'

        login_as create :admin

        patch "/admin/menus/#{menu.id}", params: update_params

        expect { menu.reload.name }.to(
          change { menu.name }.from('name').to('name123')
        )
      end

      it 'changes the description' do
        menu = create :menu, description: 'description'

        login_as create :admin

        patch "/admin/menus/#{menu.id}", params: update_params

        expect { menu.reload.description }.to(
          change { menu.description }.from('description').to('description123')
        )
      end
    end

    describe 'empty submission' do
      it 'does not change the name' do
        menu = create :menu

        login_as create :admin

        patch "/admin/menus/#{menu.id}", params: empty_params

        expect { menu.reload.name }.not_to(change { menu.name })
      end

      it 'does not change the description' do
        menu = create :menu

        login_as create :admin

        patch "/admin/menus/#{menu.id}", params: empty_params

        expect { menu.reload.description }.not_to(change { menu.description })
      end

      it 'includes error messages' do
        menu = create :menu

        login_as create :admin

        patch "/admin/menus/#{menu.id}", params: empty_params

        error_messages.each do |message|
          expect(response.body).to include message
        end
      end
    end
  end
end
