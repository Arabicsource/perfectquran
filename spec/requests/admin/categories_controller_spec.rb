# frozen_string_literal: true

require 'rails_helper'

describe Admin::CategoriesController, type: :request do
  let(:admin) { create :admin }
  let(:article) { create :article, category: category }
  let(:category) { create :category }
  let(:member) { create :member }
  let(:invalid_params) { { category: { name: '', description: '' } } }

  let(:valid_params) do
    { category: { name: 'name123', description: 'desc123' } }
  end

  describe 'GET admin_categories_path' do
    context 'as guest' do
      before { get admin_categories_path }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        get admin_categories_path
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before do
        login_as admin
        get admin_categories_path
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'GET admin_category_path' do
    context 'as guest' do
      before { get admin_category_path(category) }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        get admin_category_path(category)
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before do
        login_as admin
        get admin_category_path(category)
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'GET new_admin_category_path' do
    context 'as guest' do
      before { get new_admin_category_path }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        get new_admin_category_path
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before do
        login_as admin
        get new_admin_category_path
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'GET edit_admin_category_path' do
    let(:city) { create :city }

    context 'as guest' do
      before { get edit_admin_category_path(category) }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        get edit_admin_category_path(category)
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before do
        login_as admin
        get edit_admin_category_path(category)
      end

      specify { expect(response).to be_successful }
    end
  end

  describe 'POST admin_categories_path' do
    context 'as guest' do
      before { post admin_categories_path, params: valid_params }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        post admin_categories_path, params: valid_params
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before { login_as admin }

      context 'with valid params' do
        it 'redirects' do
          post admin_categories_path, params: valid_params

          expect(response).to redirect_to admin_categories_path
        end

        specify 'record is created' do
          expect do
            post admin_categories_path, params: valid_params
          end.to change(Category, :count).by(1)
        end
      end

      context 'with invalid params' do
        it 'is unprocessable' do
          post admin_categories_path, params: invalid_params

          expect(response).to be_unprocessable
        end

        specify 'record is not created' do
          expect do
            post admin_categories_path, params: invalid_params
          end.to_not change(Category, :count)
        end
      end
    end
  end

  describe 'PATCH admin_categories_path' do
    context 'as guest' do
      before { patch admin_category_path(category), params: valid_params }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        patch admin_category_path(category), params: valid_params
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before { login_as admin }

      context 'with valid params' do
        before { patch admin_category_path(category), params: valid_params }

        specify { expect(response).to redirect_to admin_categories_path }
        specify { expect(category.reload.name).to eq 'name123' }
      end

      context 'with invalid params' do
        before { patch admin_category_path(category), params: invalid_params }

        specify { expect(response).to be_unprocessable }
        specify { expect(category.reload.name).to eq 'Category' }
      end
    end
  end

  describe 'DELETE admin_category_path' do
    context 'as guest' do
      before { delete admin_category_path(category) }

      specify { expect(response).to redirect_to new_account_session_path }
    end

    context 'as member' do
      before do
        login_as member
        delete admin_category_path(category)
      end

      specify { expect(response).to redirect_to root_path }
    end

    context 'as admin' do
      before { login_as admin }

      context 'when can delete' do
        it 'redirects' do
          delete admin_category_path(category)

          expect(response).to redirect_to admin_categories_path
        end

        specify 'record is deleted' do
          category

          expect { delete admin_category_path(category) }
            .to change(Category, :count).by(-1)
        end
      end

      context 'when cannot delete' do
        it 'is unprocessable' do
          delete admin_category_path(article.category)

          expect(response).to be_unprocessable
        end

        specify 'record is not deleted' do
          article
          expect do
            delete admin_category_path(article.category)
          end.to_not change(Category, :count)
        end
      end
    end
  end
end
