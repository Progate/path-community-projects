# 解説

このタスクでは、AWS にインスタンスを立て、そのインスタンス上で Web サーバーを運用するための一連のプロセスについて体験しました。

これらの作業を通じて、クラウドリソースの利用方法、Linux サーバーの基本操作、Web サーバーの設定方法、サーバーの監視方法など、実際のサーバー運用に必要な知識を身につけることができます。

改めて振り返りましょう。

## やったことの流れ

1. **AWSアカウントの作成**: クラウドリソースを利用するための第一歩。
2. **EC2インスタンスの立ち上げ**: サーバーとして利用する仮想マシンの作成。
3. **SSH接続**: インスタンスへの安全なリモート接続の確立。
4. **サーバーの状態確認**: プロセス、メモリ、ディスク使用量の確認。
5. **PHPとnginxのインストールと設定**: Web サーバーソフトウェアのセットアップと PHP の実行環境の構築。
6. **負荷テストとシステム監視ツールの使用**: サーバーのパフォーマンス評価とモニタリング。

## 学べる知識

- **AWSの基本操作**: クラウドサービスを使用したリソースの管理方法。
- **Linuxサーバーの基本**: SSH 接続、ファイル操作、プロセス管理などの基礎知識。
- **Webサーバーの設定**: PHP の動作環境の構築と nginx を使用したリバースプロキシの設定。
- **サーバー監視**: `htop` や `dstat` を使用したリアルタイムのシステム監視方法。
- **パフォーマンス評価**: 負荷テストを通じたサーバーの性能評価方法。

これらの知識は、クラウドコンピューティングの基本から、実際のサーバー運用のノウハウまでを幅広くカバーしており、Web サービスの開発から運用に至るまでの一連の流れを理解するための良い出発点となります。

## 使ったコマンド

### chmod

権限を変更するコマンド。ファイルやディレクトリに対して、読み取り、書き込み、実行の権限を設定する。

```terminal
$ chmod 400 ~/.ssh/xxx.pem
```

### mv

ファイルやディレクトリを移動するコマンド。ファイルを移動する際に使用する。

```terminal
$ mv ./Downloads/xxx.pem ~/.ssh/
```

### ssh

リモートサーバーに安全に接続するためのコマンド。SSH 鍵を使用してリモートサーバーに接続する。

```terminal
$ ssh -i ~/.ssh/xxx.pem ubuntu@your-instance-public-dns.compute.amazonaws.com
```

### ps aux

システム上で実行中のプロセスの一覧を表示するコマンド。

```terminal
$ ps aux
```

また、以下のコマンドを組み合わせてプロセス数を取得できる。

```terminal
$ ps aux | tail -n+2 | wc -l
$ ps aux | grep apache2
```

### top

システムのリソース使用状況をリアルタイムで表示するコマンド。

```terminal
$ top
```

### df -h

ディスクの使用量を確認するコマンド。ディスクの空き容量や使用量を確認する。

```terminal
$ df -h
```

### which

コマンドのパスを表示するコマンド。指定したコマンドのパスを表示する。

```terminal
$ which nginx
```

### apt

パッケージのインストールやアップデートを行うためのコマンド。パッケージ管理システムを使用してソフトウェアのインストールやアップデートを行う。

```terminal
$ apt install nginx
```

### sudo

管理者権限でコマンドを実行するためのコマンド。特権を持つユーザーとしてコマンドを実行する。

```terminal
$ sudo apt update
```

### less

ファイルの内容をページ単位で表示するコマンド。ファイルの内容を閲覧する際に使用する。

```terminal
$ less /etc/apache2/sites-enabled/000-default.conf
```

### vi

テキストエディタを起動するコマンド。ファイルの編集や閲覧ができる。

```terminal
$ vi /etc/nginx/sites-available/default
```

### systemctl

systemd を操作するためのコマンド。サービスの起動、停止、再起動などを行う。

```terminal
# apache2の状態を見る
$ sudo systemctl status apache2

# apache2を再起動
$ sudo systemctl restart apache2

# apache2の設定を再読み込み
$ sudo systemctl reload apache2

# apache2を止める
$ sudo systemctl stop apache2

# マシンを再起動したときに apache2 を自動起動する
$ sudo systemctl enable apache2

# マシンを再起動したときに apache2 を自動起動しないようにする
$ sudo systemctl disable apache2
```

### ls

ディレクトリの内容を表示するコマンド。ファイルやディレクトリの一覧を表示する。

```terminal
$ ls /etc/php/8.3/fpm/pool.d/
```

### cat

ファイルの内容を表示するコマンド。ファイルの内容を表示する際に使用する。

```terminal
$ cat /etc/php/8.3/fpm/php-fpm.conf
```

### nginx

nginx のコマンド。nginx の設定ファイルの構文チェックや再読み込みを行う。

```terminal
$ sudo nginx -t
$ sudo systemctl reload nginx
```

### ln

`ln -s` コマンドは、シンボリックリンク（シンボリックリンクは「ソフトリンク」とも呼ばれます）を作成するために使用されます。シンボリックリンクは、あるファイルやディレクトリへの参照であり、実際のファイルやディレクトリ自体ではありません。これは Windows のショートカットや Mac のエイリアスに似ていますが、ファイルシステムレベルで実装されています。

`ln -s` コマンドの一般的な構文は次のとおりです。

```terminal
$ ln -s [対象] [リンク名]
```

- `[対象]` はリンク先のファイルやディレクトリのパスです。
- `[リンク名]` は作成するシンボリックリンクの名前です。

具体的な使用例として、`/etc/nginx/sites-available/php.conf` を `/etc/nginx/sites-enabled/` ディレクトリにシンボリックリンクとして追加する場合、以下のコマンドを使用しました。

```terminal
$ ln -s /etc/nginx/sites-available/php.conf /etc/nginx/sites-enabled/
```

このコマンドは、`/etc/nginx/sites-available/php.conf` ファイルへのシンボリックリンクを `/etc/nginx/sites-enabled/` ディレクトリ内に作成します。シンボリックリンクの名前はデフォルトで対象ファイル（この場合は `php.conf`）と同じ名前になります。

シンボリックリンクを使用する利点は、元のファイルを移動したりコピーしたりすることなく、複数の場所からそのファイルを参照できることです。また、設定の変更を簡単に有効化・無効化できるため、設定管理が容易になります。

### htop

システムのリソース使用状況をリアルタイムで表示するコマンド。top コマンドの拡張版。

```terminal
$ htop
```

### dstat

システムのリソース使用状況をリアルタイムで表示するコマンド。CPU、メモリ、ディスク、ネットワークの使用状況を表示する。

```terminal
$ dstat -tlamp --top-cpu-adv --top-io-adv
```

## EC2インスタンスの掃除

このタスクで作成した EC2 インスタンスは、AWS マネジメントコンソールから削除できます。インスタンスを削除することで、課金を回避できます。忘れずに停止したり削除したりしましょう。

手順は以下の通りです。

1. AWS マネジメントコンソールにログインします。
2. サービスメニューから EC2 を選択します。
3. インスタンスの一覧から削除するインスタンスを選択します。
4. インスタンスを右クリックし、`インスタンスの状態` > `終了` を選択します。
5. インスタンスの終了を確認します。
