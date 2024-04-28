## AWSにインスタンスを立ててみよう

### AWSアカウント作成

下記を元に AWS アカウントを作成してください。

- [AWS アカウント作成の流れ](https://aws.amazon.com/jp/register-flow/)

### インスタンス作成

EC2 インスタンスを作成します。以下の手順に従って、インスタンスを作成してください。

1. **AWSマネジメントコンソールにログイン**: AWS マネジメントコンソールにログインします。アカウント情報を入力してログインしてください。
2. **EC2のダッシュボードにアクセス**: EC2 とは Elastic Compute Cloud の略で、AWS の仮想サーバーサービスです。コンソール画面の上部にある「サービス」から「EC2」を見つけるか、検索機能をつかってEC2のダッシュボードへ移動しましょう。
3. **インスタンスの作成**:「インスタンスの作成」を選択します。「インスタンス」とは仮想サーバーのことを指しており、このボタンを押すことにより、新しい仮想サーバーを立ち上げる設定画面へ移動できます。
   - ![image](https://storage.googleapis.com/zenn-user-upload/cb295726ca6f-20240328.png)
4. **インスタンスの設定**: インスタンスを次のとおりに設定をします。
   - **名前とタグの設定**: 自分にわかりやすい適当な名前をつけてください。（例：`infra-practice`）
   - **AMIの選択**: Ubuntu Server 22.04 LTS を選択します。AMI（Amazon Machine Image）は、EC2 インスタンスを起動するためのテンプレートです。
     - ![image]($progatepath{ASSET_URL, 'contents/resources/new_graduate_training/tasks/infrastructure_training/ec2_image.png'})
   - **インスタンスタイプの選択**: t2.nano を選択します。料金が安いため、学習やテストに適しています。
     - ![image]($progatepath{ASSET_URL, 'contents/resources/new_graduate_training/tasks/infrastructure_training/ec2_instance_type.png'})
   - **キーペアの設定**: 「新しいキーペアを作成」を押し、以下の画像を参考にしながらキーペアを作成して、キーペアをダウンロードしましょう。キーペアはインスタンスに SSH 接続するために必要です。
     - ![image]($progatepath{ASSET_URL, 'contents/resources/new_graduate_training/tasks/infrastructure_training/ec2_ssh_key.png'})
     - ![image]($progatepath{ASSET_URL, 'contents/resources/new_graduate_training/tasks/infrastructure_training/ec2_ssh_key2.png'})
     - ダウンロードしたファイルは後で SSH 接続に利用します。以下のコマンドを参考にしながら、鍵を`~/.ssh` ディレクトリに移動しておきましょう。ダウンロードした `*.pem` ファイルは非常に重要なものなので、他のユーザーに渡したり、公開したりしないようにしてください。
     - `mv ~/Downloads/xxx.pem ~/.ssh/`
   - **セキュリティグループの設定**: Network settings で新しいセキュリティグループを作成し、SSH（ポート 22）と HTTP（ポート 80）のアクセスを許可します。
     - スクリーンショットでは、Anywhere(`0.0.0.0/0`) で設定していますが、状況によって `My IP` アドレスからのみ許可しても構いません。
     - ![image]($progatepath{ASSET_URL, 'contents/resources/new_graduate_training/tasks/infrastructure_training/ec2_network_settings.png'})
   - **インスタンスの確認**: 設定が完了したら Launch instance を選択します。インスタンスを起動するための最終確認画面が表示されます。
     - ![image]($progatepath{ASSET_URL, 'contents/resources/new_graduate_training/tasks/infrastructure_training/ec2_summary.png'})

### SSH接続

ローカルのホスト PC から AWS EC2 インスタンスへ SSH 接続してみましょう。下記の手順で行います。

1. **SSH鍵のパーミッション設定**: 最初に、ローカルにダウンロードした SSH 鍵のパーミッションを安全な設定に変更する必要があります。これは、他のユーザーによる鍵ファイルの読み取りを防ぐためです。ターミナルまたはコマンドプロンプトを開き、ダウンロードした pem ファイルに対して次のコマンドを実行します。（パスとファイル名は自分の環境に合わせてください）

    ```terminal
    $ chmod 400 ~/.ssh/xxx.pem
    ```

2. **SSH接続コマンド**: SSH 鍵のパーミッションを設定した後、SSH コマンドを使用して EC2 インスタンスに接続します。接続するには、EC2 インスタンスのパブリック DNS またはパブリック IP アドレスが必要です。この情報は、AWS マネジメントコンソールの EC2 ダッシュボードから取得できます。
   1. 作成したインスタンスを選択
   2. Connect to instance を選択
   3. SSH client を選択し、接続までの手順とコマンドを確認
      - ![image](https://github.com/Progate/path-community-projects/assets/26600620/a3b62049-df17-472a-933b-5732df3f5e14)

    接続コマンドの基本的な形式は以下の通りです。

    ```terminal
    $ ssh -i ~/.ssh/xxx.pem ubuntu@your-instance-public-dns.compute.amazonaws.com
    ```

    ここで、`~/.ssh/xxx.pem` はローカルの SSH 鍵ファイルのパス、`your-instance-public-dns` はインスタンスのパブリック DNS またはパブリック IP アドレスに置き換えてください。

   - `Are you sure you want to continue connecting (yes/no/[fingerprint])?` と聞かれたら `Yes` と入力
   - うまくいけば下記のように EC2 内の Ubuntu にログインでき、ターミナルで操作できるようになります。

      ```terminal

      * Documentation:  https://help.ubuntu.com
      * Management:     https://landscape.canonical.com
      * Support:        https://ubuntu.com/pro

        System information as of Thu Mar 28 13:46:21 UTC 2024

        System load:  0.0               Processes:             96
        Usage of /:   20.4% of 7.57GB   Users logged in:       0
        Memory usage: 42%               IPv4 address for eth0: 172.31.36.76
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

      ubuntu@ip-172-31-36-76:~$ 
      ```

#### .ssh/config ファイルの設定

作業中は EC2 インスタンスへの ssh が切れるという問題がよく発生するので、`~/.ssh/config` に下記の指定をしておくと切れにくくなるので便利です。

`~/.ssh/config` がない場合は作成してください。

```text
Host infra-training
  User ubuntu
  Port 22
  IdentityFile 鍵ファイル
  HostName パブリックIPアドレス
  ServerAliveInterval 5
  ServerAliveCountMax 12
```

### 判定のために接続情報を.envファイルに記載しよう

次のステップに進む前に、`.env` ファイルに SSH 接続情報を記載してください。正常に接続できるかどうかを判定するために使用します。

```text
KEY_PATH="~/.ssh/xxxx.pem"
AWS_EC2_HOST="your-instance-public-dns.compute.amazonaws.com"
```

`AWS_EC2_HOST` には、先頭の `ubuntu@` は入れないように注意してください。
