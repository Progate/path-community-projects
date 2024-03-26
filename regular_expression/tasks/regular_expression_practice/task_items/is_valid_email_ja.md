# メールアドレスとして正しいかチェックしてみよう

ここでは、渡された文字列がメールアドレスとして正しいかチェックする関数 `isValidEmail` を定義します。

コードは `src/is_valid_email.ts` にあります。

## 期待する動作

1. 有効なメールアドレスの場合、`true` を返す
    - 例：`test@example.com`
    - 例：`user.name+tag@example.co.jp`
2. `@` が欠けている場合、`false` を返す
    - 例：`testexample.com`
3. ドメインが欠けている場合、`false` を返す
    - 例：`test@`
4. トップレベルドメイン (TLD) が 1 文字だけの場合、`false` を返す
    - 例：`test@example.c`
5. TLD が 4 文字以上の場合、false を返す
    - 例：`test@example.communi`
6. メールアドレスに無効な文字が含まれている場合、`false` を返す
    - 例：`test@exa*mple.com`
    - 例：`test@exa!mple.com`

---

できたら以下のコマンドを実行して、動作確認しましょう。

```terminal
$ npm run test:is_valid_email
```
