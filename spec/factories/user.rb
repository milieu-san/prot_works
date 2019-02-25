# frozen_string_literal: true

FactoryBot.define do
  factory :taro, class: User do
    name { 'taro' }
    nick_name { 'taro' }
    email { 'taro@taro.com' }
    password { 'tarotarotaro' }
    confirmed_at { Time.now }
  end

  factory :ziro, class: User do
    name { '二郎' }
    nick_name { 'ziro' }
    email { 'ziro@ziro.com' }
    password { 'ziroziroziro' }
    confirmed_at { Time.now }
  end
end
