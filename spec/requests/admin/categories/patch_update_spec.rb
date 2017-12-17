# frozen_string_literal: true

require 'rails_helper'

describe 'PATCH Admin::Categories#update', type: :request do
  let :update_params do
    { category:
      { name: 'name123', description: 'description123' } }
  end

  let :empty_params do
    { category: { name: '', description: '' } }
  end

  let :error_messages do
    [
      'Name can&#39;t be blank',
      'Description can&#39;t be blank'
    ]
  end

  context 'guest' do
    it 'redirects the user to the login page' do
      category = create :category

      patch "/admin/categories/#{category.id}", params: update_params

      expect(response).to redirect_to new_account_session_path
    end
  end

  context 'member' do
    it 'redirects the user to the root page' do
      category = create :category
      login_as create(:member)

      patch "/admin/categories/#{category.id}", params: update_params

      expect(response).to redirect_to root_path
    end
  end

  context 'admin' do
    describe 'successful submission' do
      it 'redirects to show' do
        category = create :category

        login_as create :admin

        patch "/admin/categories/#{category.id}", params: update_params

        expect(response).to redirect_to admin_categories_path
      end

      it 'changes the name' do
        category = create :category, name: 'name'

        login_as create :admin

        patch "/admin/categories/#{category.id}", params: update_params

        expect { category.reload.name }.to(
          change { category.name }.from('name').to('name123')
        )
      end

      it 'changes the description' do
        category = create :category, description: 'description'

        login_as create :admin

        patch "/admin/categories/#{category.id}", params: update_params

        expect { category.reload.description }.to(
          change { category.description }
            .from('description').to('description123')
        )
      end
    end

    describe 'empty submission' do
      it 'does not change the name' do
        category = create :category

        login_as create :admin

        patch "/admin/categories/#{category.id}", params: empty_params

        expect { category.reload.name }.not_to(change { category.name })
      end

      it 'does not change the description' do
        category = create :category

        login_as create :admin

        patch "/admin/categories/#{category.id}", params: empty_params

        expect { category.reload.description }
          .not_to(change { category.description })
      end

      it 'includes error messages' do
        category = create :category

        login_as create :admin

        patch "/admin/categories/#{category.id}", params: empty_params

        error_messages.each do |message|
          expect(response.body).to include message
        end
      end
    end
  end
end
