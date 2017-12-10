# frozen_string_literal: true

module JavascriptHelper
  def fill_in_trix_editor(text)
    execute_script(
      "document.querySelector('trix-editor').editor.insertString('#{text}')"
    )
  end
end
