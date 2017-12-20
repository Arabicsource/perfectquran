# frozen_string_literal: true

# :nodoc:
module MemoriesHelper
  def memorized?(ayah, account)
    Memory.where(ayah: ayah, account: account).any?
  end
end
