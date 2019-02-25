# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'ユーザー機能', type: :feature do
  background do
    ActionMailer::Base.deliveries.clear
    user = FactoryBot.create(:taro)
    user_2 = FactoryBot.create(:ziro)
    FactoryBot.create(:prot, user_id: user.id)
    FactoryBot.create(:second_prot, user_id: user.id)
    FactoryBot.create(:third_prot, user_id: user_2.id)
  end

  scenario 'サインアップテスト(sign_up mail confirmable login)' do
    visit '/users/sign_up'

    fill_in '名前', with: 'さぶろう'
    fill_in '表示名', with: 'subro'
    fill_in 'メールアドレス', with: 'subro@subro.com'
    fill_in 'パスワード', with: 'subrosubro'
    fill_in '確認用パスワード', with: 'subrosubro'

    # 保留
    expect { click_button 'Sign up' }.to change { ActionMailer::Base.deliveries.size }.by(1)
    expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください'

    mail = ActionMailer::Base.deliveries.last
    body = mail.body.encoded
    url = body[/http[^"]+/]
    visit url

    expect(page).to have_content 'アカウントを登録しました。'

    fill_in 'メールアドレス', with: 'subro@subro.com'
    fill_in 'パスワード', with: 'subrosubro'
    click_button 'Log in'
  end
end
