# README

# Prot Works

## 概要
シナリオの骨組みとなるプロットを書き、読み、ユーザー間で議論することができます。  

## コンセプト
シナリオライティングスキルと高めるためのコミュニケーションサイト  

## version

* Ruby 2.6.4
* Rails 6.0.0
* postgresql

## 機能一覧

* ログイン・サインアップ
  * 名前(日本語)
  * ニックネーム(アルファベット)
  * email
  * アイコン画像  
* ユーザー情報編集機能
* ユーザーお気に入り機能
* プロット執筆、投稿、編集、削除
  * プロットには不特定のユーザーから評価を受け取れる。
  * プロットのジャンル、カテゴリーを設定できる
* プロットのレビュー,投稿、編集、削除
  * レビューに対して評価を受け取れる
* レビューに対するコメント
* プロットの検索機能

## カタログ設計
https://docs.google.com/spreadsheets/d/1ytWXClJxOAVE3lIC8EWCSmYRANIMf2vZqqD-2FHIf6Y/edit?usp=sharing

## テーブル定義
https://docs.google.com/spreadsheets/d/1qlWxLd0_Ooub6MspCnXEtDTFu5nnkpQqxRVN6RMM0uE/edit?usp=sharing

## 画面遷移図
https://drive.google.com/file/d/10fCxojkqgM-ovZq-xsGVNkyOqv80gEzX/view?usp=sharing

## ワイヤーフレーム
https://drive.google.com/file/d/1OpXulx3VJVzsguchW78iz3pmN585thvA/view?usp=sharing

## ER図

https://drive.google.com/file/d/11nKdh1dpYTqYih9vPAxl1MtEIhrr9-9T/view?usp=sharing

## 使用予定Gem

* mini_magick
* carrierwave
* devise
