# frozen_string_literal: true

require 'rails_helper'

describe 'DELETE Admin::Categories#destroy', type: :request do
  context 'guest' do
    it 'redirects the user to the login page' do
      category = create :category

      delete "/admin/categories/#{category.id}"

      expect(response).to redirect_to new_user_session_path
    end
  end

  context 'member' do
    it 'redirects the user to the root page' do
      category = create :category
      login_as create(:member)

      delete "/admin/categories/#{category.id}"

      expect(response).to redirect_to root_path
    end
  end

  context 'admin' do
    describe 'successful submission' do
      it 'redirects to show' do
        category = create :category

        login_as create :admin

        delete "/admin/categories/#{category.id}"

        expect(response).to redirect_to admin_categories_path
      end

      it 'deletes the record' do
        category = create :category

        login_as create :admin

        expect { delete "/admin/categories/#{category.id}" }
          .to change(Category, :count).by(-1)
      end
    end
  end
end
