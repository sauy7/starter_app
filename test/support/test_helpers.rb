# frozen_string_literal: true

module TestHelpers
  def localize(string, options = {})
    I18n.l(string, options)
  end
  alias l :localize

  def translate(string, options = {})
    I18n.t(string, options)
  end
  alias t :translate
end
