RSpec.shared_examples 'commentable' do 
  describe '#visible_comments?' do
    it 'is false when no comments exisit' do
      expect(subject.visible_comments?).to be_falsey
    end

    it 'is false when all comments have been flagged' do
      FactoryGirl.create_list(:comment, 3, :with_flag, commentable: subject)
      expect(subject.visible_comments?).to be_falsey
    end

    it 'is true when no comments have been flagged' do
      FactoryGirl.create_list(:comment, 3, commentable: subject)
      expect(subject.visible_comments?).to be_truthy
    end

    it 'is true when there is a mixture of flagged and unflagged comments' do
      FactoryGirl.create_list(:comment, 3, commentable: subject)
      FactoryGirl.create_list(:comment, 3, :with_flag, commentable: subject)
      expect(subject.visible_comments?).to be_truthy
    end

    it 'is true when comments have been approved' do
      FactoryGirl.create_list(:comment, 3, :with_approval, commentable: subject)
      expect(subject.visible_comments?).to be_truthy
    end
  end
end