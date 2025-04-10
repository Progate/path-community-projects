## AWSにインスタンスを立ててみよう

### はじめに

AWS のアップデートなどにより、実際にある画面と説明にある画面が異なる可能性があります。

お気づきのことがありましたら、コミュニティの[Discord](https://discord.com/invite/pK7KVFefCA)にアクセスし、フィードバックをいただけると大変助かります。

### AWSアカウント作成

下記を元に AWS アカウントを作成してください。

- [AWS アカウント作成の流れ](https://aws.amazon.com/jp/register-flow/)

### インスタンス作成

EC2 インスタンスを作成します。以下の手順に従って、インスタンスを作成してください。

1. **AWSマネジメントコンソールにログイン**: AWS マネジメントコンソールにログインします。アカウント情報を入力してログインしてください。

2. **EC2のダッシュボードにアクセス**: `EC2` とは `Elastic Compute Cloud` の略で、AWS の仮想サーバーサービスです。コンソール画面の上部にある「サービス」から「EC2」を見つけるか、検索機能をつかって EC2 のダッシュボードへ移動してください。

3. **インスタンスの作成ページに移動**:「インスタンスの作成」ボタンを押してください。「インスタンス」とは仮想サーバーのことを指しており、このボタンを押すことにより、新しい仮想サーバーを立ち上げる設定画面へ移動できます。
   - ![image]($progatepath{ASSET_URL, 'contents/resources/new_graduate_training/tasks/infrastructure_training/ec2_launch_instance.png'})

4. **インスタンスの設定/作成**: インスタンスを以下のように設定/作成します。
   - **名前とタグの設定**: 自分にわかりやすい適当な名前をつけてください。（例：`Infra Training`）
   - **AMIの選択**: `Ubuntu Server 24.04 LTS` を選択します。AMI（Amazon Machine Image）は、EC2 インスタンスを起動するためのテンプレートです。
     - ![image]($progatepath{ASSET_URL, 'contents/resources/new_graduate_training/tasks/infrastructure_training/ec2_image.png'})
   - **インスタンスタイプの選択**: `t2.nano` を選択します。料金が安いため、学習やテストに適しています。サインアップ後の最初の 1 年間の無料枠を使っている場合は、`t2.micro` を選択しても問題ありません。
     - ![image]($progatepath{ASSET_URL, 'contents/resources/new_graduate_training/tasks/infrastructure_training/ec2_instance_type.png'})
   - **キーペアの設定**:「新しいキーペアを作成」を押し、以下の画像を参考にキーペアを作成/ダウンロードしましょう。キーペアはインスタンスに SSH 接続するために必要です。（例：`my_key`）
     - ![image]($progatepath{ASSET_URL, 'contents/resources/new_graduate_training/tasks/infrastructure_training/ec2_ssh_key.png'})
     - ![image]($progatepath{ASSET_URL, 'contents/resources/new_graduate_training/tasks/infrastructure_training/ec2_ssh_key2.png'})
     - ダウンロードしたファイルは後で SSH 接続に利用します。以下のコマンドを参考に鍵を `~/.ssh` ディレクトリに移動しておきましょう。ダウンロードした `xxx.pem` ファイルは非常に重要なものなので、他のユーザーに渡したり、公開したりしないようにしてください。

       ```terminal
       $ mv ~/Downloads/xxx.pem ~/.ssh/
       ```

   - **セキュリティグループの設定**: ネットワーク設定で「セキュリティグループを作成」を選択し、SSH（ポート 22）と HTTP（ポート 80）のアクセスを許可します。
     - 以下の画像では、Anywhere(`0.0.0.0/0`) で設定していますが、この設定では世界中からアクセスが可能となってしまいます。制限をかけたい場合は、 `My IP` アドレスからのみ許可するなどの設定が可能です。
     - ![image]($progatepath{ASSET_URL, 'contents/resources/new_graduate_training/tasks/infrastructure_training/ec2_network_settings.png'})
   - **インスタンスの作成**: 設定が問題ないことを確認したら、「インスタンスの作成」を選択しインスタンスを起動します。
     - ![image]($progatepath{ASSET_URL, 'contents/resources/new_graduate_training/tasks/infrastructure_training/ec2_summary.png'})
   - **インスタンスの確認**: EC2 のインスタンス一覧を確認し、以下の画像のように実行状態のインスタンスが起動できていれば OK です。
     - ![image]($progatepath{ASSET_URL, 'contents/resources/new_graduate_training/tasks/infrastructure_training/ec2_launch_success.png'})

### SSH接続

ローカルのホスト PC から、先ほど作成した AWS EC2 インスタンスへ SSH 接続してみましょう。以下の手順で行います。

1. **SSH鍵のパーミッション設定**: 最初に、ローカルにダウンロードした SSH 鍵のパーミッションを安全な設定に変更する必要があります。これは、他のユーザーによる鍵ファイルの読み取りを防ぐためです。ターミナルを開き、ダウンロードした pem ファイルに対して次のコマンドを実行します。（パスとファイル名は自分の環境に合わせてください）

    ```terminal
    $ chmod 400 ~/.ssh/xxx.pem
    ```

2. **SSHコマンドをつかって接続**: SSH 鍵のパーミッションを設定した後、SSH コマンドを使用して EC2 インスタンスに接続します。接続するには、EC2 インスタンスのパブリック DNS またはパブリック IP アドレスが必要です。この情報は、AWS マネジメントコンソールの EC2 ダッシュボードから取得できます。
   1. 作成したインスタンスを選択
   2. 「Connect to instance」もしくは「接続」をクリック
   3. 「SSH client」を選択し、接続までの手順とコマンドを確認
      - ![image]($progatepath{ASSET_URL, 'contents/resources/new_graduate_training/tasks/infrastructure_training/connect_to_instance.png'})

    以下のコマンドでインスタンスに SSH 接続してください。
    ここで、`~/.ssh/xxx.pem` はローカルの SSH 鍵ファイルのパス、`your-instance-public-dns` はインスタンスのパブリック DNS またはパブリック IP アドレスに置き換えてください。

    ```terminal
    $ ssh -i ~/.ssh/xxx.pem ubuntu@your-instance-public-dns.compute.amazonaws.com
    ```

   - `Are you sure you want to continue connecting (yes/no/[fingerprint])?` と聞かれたら `Yes` と入力
   - うまくいけば下記のように EC2 内の Ubuntu にログインでき、ターミナルで操作できるようになります。

      ```terminal
      Welcome to Ubuntu 24.04.2 LTS (GNU/Linux 6.8.0-1024-aws x86_64)

        * Documentation:  https://help.ubuntu.com
        * Management:     https://landscape.canonical.com
        * Support:        https://ubuntu.com/pro

        System information as of Wed Apr  9 07:58:17 UTC 2025

          System load:  0.0               Processes:             105
          Usage of /:   25.0% of 6.71GB   Users logged in:       0
          Memory usage: 41%               IPv4 address for enX0: 172.31.34.243
          Swap usage:   0%

      Expanded Security Maintenance for Applications is not enabled.

      0 updates can be applied immediately.

      Enable ESM Apps to receive additional future security updates.
      See https://ubuntu.com/esm or run: sudo pro status


      The list of available updates is more than a week old.
      To check for new updates run: sudo apt update


      The programs included with the Ubuntu system are free software;
      the exact distribution terms for each program are described in the
      individual files in /usr/share/doc/*/copyright.

      Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
      applicable law.

      To run a command as administrator (user "root"), use "sudo <command>".
      See "man sudo_root" for details.

      ubuntu@ip-172-31-34-243:~$
      ```

### .ssh/config ファイルの設定

作業中に EC2 インスタンスへの ssh が切れるという問題を避けたり、鍵のファイルを都度指定する手間を省くため、`~/.ssh/config` というファイルに下記のような設定をしておくことをお勧めします。

```text
Host infra-training
  User ubuntu
  Port 22
  IdentityFile ~/.ssh/xxx.pem
  HostName 先ほどコピーしたパブリックIPアドレスかDNS名
  ServerAliveInterval 5
  ServerAliveCountMax 12
```

上記の設定をすることで、以下のような簡単なコマンドで ssh による接続ができるようになります。

```terminal
$ ssh infra-training
```

### 判定のために接続情報を.envファイルに記載しよう

次のステップに進む前に、`questions.sh` ファイルに SSH 接続情報を記載してください。正常に接続できるかどうかを判定するために使用します。

```sh
KEY_PATH="~/.ssh/xxx.pem"
AWS_EC2_HOST="your-instance-public-dns.compute.amazonaws.com"
```

`AWS_EC2_HOST` には、先頭の `ubuntu@` は入れないように注意してください。
