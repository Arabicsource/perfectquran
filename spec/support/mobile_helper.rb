# frozen_string_literal: true

module MobileHelper
  def mobile_browser
    allow_any_instance_of(Browser::Generic).to receive(:mobile?).and_return true
  end
end
