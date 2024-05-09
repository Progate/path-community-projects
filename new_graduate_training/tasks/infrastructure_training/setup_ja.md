# セットアップ

まずはターミナルを開いてコードベースをダウンロードし、タスクを進める準備をしましょう。

## 1. コードベースをダウンロードして解凍し、移動します

以下のコマンドでタスクに利用するソースコードをダウンロードします。

```terminal
$ progate download W5HRkGVjRsa8fzXi53YOU --project-dir new_graduate_training_infrastructure_training --name infra_training
```

次に、VS Code で該当のディレクトリを開きます（参考: [Visual Studio Code のインストール](/articles/install-vscode)）

```terminal
$ code $HOME/progate_path/new_graduate_training_infrastructure_training/infra_training
```

最後に以下のコマンドを実行してカレントディレクトリを移動します。

```terminal
$ cd $HOME/progate_path/new_graduate_training_infrastructure_training/infra_training
```

## 2. 環境のチェックをします

移動ができたら、以下のコマンドを実行してください。

```terminal
$ progate diagnose
```

`progate diagnose` でエラーが出た場合は、ツールがインストールされていないか、バージョンが古い可能性があります。正しいバージョンをインストールしてください。

## 3. 現状を確認します

最後にコードベースの現状を確認します。

以下のコマンドを実行して、現時点でのテスト結果を「チェックアイテム」で確認してみましょう。

```terminal
$ progate submit
```

今のところは、全てのテストが通らなくても問題ありません！

通っているテストを壊さないように注意しながら、残りのチェックアイテムのテストを通していきましょう。

## 4. タスクの内容を確認します

`次のページへ` を押して早速タスクに取りかかりましょう！
