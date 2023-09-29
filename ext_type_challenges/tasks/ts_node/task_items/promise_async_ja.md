# Promise と async/await の記法について理解しよう

## Callback, Promise, async/await の記法について確認しよう

ここでは、以下の３つのファイルを動かしながら、 async と promise の違いについて理解していきます。

- `src/asynchronous/file_callback.ts`
- `src/asynchronous/file_promise.ts`
- `src/asynchronous/file_async.ts`

### 1. TypeScript のコードを JavaScript に変換しよう

下記のコマンドを実行して、TypeScript のコードを JavaScript に変換してみましょう。

```terminal
$ npx tsc
```

上記のコマンドにより、次のことが実行されます。

1. `tsc` コマンドが `tsconfig.json` を読み込みます
2. `tsconfig.json` に書かれた `includes` という設定で指定されたファイルを JavaScript にトランスパイルします。今回だと `src/` 以下のファイルが指定されています。
3. トランスパイルした結果のファイルを `outDir` に設定された場所に出力します。今回だと `out/` ディレクトリが指定されています。

実際に実行して、上記の説明通りにトランスパイルされて、`out/` ディレクトリに出力されていることを確認しましょう。

TypeScript と JavaScript のコードを比較し、どんな変換処理が行われているか確認しましょう。確認してわかったことがあれば、「タスクノート」にメモをしてみましょう。

### 2. JavaScript に変換したコードを実行しよう

まずは `src/asynchronous/file_callback.ts` をトランスパイルした結果生成された、 `out/asynchronous/file_callback.js` を実行してみましょう。

```terminal
$ node ./out/asynchronous/file_callback.js
[
  '.eslintrc.js',
  '.git',
  '.gitignore',
  '.prettierignore',
  '.prettierrc.js',
  '.progate',
  'LICENSE',
  'answer_console_log_order.js',
  'node_modules',
  'out',
  'package-lock.json',
  'package.json',
  'public',
  'src',
  'tsconfig.json'
]
```

同様に、 `out/asynchronous/file_promise.js` や `out/asynchronous/file_async.js` も実行して全て同じ結果が出力されることを確認ましょう。

確認できたら、`file_callback.ts`, `file_promise.ts`, `file_async.ts` それぞれの実装で違う点をタスクノートにまとめてみましょう。

## 次に、 Promise や async/await の動作順について考えてみよう

以下の２つのファイルのコードを読み、 1 ~ 6 の `console.log` がどういう順番で表示されるか予想してみましょう。

- `src/asynchronous/console_log_order_promise.ts`
- `src/asynchronous/console_log_order_async.ts`

その後、それぞれを実行してみて予想が正しかったか確認しましょう。

```terminal
$ node ./out/asynchronous/console_log_order_promise.js
$ node ./out/asynchronous/console_log_order_async.js
```

確認できたら `console.log` が表示された順序を `src/answer_console_log_order.js` に記載してください。

その後、 `progate submit` を呼び出して回答を送信しましょう。
