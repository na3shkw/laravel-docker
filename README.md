# laravel-docker
Docker ComposeによるLaravelの開発環境（Apache+MySQL+phpMyAdmin+Mailhog）

## 構成
* `php:7.4.7-apache`
    * `localhost`でアクセス
    * `composer:1.10.9`
        * スピードアッププラグイン`hirak/prestissimo`\
            並列ダウンロードが可能なComposer2.0にアップグレード次第削除予定
    * `node`
        * Mixによるアセットコンパイルのため
    * `mhsendmail`
        * mailhogでメールを受信するため
* `phpmyadmin/phpmyadmin:5.0.2`
    * データベースの管理と操作
    * `localhost:8080`でアクセス
* `mysql:5.6.48`
    * データは`/docker/mysql`に保存され、永続化されます
* `mailhog/mailhog`
    * メールのテスト環境
    * `localhost:8025`でアクセス

## ビルドと起動
1. このリポジトリのクローン
    `git clone https://github.com/na3shkw/laravel-docker.git`
2. クローンしたディレクトリに移動\
    `cd laravel-docker`
3. `.env`を作成し初期化\
    `make init`
4. ビルド\
    `make build`
5. 起動\
    `make up`

## Laravelプロジェクトの開発
### プロジェクトの配置
`/src`にLaravelプロジェクトを配置または新規作成します。

### `.env`の設定
#### データベース
```
DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=
DB_USERNAME=root
DB_PASSWORD=securerootpassword
```

#### メール
```
MAIL_DRIVER=smtp
MAIL_HOST=mailhog
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
```

### コンテナのシェルの利用
`make bash`でコンテナのシェルに`devuser`としてログインできます。`root`としてログインしたい場合は`make bashroot`が利用できます。

## makeで利用可能なコマンド一覧
| コマンド | 動作 |
| -- | -- |
| build | すべてのサービスのビルド |
| up | すべてのコンテナを作成し、バックグラウンドで起動 |
| down | すべてのコンテナ・ネットワークの破棄 |
| stop | すべてのサービスの停止 |
| init | `.env`の初期化 |
| restart | すべてのコンテナを再起動 |
| bash | アプリコンテナ（php-apache）のシェルに`devuser`でログイン |
| bashroot | アプリコンテナ（php-apache）のシェルに`root`でログイン |

## To Do
* [ ] データベースに作業ユーザーを作成し、rootを使わないようにする
