# frozen_string_literal: true

require 'rails_helper'

describe 'content/articles/show' do
  include Devise::Test::ControllerHelpers

  it 'provides a page title' do
    assign :article, create(:article, title: 'title123')
    assign :comment, build(:comment)

    expect(view).to receive(:provide).with(:title, 'title123')

    render
  end

  it 'has a level one heading' do
    assign :article, create(:article, title: 'title123')
    assign :comment, build(:comment)

    render

    expect(rendered).to have_selector 'h1', text: 'title123'
  end

  it 'has a newsletter signup section' do
    allow(view).to receive(:params).and_return(controller: 'content')
    assign :article, create(:article, title: 'title123')
    assign :comment, build(:comment)

    render template: '/content/articles/show', layout: 'layouts/application'

    expect(rendered).to have_css 'section#newsletter'
  end

  it 'has a heading with the article title' do
    assign :article, create(:article, title: 'title123')
    assign :comment, build(:comment)

    render

    expect(rendered).to have_selector 'h1', text: 'title123'
  end

  it 'displays the article content' do
    assign :article, create(:article, content: 'content123')
    assign :comment, build(:comment)

    render

    expect(rendered).to have_content 'content123'
  end

  context 'page' do
    it 'does not display new comment section while logged in' do
      assign :article, create(:article, collection: 'page')
      assign :comment, build(:comment)
      allow(view).to receive(:user_signed_in?).and_return(true)

      render

      expect(rendered).not_to have_selector 'h1', text: 'New Comment'
    end
  end

  context 'post' do
    context 'with comments' do
      it 'displays comments section' do
        article = create :article
        new_comment = build :comment
        create :comment, article: article
        assign :article, article
        assign :comment, new_comment

        render

        expect(rendered).to have_selector 'h1', text: 'Comments'
      end
    end

    context 'without comments' do
      it 'does not display comments section' do
        assign :article, create(:article)
        assign :comment, build(:comment)

        render

        expect(rendered).not_to have_selector 'h1', text: 'Comments'
      end
    end

    context 'while logged in' do
      it 'displays comment form' do
        assign :article, create(:article)
        assign :comment, build(:comment)
        allow(view).to receive(:user_signed_in?).and_return(true)

        render

        expect(rendered).to have_selector 'h1', text: 'New Comment'
      end
    end

    context 'while logged out' do
      it 'does not display the comment section' do
        assign :article, create(:article)
        assign :comment, build(:comment)

        render

        expect(rendered).not_to have_selector 'h1', text: 'New Comment'
      end
    end
  end
end
