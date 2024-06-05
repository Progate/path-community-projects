## PHPでウェブアプリケーションを起動してみよう

### PHPをインストールしよう

PHP をインストールするために、以下のコマンドを実行します。

```terminal
$ sudo apt update
$ sudo apt install php
```

### Apacheのプロセスはいくつ起動してる？

Apache のプロセス数を確認するために、`ps` コマンドを使用します。以下のコマンドを実行して、Apache2 にまつわるプロセスを列挙します。

```terminal
$ ps aux | grep apache2
root       10132  0.0  1.9 202892 18864 ?        Ss   13:33   0:00 /usr/sbin/apache2 -k start
www-data   10134  0.0  0.9 203384  9208 ?        S    13:33   0:00 /usr/sbin/apache2 -k start
www-data   10135  0.0  0.9 203384  9208 ?        S    13:33   0:00 /usr/sbin/apache2 -k start
www-data   10136  0.0  0.9 203384  9208 ?        S    13:33   0:00 /usr/sbin/apache2 -k start
www-data   10137  0.0  0.9 203384  9208 ?        S    13:33   0:00 /usr/sbin/apache2 -k start
www-data   10138  0.0  0.9 203384  9208 ?        S    13:33   0:00 /usr/sbin/apache2 -k start
www-data   10202  0.0  0.1   3740  1412 ?        Ss   13:33   0:00 /usr/bin/htcacheclean -d 120 -p /var/cache/apache2/mod_cache_disk -l 300M -n
ubuntu     10396  0.0  0.2   7008  2304 pts/1    S+   13:34   0:00 grep --color=auto apache2
```

上記の結果を見ると、6 つの Apache2 のプロセスが起動していることがわかります。Apache2 のプロセス数は、サーバーの負荷やアクセス数に応じて変動することがあります。

### どこにphpファイルを置けばブラウザから見られる？

Apache の設定ファイルを確認するために、以下のコマンドを実行します。less コマンドを使用して、`000-default.conf` ファイルを表示します。

```terminal
$ less /etc/apache2/sites-enabled/000-default.conf
<VirtualHost *:80>
        # The ServerName directive sets the request scheme, hostname and port that
        # the server uses to identify itself. This is used when creating
        # redirection URLs. In the context of virtual hosts, the ServerName
        # specifies what hostname must appear in the request's Host: header to
        # match this virtual host. For the default virtual host (this file) this
        # value is not decisive as it is used as a last resort host regardless.
        # However, you must set it for any further virtual host explicitly.
        #ServerName www.example.com

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html

        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with "a2disconf".
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>


```

`000-default.conf` を確認すると、ブラウザからアクセス可能な PHP ファイルを配置する場所は `DocumentRoot` ディレクティブで指定されています。この設定ファイルによると、`DocumentRoot` は `/var/www/html` に設定されています。

これは、Apache サーバーがブラウザからのリクエストを受け取った際に、ファイルを探す基本的なディレクトリを指しています。したがって、PHP ファイルやその他のウェブファイル（HTML、CSS、JavaScript など）をブラウザからアクセス可能にするには、それらを `/var/www/html` ディレクトリ内に配置する必要があります。

例えば、`example.php` という名前の PHP ファイルをブラウザから実行可能にする場合、そのファイルを `/var/www/html` ディレクトリに配置し、ブラウザから `http://your-server-ip/example.php` または `http://your-domain.com/example.php`（適切な IP アドレスやドメイン名に置き換えて）でアクセスします。

この情報に基づいて、PHP ファイルやその他のウェブコンテンツを `/var/www/html` ディレクトリに配置することで、ブラウザからのアクセスが可能になります。

### 実際にアクセスしてみましょう

`/var/www/html` 内を確認してみると、デフォルトの HTML ファイルが配置されていることがわかります。

```terminal
$ ls /var/www/html
index.html
```

これが表示されるかどうかを確認してみましょう。下記の手順で EC2 インスタンスが起動している Web サーバーにブラウザでアクセスしてみましょう。

