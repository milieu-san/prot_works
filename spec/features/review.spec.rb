# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'レビュー機能', type: :feature do
  background do
    user = FactoryBot.create(:taro)
    user_2 = FactoryBot.create(:ziro)
    FactoryBot.create(:prot, user_id: user.id)
    FactoryBot.create(:second_prot, user_id: user_2.id)
    FactoryBot.create(:third_prot, user_id: user_2.id)
    FactoryBot.create(:forth_prot, user_id: user_2.id)
    visit '/users/sign_in'
    fill_in 'メールアドレス', with: 'taro@taro.com'
    fill_in 'パスワード', with: 'tarotarotaro'
    click_button 'Log in'
    expect(page).to have_content 'ログインしました。'
    expect(page).to have_content 'taro'
  end

  scenario 'レビュー作成テスト' do
    visit prots_path
    click_on 'タイトル4'
    click_on 'レビューを書く'

    fill_in '議題', with: '新しいレビュー'
    fill_in '本文', with: 'とってもいいですね！'
    click_button '登録する'

    expect(page).to have_content 'レビューの投稿に成功しました'
    expect(page).to have_content 'タイトル4'
    expect(page).to have_content '新しいレビュー'
    expect(page).to have_content 'とってもいいですね！'
  end

  scenario 'レビュー受付していないプロットにレビューを書けないテスト' do
    visit prots_path
    click_on 'タイトル3'
    expect(page).to_not have_content 'レビューを書く'
    visit new_prot_review_path(Prot.find_by(title: 'タイトル3'))
    expect(page).to have_content 'プロットはレビューを受け付けていません'
  end

  feature 'レビュー作成後' do
    background do

    visit prots_path
    click_on 'タイトル4'
    click_on 'レビューを書く'

    fill_in '議題', with: '新しいレビュー'
    fill_in '本文', with: 'とってもいいですね！'
    click_button '登録する'

    expect(page).to have_content 'レビューの投稿に成功しました'
    expect(page).to have_content 'タイトル4'
    expect(page).to have_content '新しいレビュー'
    expect(page).to have_content 'とってもいいですね！'
    end

    scenario 'レビュー編集' do
      click_on 'レビュー編集'
      fill_in '議題', with: '編集したレビュー'
      fill_in '本文', with: 'とってもよくないですね！'
      click_button '更新する'

      expect(page).to have_content 'レビューの編集に成功しました'
      expect(page).to have_content 'タイトル4'
      expect(page).to have_content '編集したレビュー'
      expect(page).to have_content 'とってもよくないですね！'
    end

    scenario 'レビュー削除' do
      click_on 'レビュー削除'
      expect(page).to have_content 'レビューの削除に成功しました'
      expect(page).to have_content 'タイトル4'

      expect(page).to_not have_content '新しいレビュー'
    end
  end
end
