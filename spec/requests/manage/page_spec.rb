# frozen_string_literal: true

require 'rails_helper'

describe 'Page management', type: :request do
  let(:admin) { FactoryBot.create(:admin) }
  let(:page) { FactoryBot.create(:page) }
  let(:page_attributes) { FactoryBot.attributes_for(:page) }
  let(:params) { { page: page_attributes } }
  let(:update_params) do
    {
      page:
        {
          title: 'UpdatedTitle',
          permalink: 'updatedtitle',
          content: 'UpdatedContent'
        }
    }
  end

  describe 'GET #index' do
    context 'guest' do
      before { get manage_pages_path }
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'non-admin user' do
      before do
        login_as FactoryBot.create(:member)
        get manage_pages_path
      end
      specify { expect(response).to redirect_to root_path }
    end

    context 'admin user' do
      before do
        page
        login_as admin
        get manage_pages_path
      end
      specify { expect(response).to be_successful }
      specify { expect(response.body).to include page.title }
    end
  end

  describe 'GET #show' do
    context 'guest' do
      before { get manage_page_path(page) }
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'non-admin user' do
      before do
        login_as FactoryBot.create(:member)
        get manage_page_path(page)
      end
      specify { expect(response).to redirect_to root_path }
    end

    context 'admin user' do
      before do
        login_as admin
        get manage_page_path(page)
      end
      specify { expect(response).to be_successful }
      specify { expect(response.body).to include page.title }
      specify { expect(response.body).to include page.content }
    end
  end

  describe 'GET #new' do
    context 'geust' do
      before { get new_manage_page_path }
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'non-admin user' do
      before do
        login_as FactoryBot.create(:member)
        get new_manage_page_path
      end
      specify { expect(response).to redirect_to root_path }
    end

    context 'admin user' do
      before do
        login_as admin
        get new_manage_page_path
      end
      specify { expect(response).to be_successful }
    end
  end

  describe 'POST #create' do
    context 'guest' do
      before { post '/manage/pages' }
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'non-admin user' do
      before do
        login_as FactoryBot.create(:member)
        post '/manage/posts'
      end
      specify { expect(response).to redirect_to root_path }
    end

    context 'admin' do
      before { login_as admin }

      describe 'successful submission' do
        specify do
          expect { post '/manage/pages', params: params }
            .to change(Content::Page, :count)
          expect(response).to redirect_to manage_pages_path
        end
      end

      describe 'empty submission' do
        specify do
          empty_params = { page: { title: '', content: '' } }
          expect { post '/manage/pages', params: empty_params }
            .not_to change(Content::Page, :count)
        end
      end
    end
  end

  describe 'Get #edit' do
    context 'guest' do
      before { get edit_manage_page_path(page) }
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'non-admin user' do
      before do
        login_as FactoryBot.create(:member)
        get edit_manage_page_path(page)
      end
      specify { expect(response).to redirect_to root_path }
    end

    context 'admin user' do
      before do
        login_as admin
        get edit_manage_page_path(page)
      end
      specify { expect(response).to be_successful }
    end
  end

  describe 'PATCH #update' do
    context 'guest' do
      before { patch '/manage/pages/' + page.id.to_s }
      specify { expect(response).to redirect_to new_user_session_path }
    end

    context 'non-admin user' do
      before do
        login_as FactoryBot.create(:member)
        patch '/manage/pages/' + page.id.to_s,
              params: { page: page_attributes }
      end
      specify { expect(response).to redirect_to root_path }
    end

    context 'admin' do
      before { login_as admin }

      describe 'successful submission' do
        before do
          patch '/manage/pages/' + page.id.to_s, params: update_params
          page.reload
        end
        specify { expect(response).to redirect_to manage_pages_path }
        specify { expect(page.title).to eq update_params[:page][:title] }
        specify do
          expect(page.content).to eq update_params[:page][:content]
        end
      end

      describe 'empty submission' do
        before do
          empty_params = { page: { title: '', content: '' } }
          patch '/manage/pages/' + page.id.to_s, params: empty_params
          page.reload
        end
        specify { expect(response.body).to include 'Title can&#39;t be blank' }
        specify do
          expect(response.body).to include 'Content can&#39;t be blank'
        end
      end
    end
  end
end
