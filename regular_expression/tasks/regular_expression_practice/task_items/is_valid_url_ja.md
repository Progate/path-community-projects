# URL として正しいかチェックしてみよう

ここでは、渡された文字列が URL として正しいかチェックする関数 `isValidUrl` を定義します。

コードは `src/is_valid_url.ts` にあります。テストコードは `src/is_valid_url.test.ts` にあります。

## 期待する動作

- 有効な URL の場合、`true` を返す
  - `http://` または `https://` で始まり、ドメイン名が存在する（例: `https://example.com`）
- 無効な URL の場合、`false` を返す
  - プロトコルの形式が正しくない（例: `https:/example.com`）
  - プロトコルが不足している（例: `example.com`）
  - ドメインが欠落している（例: `https://`）
- UR Lとして解釈されない文字列の場合、`false` を返す
  - 通常の文字列（例: `Just a regular string`）
  - 数字のみの文字列（例: `123456`）
  - 空の文字列

---

できたら以下のコマンドを実行して、動作確認しましょう。

```terminal
$ npm run test:is_valid_url
```
