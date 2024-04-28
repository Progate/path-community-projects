## nginxを使ってみよう

### aptでnginxをインストールしてみよう

nginx をインストールするには、以下のコマンドを実行します。nginx とは、高性能な HTTP サーバーソフトウェアで、静的なコンテンツを配信するために使用されます。Apache HTTP Server と同様に、Web サーバーとして広く使用されています。

```terminal
$ sudo apt install nginx
```

インストール時に下記のような画面が表示される場合があるので、デフォルトの選択肢で OK します。

- <img width="580" alt="image" src="https://github.com/Progate/path-community-projects/assets/26600620/823ea2a0-ed40-40bf-bf2c-bb9c0a692b88">

### nginxでphp-fpmにリバースプロキシしてみよう

リバースプロキシとは、クライアントからのリクエストを別のサーバーに転送する仕組みのことです。nginx を使用して、PHP リクエストを `php-fpm` にリバースプロキシできます。

これを実現するためには、Nginx の設定ファイル（通常は `/etc/nginx/sites-available/` ディレクトリ内の `*.conf` ファイル）に適切な設定を追加する必要があります。今回は PHP に関する設定なので `/etc/nginx/sites-available/php.conf` に定義しましょう。デフォルトの設定は `/etc/nginx/sites-available/default` にあります。

1. 設定ファイルを開く

    ```terminal
    $ sudo vi /etc/nginx/sites-available/php.conf
    ```

2. `php-fpm` にリクエストを転送する基本的な Nginx の設定を追加します。

    ```nginx
    server {
        listen 80;
        server_name php.aws;
        root /var/www/html;

        location / {
            fastcgi_pass unix:/run/php/php8.1-fpm.sock;
            fastcgi_index index.php;
            include fastcgi_params;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        }
    }
    ```

    ```sh
    # vi を保存して終了
    :wq
    ```

    `server_name` ディレクティブでは `php.aws` を設定しています。この `server_name` を利用することで、リクエストヘッダーに含まれる [Host](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Host) ごとに異なる設定を適用できます。どの設定にもマッチしないリクエストの場合は、 `/etc/nginx/sites-available/default` にあるデフォルトの設定で処理されます。
    
    今回の例では、 `php.aws` というホスト名でアクセスがあったときに、この設定が適用されます。ただし、現時点では `php.aws` というホスト名にアクセスしてもサーバーへ到達できないため、アクセスすることはできません。ホスト名に関する設定はすこし後のステップで行います。

    `location ~ \.php$` ブロックは、リクエストが PHP ファイルにマッチした場合に `php-fpm` に転送するように設定しています。

3. 設定を `/etc/nginx/sites-enabled/` にシンボリックリンクとして追加します。

    ```terminal
    $ sudo ln -s /etc/nginx/sites-available/php.conf /etc/nginx/sites-enabled/
    ```

    このコマンドは、`/etc/nginx/sites-available/` ディレクトリ内の `php.conf` ファイルへのシンボリックリンクを `/etc/nginx/sites-enabled/` ディレクトリに作成します。

    Nginx は、`/etc/nginx/sites-available/` 内の設定は直接読み込んでおらず、`/etc/nginx/sites-enabled/` ディレクトリ内の設定ファイルを読み込んでサーバーの設定を適用します。

    `/etc/nginx/sites-available/` と `/etc/nginx/sites-enabled/` の 2 つのディレクトリを使うことで、利用可能なサイト設定と実際に有効化されているサイト設定を明確に区別できます。

    ちなみに、どの設定ファイルを読み込むかの定義は、`/etc/nginx/nginx.conf` ファイル内の `include` ディレクティブで行われています。

    ```nginx
    include /etc/nginx/sites-enabled/*;
    ```

4. 設定が正しいことを確認するために、`sudo nginx -t` コマンドを実行します。

    ```terminal
    $ sudo nginx -t
    nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
    nginx: configuration file /etc/nginx/nginx.conf test is successful
    ```

5. 設定に問題がなければ、`sudo systemctl reload nginx` コマンドで Nginx を再読み込みします。

    ```terminal
    $ sudo systemctl reload nginx
    ```

これで、Nginx は PHP リクエストを `php-fpm` にリバースプロキシし、PHP アプリケーションを正しく処理する設定を定義できました。

#### 手元のマシンで /etc/hosts を書いてブラウザでアクセスしてみよう

前述したとおり、現状では、ホスト名を `php.aws` にしてアクセスすることができないため、ブラウザでアクセスしても default の設定が適用されてしまいます。ホスト名を自由に設定するために、 `/etc/hosts` ファイルを書き換えていきましょう。

手元のマシンの `/etc/hosts` ファイルを編集することで、ドメインから IP アドレスへのマッピングを手動で設定できます。これにより、特定のドメイン（`php.aws`）でリクエストを行ったときに、指定した IP アドレス（今回でいえばEC2 のパブリック IP アドレス）に向けてリクエストを送ることができるようになり、 server_name をマッチさせることができます。

### ホストマシンの `/etc/hosts` の編集
** EC2 ではなく、ホストマシンの `/etc/hosts` を編集することに注意してください。**

##### /etc/hosts ファイルの編集

1. **/etc/hosts ファイルを開く**

   まず、テキストエディターを使って `/etc/hosts` ファイルを開きます。このファイルを編集するためには、通常、管理者権限が必要です。

   ```terminal
   $ sudo vi /etc/hosts
   ```

2. **ドメインとIPアドレスのマッピングを追加**

   `/etc/hosts` ファイルの末尾に、`php.aws` というドメイン名と、そのドメイン名に対応する IP アドレス（今回は Nginx サーバーが稼働している IP アドレス）を追加します。例えば、EC2 インスタンスの IP アドレスが `xxx.xxx.xxx.xxx` の場合、次のように記述します。

   ```text
   xxx.xxx.xxx.xxx php.aws
   ```

   この行を追加したら、ファイルを保存してエディターを閉じます。

3. **ブラウザで変更を確認**

   `/etc/hosts` ファイルの変更して保存した後、設定が正しく機能しているかを確認するために、`http://php.aws` にアクセスしてみましょう。

   正しく設定されていれば、ブラウザで `http://php.aws` にアクセスした際に、Nginx サーバーが応答を返すはずです。

これを利用して、実際のドメイン名を使用しているかのようにローカル環境でウェブアプリケーションのテストを行うことができます。

**注意:** 実際のウェブサイトやサービスのドメイン名を `/etc/hosts` に追加すると、そのドメイン名への全てのリクエストが `/etc/hosts` に設定した IP アドレスに向けられるため、本番環境へのアクセスが妨げられる可能性があります。テストが終わったら、`/etc/hosts` ファイルから追加した行を削除することをお勧めします。

#### ブラウザからアクセスしてSERVER_SOFTWAREの値を確認してみよう

`http://your-server-ip` または `http://your-domain.com` でアクセスしてみましょう。Apatche のデフォルトのウェルカムページではなく、PHP の情報が表示されるはずです。

SERVER_SOFTWARE の値が `Apache/2.4.52 (Ubuntu)` ではなく、`nginx/1.18.0` になっていることを確認してください。

```php
["SERVER_SOFTWARE"]=> string(12) "nginx/1.18.0"
```
