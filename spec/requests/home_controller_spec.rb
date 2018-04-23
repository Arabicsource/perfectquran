# frozen_string_literal: true

require 'rails_helper'

describe 'HomeController', type: :request do
  let(:account) { create :account }

  describe 'GET root_path' do
    before { get root_path }

    specify { expect(response).to be_successful }
    specify { expect(response.body).to include '<title>PerfectQuran</title>' }
  end

  describe 'GET root_path when logged in' do
    before do
      login_as account
      get root_path
    end

    specify { expect(response).to be_successful }
    specify { expect(response.body).to include '<title>PerfectQuran</title>' }
  end

  describe 'GET root_path as mobile' do
    before do
      mobile_browser
      get root_path
    end

    specify { expect(response).to be_successful }
  end
end
