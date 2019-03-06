# frozen_string_literal: true

OmniAuth.config.mock_auth[:vkontakte] = OmniAuth::AuthHash.new(
  'provider' => 'vkontakte',
  'uid' => '123545',
  'info' => {
    'email' => 'mail@mail.ru'
  }
)

OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
  'provider' => 'vkontakte',
  'uid' => '123545',
  'info' => {
    'email' => 'mail@mail.ru'
  }
)
