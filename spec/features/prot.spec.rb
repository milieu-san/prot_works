# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'プロット機能', type: :feature do
  background do
    user = FactoryBot.create(:taro)
    user_2 = FactoryBot.create(:ziro)
    FactoryBot.create(:prot, user_id: user.id)
    FactoryBot.create(:second_prot, user_id: user_2.id)
    visit '/users/sign_in'
    fill_in 'メールアドレス', with: 'taro@taro.com'
    fill_in 'パスワード', with: 'tarotarotaro'
    click_button 'ログイン'
    expect(page).to have_content 'ログインしました。'
    expect(page).to have_content 'taro'
  end

  scenario 'プロット新規作成' do
    visit new_prot_path
    fill_in 'タイトル', with: '新しいプロット'
    fill_in '概要', with: '今日はいい天気ですこと'
    find(:css, '#prot_genres_attributes_0_name').set('面白ジャンル')
    find(:css, '#prot_media_types_attributes_0_name').set('面白メディア')

    click_button '登録する'

    expect(page).to have_content 'プロットの作成に成功しました'
    expect(page).to have_content '新しいプロット'
    expect(page).to have_content '今日はいい天気ですこと'
    expect(page).to have_content '面白ジャンル'
    expect(page).to have_content '面白メディア'
  end

  scenario 'プロット編集' do
    visit mypage_path
    click_on 'タイトル1'
    click_on 'プロット編集'

    fill_in 'タイトル', with: '真面目に働きたいのです'
    fill_in '概要', with: '昨日までの僕'
    find(:css, '#prot_genres_attributes_0_name').set('暗いやつ')
    find(:css, '#prot_media_types_attributes_0_name').set('ハイパーメディア')

    click_button '更新する'

    expect(page).to have_content 'プロットの編集に成功しました'
    expect(page).to have_content '真面目に働きたいのです'
    expect(page).to have_content '昨日までの僕'
    expect(page).to have_content '暗いやつ'
    expect(page).to have_content 'ハイパーメディア'
  end

  scenario 'プロット削除' do
    visit mypage_path
    click_on 'タイトル1'
    click_on 'プロット削除'
    expect(page).to_not have_content 'タイトル1'
    expect(page).to have_content 'プロットの削除に成功しました'
  end

  scenario 'プロットの公開・非公開をテスト' do
    visit new_prot_path
    fill_in 'タイトル', with: '非公開プロット'
    fill_in '概要', with: '見ないで'
    click_button '登録する'

    expect(page).to have_content 'プロットの作成に成功しました'
    expect(page).to have_content '非公開プロット'
    expect(page).to have_content '見ないで'

    visit prots_path
    expect(page).to_not have_content '非公開プロット'

    visit prot_search_path
    expect(page).to_not have_content '非公開プロット'

    visit new_prot_path
    fill_in 'タイトル', with: '公開プロット'
    fill_in '概要', with: '見て見て'
    uncheck '非公開'

    click_button '登録する'

    expect(page).to have_content 'プロットの作成に成功しました'
    expect(page).to have_content '公開プロット'
    expect(page).to have_content '見て見て'

    visit prots_path
    expect(page).to have_content '公開プロット'

    visit prot_search_path
    expect(page).to have_content '公開プロット'
  end

  scenario '他人の公開・非公開を閲覧できないかテスト' do
    visit prots_path
    expect(page).to_not have_content '他人の非公開'

    visit prot_search_path
    expect(page).to_not have_content '他人の非公開'
  end
end
