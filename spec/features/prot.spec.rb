# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'プロット機能', type: :feature do
  background do
    user = FactoryBot.create(:taro)
    user_2 = FactoryBot.create(:ziro)
    FactoryBot.create(:prot, user_id: user.id)
    visit '/users/sign_in'
    fill_in 'メールアドレス', with: 'taro@taro.com'
    fill_in 'パスワード', with: 'tarotarotaro'
    click_button 'Log in'
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

  # scenario 'タスク作成のテスト' do
  #   visit root_path
  #   fill_in 'Email', with: 'john@dic.jp'
  #   fill_in 'Password', with: 'aaaaaaaaaa'
  #   click_button 'Log in'
  #
  #   visit new_task_path
  #   fill_in 'タスク名', with: 'maybete'
  #   fill_in 'タスク詳細', with: 'maybetest'
  #   select '2020', from: 'task_deadline_1i'
  #   click_on '登録する'
  #
  #   expect(page).to have_content 'maybete'
  #   expect(page).to have_content '未着手'
  #   expect(page).to have_content '高'
  # end
  #
  # scenario 'タスク詳細のテスト' do
  #   visit root_path
  #   fill_in 'Email', with: 'john@dic.jp'
  #   fill_in 'Password', with: 'aaaaaaaaaa'
  #   click_button 'Log in'
  #
  #   visit root_path
  #   visit @task
  #   expect(page).to have_content 'コンテント１'
  # end
  #
  # scenario 'タスクが作成日時の降順に並んでいるかのテスト' do
  #   visit root_path
  #   fill_in 'Email', with: 'john@dic.jp'
  #   fill_in 'Password', with: 'aaaaaaaaaa'
  #   click_button 'Log in'
  #
  #   visit '/'
  #   expect(all(:css, '.task_content')[0]).to have_content 'コンテント５'
  #   expect(all(:css, '.task_content')[1]).to have_content 'コンテント４'
  #   expect(all(:css, '.task_content')[2]).to have_content 'コンテント３'
  #   expect(all(:css, '.task_content')[3]).to have_content 'コンテント２'
  #   expect(all(:css, '.task_content')[4]).to have_content 'コンテント１'
  # end
  #
  # scenario '終了期日降順ボタンが正常機能しているかのテスト' do
  #   visit root_path
  #   fill_in 'Email', with: 'john@dic.jp'
  #   fill_in 'Password', with: 'aaaaaaaaaa'
  #   click_button 'Log in'
  #
  #   visit root_path
  #   find("option[value='期日降順']").select_option
  #   click_on 'Search'
  #   expect(all(:css, '.task_content')[0]).to have_content 'コンテント２'
  #   expect(all(:css, '.task_content')[1]).to have_content 'コンテント１'
  #   expect(all(:css, '.task_content')[2]).to have_content 'コンテント３'
  #   expect(all(:css, '.task_content')[3]).to have_content 'コンテント４'
  #   expect(all(:css, '.task_content')[4]).to have_content 'コンテント５'
  # end
  #
  # scenario 'タイトル検索が正常に機能しているかテスト' do
  #   visit root_path
  #   fill_in 'Email', with: 'john@dic.jp'
  #   fill_in 'Password', with: 'aaaaaaaaaa'
  #   click_button 'Log in'
  #
  #   visit root_path
  #   fill_in 'task[search]', with: 'タイトル２'
  #   click_on 'Search'
  #   expect(all(:css, '.task_content')[0]).to have_content 'コンテント２'
  # end
  #
  # scenario 'ステータス絞り込みが正常に機能しているかテスト' do
  #   visit root_path
  #   fill_in 'Email', with: 'john@dic.jp'
  #   fill_in 'Password', with: 'aaaaaaaaaa'
  #   click_button 'Log in'
  #
  #   visit root_path
  #   find(:css, '#task_status_s').find("option[value='1']").select_option
  #   click_on 'Search'
  #   expect(all(:css, '.task_content')[0]).to have_content 'コンテント５'
  #   expect(all(:css, '.task_content')[1]).to have_content 'コンテント１'
  # end
  #
  # scenario '上記ステータス絞り込みテスト成功により、他ユーザーのタスクが見られないことを実証' do
  # end
  #
  # scenario '優先度絞り込みが正常に機能しているかテスト' do
  #   visit root_path
  #   fill_in 'Email', with: 'john@dic.jp'
  #   fill_in 'Password', with: 'aaaaaaaaaa'
  #   click_button 'Log in'
  #
  #   visit root_path
  #   select '高', from: 'task[priority]'
  #   click_on 'Search'
  #   expect(all(:css, '.task_content')[0]).to have_content 'コンテント３'
  #   expect(all(:css, '.task_content')[1]).to have_content 'コンテント１'
  # end
  #
  # scenario '優先度順ソートが正常に機能しているかテスト' do
  #   visit root_path
  #   fill_in 'Email', with: 'john@dic.jp'
  #   fill_in 'Password', with: 'aaaaaaaaaa'
  #   click_button 'Log in'
  #
  #   visit root_path
  #   select '優先度順', from: 'task[priority_s]'
  #   click_on 'Search'
  #   expect(all(:css, '.task_content')[0]).to have_content 'コンテント３'
  #   expect(all(:css, '.task_content')[1]).to have_content 'コンテント１'
  #   expect(all(:css, '.task_content')[2]).to have_content 'コンテント４'
  #   expect(all(:css, '.task_content')[3]).to have_content 'コンテント２'
  #   expect(all(:css, '.task_content')[4]).to have_content 'コンテント５'
  # end
end
