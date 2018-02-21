# frozen_string_literal: true

module TestHelpers
  def l(string, options = {})
    I18n.l(string, options)
  end

  def t(string, options = {})
    I18n.t(string, options)
  end
end