1. パブリックアドレスの確認
   - EC2 ダッシュボードに移動して、インスタンスのパブリック IPv4 アドレスを確認します。
     - ![image](https://github.com/Progate/path-community-projects/assets/26600620/e60638f9-0a7c-4ee0-a3a6-c511de6121b5)
2. ブラウザでアクセス
   - このとき、HTTPS ではなく HTTP でアクセスすることに気をつけましょう。
3. デフォルトの Apache ウェルカムページが表示されるはずです。
   - ![image]($progatepath{ASSET_URL, 'contents/resources/new_graduate_training/tasks/infrastructure_training/apache2_server.png'})

### ブラウザからアクセスしてSERVER_SOFTWAREの値を確認してみよう

次は PHP ファイルを配置して、PHP の実行結果をブラウザからアクセスしてみましょう。その際、`SERVER_SOFTWARE` の値を確認します。

1. test.php を作成し、以下のコードを記述します。`vi` や `nano` などのエディタを使用して、test.php ファイルを作成します。

    ```terminal
    $ vi test.php
    ```

    ```php
    <?php var_dump($_SERVER);
    ```

    ```sh
    # vi を保存して終了 
    :wq
    ```

2. test.php を `/var/www/html` ディレクトリに配置します。

    ```terminal
    $ sudo mv test.php /var/www/html
    ```

3. ブラウザでアクセスして、`SERVER_SOFTWARE` の値を確認します。

    - `http://[IPアドレス もしくは Public DNS の値]/test.php`

    例えば、以下のような結果が表示されます。

    ```php
    array(32) { ["HTTP_HOST"]=> string(14) "xxx.xxx.xxx.xxx" ["HTTP_CONNECTION"]=> string(10) "keep-alive" ["HTTP_CACHE_CONTROL"]=> string(9) "max-age=0" ["HTTP_UPGRADE_INSECURE_REQUESTS"]=> string(1) "1" ["HTTP_USER_AGENT"]=> string(117) "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36" ["HTTP_ACCEPT"]=> string(96) "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8" ["HTTP_SEC_GPC"]=> string(1) "1" ["HTTP_ACCEPT_LANGUAGE"]=> string(8) "en-US,en" ["HTTP_ACCEPT_ENCODING"]=> string(13) "gzip, deflate" ["PATH"]=> string(70) "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin" ["SERVER_SIGNATURE"]=> string(75) "
    Apache/2.4.58 (Ubuntu) Server at xxx.xxx.xxx.xxx Port 80
    " ["SERVER_SOFTWARE"]=> string(22) "Apache/2.4.58 (Ubuntu)" ["SERVER_NAME"]=> string(14) "xxx.xxx.xxx.xxx" ["SERVER_ADDR"]=> string(12) "172.31.36.76" ["SERVER_PORT"]=> string(2) "80" ["REMOTE_ADDR"]=> string(14) "133.106.241.38" ["DOCUMENT_ROOT"]=> string(13) "/var/www/html" ["REQUEST_SCHEME"]=> string(4) "http" ["CONTEXT_PREFIX"]=> string(0) "" ["CONTEXT_DOCUMENT_ROOT"]=> string(13) "/var/www/html" ["SERVER_ADMIN"]=> string(19) "webmaster@localhost" ["SCRIPT_FILENAME"]=> string(23) "/var/www/html/test.php" ["REMOTE_PORT"]=> string(5) "50368" ["GATEWAY_INTERFACE"]=> string(7) "CGI/1.1" ["SERVER_PROTOCOL"]=> string(8) "HTTP/1.1" ["REQUEST_METHOD"]=> string(3) "GET" ["QUERY_STRING"]=> string(0) "" ["REQUEST_URI"]=> string(10) "/test.php" ["SCRIPT_NAME"]=> string(10) "/test.php" ["PHP_SELF"]=> string(10) "/test.php" ["REQUEST_TIME_FLOAT"]=> float(1711695446.444052) ["REQUEST_TIME"]=> int(1711695446) }

    ```

    この結果から、`SERVER_SOFTWARE` の値が `Apache/2.4.58 (Ubuntu)` であることがわかります。これは、Apache ウェブサーバーが現在実行中であることを示しています。

    ```php
    ["SERVER_SOFTWARE"]=> string(22) "Apache/2.4.58 (Ubuntu)"
    ```

### 判定のためにサーバー情報を.envファイルに記載しよう

次のステップに進む前に、`questions.sh` ファイルに情報を記載してください。判定するために使用します。

```sh
ANSWER_CHECK_SERVER_STATUS_PUBLIC_DNS="ec2-xxx-xxx-xxx-xxx.ap-northeast-1.compute.amazonaws.com"
```
