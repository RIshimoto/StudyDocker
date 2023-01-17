# studyDocker
## 概要
42Tokyo[^1]の課題の一つ。Dockerを使ったシステム管理。

## 詳細
- Nginxを使ったWebサーバーを、1つのdockerコンテナだけにセットアップ
- コンテナのOSは debian buster
- Webサーバーは、複数のサービスを同時に実行できる
    - そのサービスとはWordPress、phpMyAdmin、MySQL
    - SQLデータベースがWordPressとphpMyAdminで動作する
[^1]:https://42tokyo.jp/
