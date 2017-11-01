# frozen_string_literal: true

RSpec.shared_examples 'commentable' do
  describe '#visible_comments?' do
    it 'is false when no comments exisit' do
      expect(commentable.visible_comments?).to be_falsey
    end

    it 'is false when all comments have been flagged' do
      FactoryBot.create_list(:comment, 3, :with_flag, commentable: commentable)
      expect(commentable.visible_comments?).to be_falsey
    end

    it 'is true when no comments have been flagged' do
      FactoryBot.create_list(:comment, 3, commentable: commentable)
      expect(commentable.visible_comments?).to be_truthy
    end

    it 'is true when there is a mixture of flagged and unflagged comments' do
      FactoryBot.create_list(:comment, 3, commentable: commentable)
      FactoryBot.create_list(:comment, 3, :with_flag, commentable: commentable)
      expect(commentable.visible_comments?).to be_truthy
    end

    it 'is true when comments have been approved' do
      FactoryBot.create_list(
        :comment, 3, :with_approval, commentable: commentable
      )
      expect(commentable.visible_comments?).to be_truthy
    end
  end

  describe 'associations' do
    it do
      is_expected.to(
        have_many(:comments_and_included_users).class_name('Comment')
      )
    end
  end
end
