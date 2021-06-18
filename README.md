# Nayami2
Nayami2は仕事で発生する日常的な悩みを共有し解決する、悩みマッチングアプリです。  
投稿の閲覧のみであればログインなしでも利用可能です。（ゲストログインも用意しています。）

### **リンク：[Nayami2](https://www.nayami2app.com/)**

## アピールポイント
- インフラ
  - AWSを使い、ALBを通すことで常時SSL通信を行っている点
  - CircleCIを使い、CD/CDパイプラインを構築している点
  - 開発環境にDockerを使用している点
- バックエンド
  - フォロー機能・DM機能・共感（いいね）機能のコントローラーで、APIサーバーとしてフロントエンドからのリクエストに対して
JSONデータを返している点  
**上記を解説した記事：[Qiita](https://qiita.com/ShogoSonoda/items/43eef11bc3c089180c64)**
- フロントエンド
  - JavaScriptでAPIサーバーにfetchでリクエストを送って、非同期通信をしている点
  - UIフレームワークにTailwindCSSを使用し、整ったUI/UXを意識している点
  - レスポンシブ対応している点
- その他
  - rubcopといったコード解析ツールを採用し読みやすいコードを意識している点
  - RSpecにてモデルのバリデーションチェックをしている点

## 使用した技術
- フロントエンド
  - HTML/CSS
  - JavaScript
  - JQuery
  - tailwindCSS
- バックエンド
  - Ruby(3.0)
  - Ruby on Rails(6.1.3)
  - MySQL(8.2.3)
- インフラ
  - AWS(VPC/EC2/S3/RDS)
  - Nginx
  - Puma
  - Docker
- CI/CD
  - CircleCI
  - Capistrano
  - Rubocop
- その他
  - RSpec
  - Git/Github
 
 ## ER図
[![Image from Gyazo](https://i.gyazo.com/e6b35b8e96575befb511a8a959355a04.png)](https://gyazo.com/e6b35b8e96575befb511a8a959355a04)
