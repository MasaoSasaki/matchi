# アプリ名
matchi(マッチ)

## サイトURL
https://matchi-gourmet.com

## 使用言語・技術
### 言語
HTML/CSS/JavaScript
Ruby 2.6.3

### 技術
#### フレームワーク
Rails 5.2.4.4
#### ライブラリ
jQuery 1.12.4<br>
bootstrap
FontAwesome6
#### 外部API
Google(Google Maps Javascript/Geocoding/CloudVision/CloudTranslation)<br>
Geolocation API
#### インフラ
vagrant/VirtualBox
AWS(EC2/RDS/Route53/Certificate Manager/ALB/WorkMail)
gem(devise/refile/gon/dotenv/rspec-rails/factory_bot_rails)
MySQL 5.7.22

## 設計書
### 機能一覧
https://docs.google.com/spreadsheets/d/1PL8Vu22aXZV1pZ1HRxm-1jaDTiEo3-0xuDglZNBHQAU/edit?usp=sharing
### UI_Flows
https://drive.google.com/file/d/1LztQyxCGOD2N-6csEBf7pIduClr4Nn6e/view?usp=sharing
### ワイヤーフレーム
#### Admin
https://app.diagrams.net/#G1VM1pGoxWLT2YNRkzoPllRSle_7ZphvJJ
#### Restaurant
https://app.diagrams.net/#G1SuIhNph7gwsKGbT5PqGApPnmX2oDUDKx
#### User
https://app.diagrams.net/#G10YV4SXeUFVfdADi93lj3PaYRCEi9UXnX
### ER図
https://drive.google.com/file/d/1hnXInRK9RYaPu5Thr3LIi_D7OeraxxpY/view?usp=sharing
### テーブル定義書
https://docs.google.com/spreadsheets/d/1VMf2UX-NWOjPL_QYcFoSfoyb-yajxOIZCNbMr8Rw3D8/edit?usp=sharing
### アプリケーション詳細設計書
https://docs.google.com/spreadsheets/d/1L9GRDPpyJhKNIP5zVpgR6XrRZwvEIZK7EEckqEJzljw/edit?usp=sharing
### 工程表
https://docs.google.com/spreadsheets/d/1o7G1d2ULM0jHLUxnnvFoi6kzStA8jKAYprJYQZK_cYo/edit#gid=1773513600

## サイトテーマ
飲食店で日々発生する予約キャンセルを有効活用することをテーマにしています。<br>
お客様が予約される段階で飲食店では食材の準備、スタッフの動員などのコストがかかります。<br>
しかし、前日キャンセルや無断キャンセルが発生してしまうと、そこかけたコストは無駄になってしまいます。<br>
キャンセル料などで、無駄になってしまったコストを賄うことはできるかもしれませんが、用意された食材は無駄になってしまい、飲食店としてもそれはできれば避けたいところです。<br>
この両者をマッチングさせて、誰も損をしない仕組みづくりを目指します。<br>

## サイト概要
飲食店と利用者をマッチングするサービス<br>

各テーブルのCRUD処理
Deviseユーザー認証（管理者、店舗、一般会員）<br>
一般会員登録時に確認画面と完了画面の表示、メールアドレス認証<br>
住所自動入力（jquery.jpostal.js,jp_prefecture,CoffeeScript）<br>
画像アップロード（Refile）、プレビュー表示<br>
CloudVisionAPIからタグ自動取得、Cloud Translationでタグの自動翻訳<br>
レコードのJSON形式への変換（gon）<br>
ActionMailer
・お問い合わせ（問合せ主、管理者双方）<br>
・店舗予約（予約者、店舗双方）<br>
Google Maps APIに現在地、及び登録店舗の住所をピンドロップ表示<br>
レスポンシブ対応<br>
.scssファイル（ネスト構造、変数（_variables.scss）を活用）<br>
テンプレートエンジンを一部slim化（別リポジトリで対応。）<br>
layouts/application.html.slim, owner/menus/_form.html.slim, owner/menus/new.html.slim, owner/menus/edit.html.slim<br>
application.jsの一部をCoffeeScriptに変更<br>
 *owner/menus.coffee<br>
BEM記法<br>
管理者画面からタグの新規追加・削除をajaxで実装<br>
RSpec、FactoryBot、capybaraを使ったsystemテスト<br>
ゲストログイン(ログアウト時に情報削除)<br>

※今後、グループサービスとして、飲食以外にも予約が発生するようなサービス（美容、宿泊など）へもスケールすることを想定しています。（独自ポイントを各サービス共通化）<br>

### テーマを選んだ理由
近年、飲食店の団体予約の直前キャンセルや無断キャンセルが話題となり、SNSなどで拡散される行為が目に着きます。<br>
本当は、一次予約の段階で無断キャンセルや直前キャンセルをさせない仕組みづくりが必要になると思いますが、やはりどうしても避けられないこともあります。<br>
それらの課題をIT技術やWEB技術を使って解決できないものかと考えておりました。<br>

### ターゲットユーザ
・飲食店：キャンセルで食材を余らせてしまった飲食店が実際のサービスと同価格もしくは廉価でその料理を出品（尚且つ１次予約者からキャンセル料も取れる可能性があるので、廉価が実現可能か？）<br>
・利用者：飲食店がキャンセル待ちで困ったコース料理など、内容としては自分が100%食べたい物ではないが、「通常より廉価で」「飲食店を助ける（社会貢献）」意味合いから応援予約。<br>
・双方：飲食店は食品ロスを抑えることができる。利用者は廉価で料理を食べ、尚且つその飲食店を助けることができる。<br>

### 主な利用シーン
急遽決まったランチ、ディナー、飲み会等でお店を探すときに現在地近くでどこか困っているお店はないか？となることを想定しています。<br>
情報化社会が進み、「料理の味」はどんどんよくなっていくなかで、次に競うのは「料金設定」になるかと思いますが、それもどこも横並びになっているように思います。（もちろん品質や立地によって差はあります。）<br>
そこにもし、「社会貢献」「ピンチを応援する」という要素が目に見える形で加われば、選ばれやすくなるのではないかと想定しています。<br>
