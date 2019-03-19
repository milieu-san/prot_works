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

  scenario 'サインアップテスト(sign_up mailer confirmable login)' do
    visit '/users/sign_up'

    fill_in '名前', with: 'さぶろう'
    find(:css, '#nameId').set ('subro')
    fill_in 'メールアドレス', with: 'subro@subro.com'
    fill_in 'パスワード', with: 'subrosubro'
    fill_in '確認用パスワード', with: 'subrosubro'

    expect { click_button 'サインアップ' }.to change { ActionMailer::Base.deliveries.size }.by(1)
    expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください'

    mail = ActionMailer::Base.deliveries.last
    body = mail.body.encoded
    url = body[/http[^"]+/]
    visit url

    expect(page).to have_content 'アカウントを登録しました。'

    fill_in 'メールアドレス', with: 'subro@subro.com'
    fill_in 'パスワード', with: 'subrosubro'
    click_button 'ログイン'
  end

  scenario 'サインアップテスト(validation)' do
    visit '/users/sign_up'
    click_button 'サインアップ'
    expect(page).to have_content 'メールアドレスを入力してください'
    expect(page).to have_content 'パスワードを入力してください'
    expect(page).to have_content '名前を入力してください'
    expect(page).to have_content '表示名を入力してください'
    expect(page).to have_content '表示名は不正な値です'
  end

  scenario 'ログインテスト(fill email password by user)' do
    visit '/users/sign_in'
    fill_in 'メールアドレス', with: 'taro@taro.com'
    fill_in 'パスワード', with: 'tarotarotaro'
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました。'
    expect(page).to have_content 'taro'
  end

  scenario 'ログインテスト(validation)' do
    visit '/users/sign_in'
    click_button 'ログイン'
    expect(page).to have_content 'メールアドレス もしくはパスワードが不正です。'
  end

  feature 'ログイン後' do
    background do
      visit '/users/sign_in'
      fill_in 'メールアドレス', with: 'taro@taro.com'
      fill_in 'パスワード', with: 'tarotarotaro'
      click_button 'ログイン'
      expect(page).to have_content 'ログインしました。'
      expect(page).to have_content 'taro'
    end

    scenario 'プロフィール変更' do
      click_on 'プロフィール編集'
      fill_in '名前', with: 'なまーえ'
      fill_in '表示名', with: 'namee'
      fill_in 'プロフィール', with: 'プロフィールですよ'
      click_button '更新する'

      expect(page).to have_content 'なまーえ'
      expect(page).to have_content 'namee'

      click_on 'プロフィール確認'
      expect(page).to have_content 'namee'
      expect(page).to have_content 'プロフィールですよ'
    end

    scenario 'プロフィール変更(validation blank and unique)' do
      click_on 'プロフィール編集'
      fill_in '名前', with: ''
      fill_in '表示名', with: 'ziro'
      click_button '更新する'

      expect(page).to have_content '名前を入力してください'
      expect(page).to have_content '表示名はすでに存在します'

      fill_in '名前', with: ''
      fill_in '表示名', with: ''

      click_button '更新する'
      expect(page).to have_content '名前を入力してください'
      expect(page).to have_content '表示名を入力してください'
    end

    scenario 'Eメール・パスワード変更(not complited yet)' do
      click_on 'edit pass and mail'
    end

    scenario 'ログアウトテスト' do
      click_on 'Logout'
      expect(page).to have_content 'ログアウトしました'
      visit mypage_path
      expect(page).to have_content 'アカウント登録もしくはログインしてください'
    end

    scenario 'アカウント削除テスト(prot_exist?)' do
      click_on 'edit pass and mail'
      click_button 'アカウントを削除する'
      expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております。'

      visit mypage_path
      expect(page).to have_content 'アカウント登録もしくはログインしてください'

      visit '/users/sign_in'
      fill_in 'メールアドレス', with: 'taro@taro.com'
      fill_in 'パスワード', with: 'tarotarotaro'
      click_button 'ログイン'

      expect(page).to_not have_content 'ログインしました。'
      expect(page).to_not have_content 'taro'
      expect(page).to have_content 'メールアドレス もしくはパスワードが不正です。'

      visit '/users/sign_in'
      fill_in 'メールアドレス', with: 'ziro@ziro.com'
      fill_in 'パスワード', with: 'ziroziroziro'
      click_button 'ログイン'
      expect(page).to have_content 'ログインしました。'
      expect(page).to have_content 'ziro'

      visit prots_path
      expect(page).to_not have_content 'タイトル1'
    end
  end
end
