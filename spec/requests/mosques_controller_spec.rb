# frozen_string_literal: true

require 'rails_helper'

describe 'MosquesController', type: :request do
  let(:mosque) { create :mosque }

  describe 'GET mosque_path' do
    before { get mosque_path(mosque) }

    specify { expect(response).to be_successful }
  end
end
