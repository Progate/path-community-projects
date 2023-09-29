# セットアップ

まずはターミナルを開いてコードベースをダウンロードし、タスクを進める準備をしましょう。

## 1. コードベースをダウンロードして解凍し、移動します

```terminal
$ progate download TtC8-bEVewTqIKtNZgu_O --project-dir bootcamp_ts_node --name bootcamp_ts_node
$ cd $HOME/progate_path/bootcamp_ts_node/bootcamp_ts_node
```

## 2. 環境のチェックをします

移動ができたら、以下のコマンドを実行してください。

```terminal
$ progate diagnose
```

`progate diagnose` でエラーが出た場合は、下記がインストールされていないか、バージョンが古い可能性があります。正しいバージョンをインストールしてください。

- Node.js
- Git

## 3. 必要なパッケージをインストールします

`progate diagnose` のテストが通るようになったら、パッケージをインストールしましょう。

```terminal
$ npm clean-install
```

## 4. GitHub にリポジトリ作成

課題のコードを公開できるように GitHub のリポジトリを用意しましょう。

- [GitHub](https://github.com/new) にリポジトリを作ってください。
  - リポジトリ名は `bootcamp_ts_node` としてください。
  - リポジトリの可視性は `Public` としてください。

## 5. コードをGitHubに上げる

Git 管理して GitHub にプッシュしましょう。

```terminal
$ git init --initial-branch main
$ git add .
$ git commit -m "initial commit"
```

リモートリポジトリを設定します。

```terminal
$ git remote add origin {リポジトリURL}
```

プッシュします。

```terminal
$ git push -u origin main
```

## 6. 現状を確認します

最後に、コードベースの現状を確認してみましょう。

以下のコマンドを実行して、タスク開始時点でのテスト結果を「全てのテストを通そう」で確認してみましょう。

```terminal
$ progate submit
```

通っているテストを壊さないように注意しながら、残りのチェック項目のテストを通していきます。

## 7. タスクの内容を確認します

今回は下記のタスクが用意されています。内容を確認して取り掛かっていきましょう。

- [TypeScriptの型を修正しよう](./typescript-quiz)
