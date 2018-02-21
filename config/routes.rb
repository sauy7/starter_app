# frozen_string_literal: true

# For details on the DSL available within this file, see
# http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
