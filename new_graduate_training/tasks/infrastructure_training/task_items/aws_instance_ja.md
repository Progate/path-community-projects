## AWSにインスタンスを立ててみよう

### AWSアカウント作成

下記を元に AWS アカウントを作成してください。

- [AWSアカウント作成](https://aws.amazon.com/jp/)

### インスタンス作成

EC2 インスタンスを作成します。以下の手順に従って、インスタンスを作成してください。

1. **AWSマネジメントコンソールにログイン**: AWS マネジメントコンソールにログインします。アカウント情報を入力してログインしてください。
2. **EC2ダッシュボードにアクセス**: ダッシュボードから「EC2」を選択します。EC2 は Elastic Compute Cloud の略で、AWS の仮想サーバーサービスです。
3. **インスタンスの作成**:「インスタンスの作成」を選択します。インスタンスの作成は、新しい仮想サーバーを立ち上げるための手順です。
   - ![image](https://storage.googleapis.com/zenn-user-upload/cb295726ca6f-20240328.png)
4. **インスタンスの設定**: インスタンスを次のとおりに設定をします。
   - **AMIの選択**: Ubuntu Server 22.04 LTS を選択します。AMI（Amazon Machine Image）は、EC2 インスタンスを起動するためのテンプレートです。
     - ![image](https://storage.googleapis.com/zenn-user-upload/891ca990791c-20240328.png)
   - **インスタンスタイプの選択**: t2.nano を選択します。料金が安いため、学習やテストに適しています。
     - ![image](https://storage.googleapis.com/zenn-user-upload/966376530ab8-20240328.png)
   - **インスタンスの詳細の設定**: デフォルトのままで問題ありません。
   - **ストレージの追加**: デフォルトのままで問題ありません。
   - **タグの追加**: タグは任意ですが、インスタンスを識別するために利用します。
   - **キーペアの設定**: 新しいキーペアを作成し、キーペアをダウンロードします。キーペアはインスタンスに SSH 接続するために必要です。
     - ![image](https://storage.googleapis.com/zenn-user-upload/9b0eb7f99f09-20240328.png)
     - ![image](https://storage.googleapis.com/zenn-user-upload/96b8d61f1909-20240328.png)
     - ダウンロードした `*.pem` ファイルは安全な場所に保存してください。このファイルは他のユーザーに渡さないようにしてください。ダウンロードしたファイルは後で SSH 接続に利用します。`.ssh` ディレクトリに置いておきましょう。
       - `mv ./Downloads/isucon_mac.pem ~/.ssh/`
   - **セキュリティグループの設定**: 新しいセキュリティグループを作成し、SSH（ポート 22）と HTTP（ポート 80）のアクセスを許可します。
     - セキュリティグループの設定で自分の IP アドレスからのみすべての TCP 接続を許可してみよう
     - ![image](https://github.com/Progate/path-community-projects/assets/26600620/04d02537-2efd-482e-acad-b94826c5b463)
   - **インスタンスの確認**: 設定が完了したら Launch instance を選択します。インスタンスを起動するための最終確認画面が表示されます。
     - ![image](https://github.com/Progate/path-community-projects/assets/26600620/0e0c96b4-3101-4d3e-a38d-71d91eec86e8)

### SSH接続

ローカルのホスト PC から AWS EC2 インスタンスへ SSH 接続してみましょう。下記の手順で行います。

1. **SSH鍵のパーミッション設定**: 最初に、SSH 鍵のパーミッションを安全な設定に変更する必要があります。これは、他のユーザーによる鍵ファイルの読み取りを防ぐためです。ターミナルまたはコマンドプロンプトを開き、ダウンロードした pem ファイルに対して次のコマンドを実行します。（パスとファイル名は自分の環境に合わせてください）

    ```sh
    $ chmod 400 ~/.ssh/isucon_mac.pem
    ```

2. **SSH接続コマンド**: SSH 鍵のパーミッションを設定した後、SSH コマンドを使用して EC2 インスタンスに接続します。接続するには、EC2 インスタンスのパブリック DNS またはパブリック IP アドレスが必要です。この情報は、AWS マネジメントコンソールの EC2 ダッシュボードから取得できます。作成したインスタンスを選択 ▶ Connect to instance を選択 ▶ SSH client を選択し、接続までの手順とコマンドを確認します。
   - ![image](https://github.com/Progate/path-community-projects/assets/26600620/a3b62049-df17-472a-933b-5732df3f5e14)
   - 接続コマンドの基本的な形式は以下の通りです。

    ```sh
    $ ssh -i ~/.ssh/isucon_mac.pem ubuntu@your-instance-public-dns.compute.amazonaws.com
    ```

    ここで、`~/.ssh/isucon_mac.pem` はローカルの SSH 鍵ファイルのパス、`your-instance-public-dns` はインスタンスのパブリック DNS またはパブリック IP アドレスに置き換えてください。

   - `Are you sure you want to continue connecting (yes/no/[fingerprint])?` と聞かれたら `Yes` と入力
   - うまくいけば下記のように EC2 内の Ubuntu にログインでき、ターミナルで操作できるようになります。

      ```sh

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

※ EC2 インスタンスへの接続がうまくいかない場合は、インスタンスに関連付けられているセキュリティグループの設定を確認してください。SSH 接続を許可するには、セキュリティグループにてポート 22 での入力を許可する必要があります。自宅以外で接続する場合は、別途 IP アドレスを許可する必要があります。
