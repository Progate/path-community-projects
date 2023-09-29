# npm scripts を使えるようにしよう

`package.json` を変更し、下記のコマンドを実行できるようにしましょう。

- `npm run build`
- `npm run format:fix`

## `npm run build` コマンドを使えるようにしよう

- `package.json` を変更し、 `npm run build` とやると `tsc` コマンドを呼び出して TypeScript を JavaScript にトランスパイルするようにしましょう。

## `npm run format:fix` コマンドを使えるようにしよう

- `npm run format:fix` を実行してコードフォーマットを修正できるようにしましょう。
  - パッケージは `prettier` を使ってください。自分でパッケージをインストールしてみましょう。
  - テストの判定は下記を確認します
    - `npm run format:fix` コマンドが実行できること
    - 適切にフォーマットが整っていること
      - `npx prettier --check 'src/**/*.{js,ts}'` でエラーが出なければ OK

----
仕様を満たせたと判断したら、 `progate submit` コマンドを実行してみてください。
