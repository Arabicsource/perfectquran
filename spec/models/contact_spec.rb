require 'rails_helper'

RSpec.describe Contact, type: :model do
  subject {  Contact.new(name: 'name', email: 'email', body: 'body') }

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :body }
  end
end
