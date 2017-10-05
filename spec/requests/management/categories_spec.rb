# frozen_string_literal: true

require 'rails_helper'

describe 'Category management', type: :request do
  let(:admin) { FactoryGirl.create(:user, :confirmed, :admin) }
  let(:user) { FactoryGirl.create(:user, :confirmed) }
  let(:category) { FactoryGirl.create(:category) }
  let(:category_attributes) { FactoryGirl.attributes_for(:category) }
  let(:params) { { category: category_attributes } }
  let(:update_params) { { category: { name: 'UpdatedName' } } }
  let(:empty_params) { { category: { name: '' } } }

  describe 'GET #index' do
    context 'guest' do
      before { get manage_categories_path }
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'non-admin user' do
      before do
        login_as user
        get manage_categories_path
      end
      specify { expect(response).to redirect_to root_path }
    end

    context 'admin user' do
      before do
        category
        login_as admin
        get manage_categories_path
      end
      specify { expect(response).to be_successful }
    end
  end

  describe 'GET #show' do
    context 'guest' do
      before { get manage_category_path(category) }
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'non-admin user' do
      before do
        login_as user
        get manage_category_path(category)
      end
      specify { expect(response).to redirect_to root_path }
    end

    context 'admin user' do
      before do
        login_as admin
        get manage_category_path(category)
      end
      specify { expect(response).to be_successful }
      specify { expect(response.body).to include category.name }
    end
  end

  describe 'GET #new' do
    context 'geust' do
      before { get new_manage_category_path }
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'non-admin user' do
      before do
        login_as FactoryGirl.create(:user, :confirmed)
        get new_manage_category_path
      end
      specify { expect(response).to redirect_to root_path }
    end

    context 'admin user' do
      before do
        login_as admin
        get new_manage_category_path
      end
      specify { expect(response).to be_successful }
      specify { expect(response.body).to include 'category-form' }
    end
  end

  describe 'POST #create' do
    context 'guest' do
      before { post '/manage/categories', params: params }
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'non-admin user' do
      before do
        login_as user
        post '/manage/categories', params: params
      end
      specify { expect(response).to redirect_to root_path }
    end

    context 'admin' do
      before { login_as admin }

      describe 'successful submission' do
        specify do
          expect { post '/manage/categories', params: params }
            .to change(Category, :count)
          expect(response).to redirect_to manage_categories_path
        end
      end

      describe 'empty submission' do
        specify do
          expect { post '/manage/categories', params: empty_params }
            .not_to change(Category, :count)
          expect(response.body).to include 'Name can&#39;t be blank'
        end
      end
    end
  end

  describe 'Get #edit' do
    context 'guest' do
      before { get edit_manage_category_path(category) }
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'non-admin user' do
      before do
        login_as user
        get edit_manage_category_path(category)
      end
      specify { expect(response).to redirect_to root_path }
    end

    context 'admin user' do
      before do
        login_as admin
        get edit_manage_category_path(category)
      end
      specify { expect(response).to be_successful }
      specify { expect(response.body).to include 'category-form' }
    end
  end

  describe 'PATCH #update' do
    context 'guest' do
      before do
        patch "/manage/categories/#{category.id}", params: update_params
      end
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'non-admin user' do
      before do
        login_as user
        patch "/manage/categories/#{category.id}", params: update_params
      end
      specify { expect(response).to redirect_to root_path }
    end

    context 'admin' do
      before { login_as admin }

      describe 'successful submission' do
        before do
          patch "/manage/categories/#{category.id}", params: update_params
          category.reload
        end
        specify { expect(response).to redirect_to manage_categories_path }
        specify { expect(category.name).to eq update_params[:category][:name] }
      end

      describe 'empty submission' do
        before do
          patch "/manage/categories/#{category.id}", params: empty_params
          category.reload
        end
        specify { expect(response.body).to include 'Name can&#39;t be blank' }
      end
    end
  end
end
