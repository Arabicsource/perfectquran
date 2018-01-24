# frozen_string_literal: true

require 'rails_helper'

describe '/devise/sessions/new' do
  context 'without account' do
    before { get new_account_session_path }

    specify { expect(response).to be_successful }
  end
end
