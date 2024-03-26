# セットアップ

まずはターミナルを開いてコードベースをダウンロードし、タスクを進める準備をしましょう。

## 1. コードベースをダウンロードして解凍し、移動します

以下のコマンドでタスクに利用するソースコードをダウンロードします。

```terminal
$ progate download OuXjCiv4N3kTfYUUjW5vs --project-dir http_server --name http_server
```

次に、VS Code で該当のディレクトリを開きます（参考: [Visual Studio Code のインストール](/articles/install-vscode)）

```terminal
$ code $HOME/progate_path/http_server/http_server
```

最後に以下のコマンドを実行してカレントディレクトリを移動します。

```terminal
$ cd $HOME/progate_path/http_server/http_server
```

## 2. 環境のチェックをします

移動ができたら、以下のコマンドを実行してください。

```terminal
$ progate diagnose
```

`progate diagnose` でエラーが出た場合は、下記がインストールされていないか、バージョンが古い可能性があります。正しいバージョンをインストールしてください。

- Node.js

## 3. 必要なパッケージをインストールします

`progate diagnose` のテストが通るようになったら、パッケージをインストールしましょう。

```terminal
$ npm clean-install
```

## 4. 現状を確認します

最後にコードベースの現状を確認します。

以下のコマンドを実行して、現時点でのテスト結果を「チェックアイテム」で確認してみましょう。

```terminal
$ progate submit
```

今のところは、全てのテストが通らなくても問題ありません！

通っているテストを壊さないように注意しながら、残りのチェックアイテムのテストを通していきましょう。

## 5. タスクの内容を確認します

`次のページへ` を押して早速タスクに取りかかりましょう！
