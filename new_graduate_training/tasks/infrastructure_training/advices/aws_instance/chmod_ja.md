SSH 接続が失敗する場合、下記を確認してください。

- コマンドの鍵のパスが正しいか
- パーミッションが正しいか

## コマンドの鍵のパスが正しいか

AWS 内のコマンドでは下記のようになっています。

```terminal
$ ssh -i "my_key.pem" ubuntu@your-instance-public-dns.compute.amazonaws.com
```

`~/.ssh/my_key.pem` のようにパスが正しいか確認しましょう。

## パーミッションが正しいか

接続時に下記のようなエラー出る場合があります。

```terminal
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@         WARNING: UNPROTECTED PRIVATE KEY FILE!          @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
Permissions 0644 for '/Users/user/.ssh/my_key.pem' are too open.
It is required that your private key files are NOT accessible by others.
This private key will be ignored.
Load key "/Users/user/.ssh/my_key.pem": bad permissions
ubuntu@your-instance-public-dns.compute.amazonaws.com: Permission denied (publickey).
```

これは `my_key.pem` のパーミッションが `0644` になっているためです。パーミッションを変更してください。

```terminal
$ chmod 400 ~/.ssh/my_key.pem
```
