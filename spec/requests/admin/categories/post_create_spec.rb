# frozen_string_literal: true

require 'rails_helper'

describe 'Post Admin::Categories#create', type: :request do
  let :valid_params do
    category_attributes = attributes_for :category
    { category: category_attributes }
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
      post '/admin/categories', params: valid_params

      expect(response).to redirect_to new_account_session_path
    end
  end

  context 'member' do
    it 'redirects the user to the root page' do
      login_as create(:member)
      post '/admin/categories', params: valid_params

      expect(response).to redirect_to root_path
    end
  end

  context 'admin' do
    describe 'successful submission' do
      it 'redirects to index' do
        login_as create :admin

        post '/admin/categories', params: valid_params

        expect(response).to redirect_to admin_categories_path
      end

      it 'increases count by 1' do
        login_as create :admin

        expect { post '/admin/categories', params: valid_params }
          .to change(Category, :count).by(1)
      end
    end

    describe 'empty submission' do
      it 'does not change count' do
        login_as create :admin

        expect { post '/admin/categories', params: empty_params }
          .not_to change(Category, :count)
      end

      it 'includes error messages' do
        login_as create :admin

        post '/admin/categories', params: empty_params

        error_messages.each do |message|
          expect(response.body).to include message
        end
      end
    end
  end
end
