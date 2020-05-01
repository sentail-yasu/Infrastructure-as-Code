# CapistranoでRails環境をデプロイ

サーバ上に直接CapistranoでRailsをデプロイするテンプレートです。  

## Capistrano導入手順

1. Gemfileを参考にcapistranoのgemを追加して下さい。
2. `bundle install`コマンドを実行
3. `cap install`コマンドを実行
4. WebサーバとしてPumaを起動する場合は`Capfile`を参考に追加して下さい。
5. `capistrano/config/deploy.rb`にgiturlやデプロイディレクトリなどを指定して下さい。
6. `capistrano/deploy/{env}.rb`にデプロイするユーザーやssh鍵などを指定して下さい。
