# Terraform(AWS), Ansible, CapistraonoでRailsアプリを構築＆デプロイするテンプレート

## Terraform(AWS)

EC2, RDS, LBの標準的なWebアプリケーション構成のインフラを構築します。  
作成時のバージョンは`0.12.0`

## Ansible

Amazon Linux2の環境に指定したバージョンのRubyをインストールし、  
Gitで管理されたRailsアプリケーションをCapistranoを利用しデプロイします。

NginxとLogrotateの設定もあるのでお好みでご利用ください。
作成時のバージョンは`2.6.0`

## Capistrano

対象サーバ内の別ディレクトリでbundle installさせ自分自身(localhost)を対象にデプロイします。  
そのために必要な設定ファイルを置いてありますのでアプリ名などを書き換えてご使用ください。

作成時のバージョンは`3.11.0`
