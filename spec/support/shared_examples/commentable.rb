RSpec.shared_examples 'commentable' do 
  describe '#visible_comments?' do
    it 'is false when no comments exisit' do
      expect(subject.visible_comments?).to be_falsey
    end

    it 'is false when all comments have been flagged' do
      ayah_with_flagged_comments = FactoryGirl.create(:ayah, :with_flagged_comments)
      expect(ayah_with_flagged_comments.visible_comments?).to be_falsey
    end

    it 'is true when no comments have been flagged' do
      ayah_with_comments = FactoryGirl.create(:ayah, :with_comments)
      expect(ayah_with_comments.visible_comments?).to be_truthy
    end

    it 'is true when there is a mixture of flagged and unflagged comments' do
      ayah_with_mixed_commments = FactoryGirl.create(:ayah, :with_mixed_comments)
      expect(ayah_with_mixed_commments.visible_comments?).to be_truthy
    end

    it 'is true when comments have been approved' do
      ayah_with_approved_comments = FactoryGirl.create(:ayah, :with_approved_comments)
      expect(ayah_with_approved_comments.visible_comments?).to be_truthy
    end
  end
end