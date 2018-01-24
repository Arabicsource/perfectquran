# frozen_string_literal: true

require 'rails_helper'

describe '/devise/passwords/new' do
  context 'without account' do
    before { get new_account_password_path }

    specify { expect(response).to be_successful }
  end
end
