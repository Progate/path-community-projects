# 画像のファイル名として正しいかチェックしてみよう

引数にメールアドレスを受け取る関数 `isImageFile` を定義してください。

コードは `src/is_image_file.ts` にあります。テストコードは `src/is_image_file.test.ts` にあります。

## 期待する動作

1. 拡張子が `png`, `jpeg`, `jpg` の場合、`true` を返す
    - 例： `test.png`
2. 拡張子が `png`, `jpeg`, `jpg` 以外の場合、`false` を返す
    - 例： `test.html`
3. `.`（ドット）が含まれていない場合、`false` を返す
    - 例： `test`

---

できたら以下のコマンドを実行して、動作確認しましょう。

```terminal
$ npm run test:is_image_file
```

また、タスクを完了するために `progate submit` を実行しましょう。

```terminal
$ progate submit
```
