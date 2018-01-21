# frozen_string_literal: true

require 'rails_helper'

describe 'POST /quran/ayahs/:ayah_id/tags', type: :request do
  let(:ayah) { create :ayah }
  let(:url) { "/quran/ayahs/#{ayah.id}/tag.js" }
  let(:valid_params) { { tag: { name: 'tag123' } } }
  let(:invalid_params) { { tag: { name: '' } } }

  context 'without account' do
    before { post url, params: valid_params }

    specify { expect(response).to be_unauthorized }
  end

  context 'with account' do
    before { login_as create :account }

    context 'when successful' do
      it 'redirects' do
        post url, params: valid_params

        expect(response).to be_success
      end

      specify do
        expect { post url, params: valid_params }.to change(Tag, :count).by(1)
      end

      specify do
        expect { post url, params: valid_params }.to(
          change(Tagging, :count).by(1)
        )
      end
    end

    context 'when failure' do
      specify do
        expect { post url, params: invalid_params }.not_to change(Tag, :count)
      end

      specify do
        expect { post url, params: invalid_params }.not_to(
          change(Tagging, :count)
        )
      end
    end
  end
end
