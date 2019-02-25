# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'ユーザー機能', type: :feature do
  background do
    user = FactoryBot.create(:taro)
    user_2 = FactoryBot.create(:ziro)
    FactoryBot.create(:prot, user_id: user.id)
    FactoryBot.create(:second_prot, user_id: user.id)
    FactoryBot.create(:third_prot, user_id: user_2.id)
  end

  scenario 'サインアップテスト' do
    visit '/users/sign_up'

    fill_in '名前', with: 'さぶろう'
    fill_in '表示名', with: 'subro'
    fill_in 'メールアドレス', with: 'subro@subro.com'
    fill_in 'パスワード', with: 'subrosubro'
    fill_in '確認用パスワード', with: 'subrosubro'

    # 保留
    # click_button 'Sign up'
    # visit confirmation_url
    #
    # expect(page).to have_content 'アカウントを登録しました'
  end
end
