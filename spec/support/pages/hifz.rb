# frozen_string_literal: true

module Page
  class Hifz
    include Rails.application.routes.url_helpers
    include Capybara::DSL
    include Warden::Test::Helpers

    def initialize
      @surahs = FactoryBot.create_list :surah, 5, :with_ayahs
      login_as FactoryBot.create :account
    end

    def memorize_quran
      visit accounts_memory_path
      click_on 'Memorize All'
    end

    def forget_quran
      visit accounts_memory_path
      click_on 'Forget All'
    end

    def forget_surah
      click_on 'Forget transliterated'
    end

    def visit_surah
      visit accounts_memory_path
      click_on @surahs.first
    end

    def one_hundred_percent_memorized?
      has_text? '0.002% Memorized' # represents 100%
    end

    def zero_percent_memorized?
      has_text? '0% Memorized'
    end

    def has_memorized_surahs?
      has_css? '#memorized .button'
    end

    def has_memorized_ayahs?
      has_css? '#memorized .card'
    end

    def has_not_memorized_surahs?
      has_css? '#not-memorized .button'
    end

    def has_partially_memorized_surahs?
      has_css? '#partially-memorized .button'
    end

    def has_all_surahs_memorized?
      has_css? '#memorized .button', count: 5
    end

    def has_all_surahs_not_memorized?
      has_css? '#not-memorized .button', count: 5
    end

    def has_all_ayahs_not_memorized?
      has_css? '#not-memorized .card', count: 3
    end
  end
end
