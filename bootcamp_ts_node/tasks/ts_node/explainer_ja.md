# 解説

解説動画を参照してください。

<iframe width="560" height="315" src="https://www.youtube.com/embed/qr-CjSbPSG4" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

## TypeScriptの型を修正しよう

`src/quiz/01.ts`

```ts
// ---------- 型の定義 ----------

// Q1: 変数 a の定義のしかたを修正して型エラーを直してください
// ヒント: const の使い方を調べてみましょう

// ここを変更する
let a: number = 1;

// ここがエラーにならないようにする
a++;

// Q2: 変数 c の定義を修正して型エラーを直してください
const b: number = 2;

// ここの型を修正する
const c: number = b;

// Q3: 変数 d の定義を修正して型エラーを直してください

// ここの型を修正する
const d: "hello" = "hello";

// ここがエラーにならないようにする
const e: "hello" = d;

// ---------- 型推論 (Type Inference) ----------

// Q4: 変数 g の定義を修正して型エラーを直してください
const f = 1;

const g: number = f;
```

`src/quiz/02.ts`

```ts
// Q: FuncType という型を定義して、エラーを解消してください。
type FuncType = (x: number) => number;

// ここのエラーを解消する
const addOne: FuncType = (x: number): number => x + 1;

// Q: SumFunc という型を定義して、エラーを解消してください。
type SumFunc = (numbers: number[]) => number;
const sumAll: SumFunc = (numbers) => {
  let sum = 0;
  for (const n of numbers) {
    sum += n;
  }
  return sum;
};
// ここがエラーにならないようにする
const total: number = sumAll([1, 2, 3, 4, 5]);
// ここはエラーになる
// @ts-expect-error Array<string> is not allowed
const totalError1: number = sumAll(["a", "b", "c"]);
// @ts-expect-error number is not allowed
const totalError2: number = sumAll(1);

// Q: number が入る配列, Array1 を定義してください
type Array1 = number[];
// This is also good:
// type Array1 = Array<number>;
const array1_1: Array1 = [1];
const array1_2: Array1 = [1, 2, 3, 4, 5];
// @ts-expect-error string is not allowed for the `Array1`.
const array1_3: Array1 = ["string", "is", "not", "allowed"];

// Q: number か string が入る配列、Array2 を定義してください
type Array2 = Array<number | string>;
// This is also good, but not allowed by current eslint rules.
// type Array2 = (number | string)[];
const array2_1: Array2 = [1, "string", 2, "is", 3, "allowed"];
// @ts-expect-error boolean is not allowed for the `Array2`.
const array2_2: Array2 = [true, false, true, false];

// Q: number と string のちょうど 2 要素だけが入るタプル、Tuple1 を定義してください
type Tuple1 = [number, string];
const tuple1_1: Tuple1 = [1, "string is here"];
// @ts-expect-error too many elements.
const tuple1_2: Tuple1 = [1, "this is bad", 3, 4, 5];
// @ts-expect-error types are not matched.
const tuple1_3: Tuple1 = ["string", 1];
```

`src/quiz/03.ts`

```ts
// Q: 文字列の長さを "short", "medium", "long" の３種類に判定する関数の返り値の型を定義してください。
// ヒント: literal types と union types を使うと実現できます。
type StringLength = "short" | "medium" | "long";
const getStringLength = (s: string): StringLength => {
  if (s.length === 0) {
    // @ts-expect-error getStringLength should not return any invalid values.
    return "type error if other than 'short', 'medium', 'long'";
  } else if (s.length <= 5) {
    return "short";
  } else if (s.length <= 10) {
    return "medium";
  } else {
    return "long";
  }
};

// Q: 配列 `array` と値 `value` を受け取り、配列の中に `value` が含まれるか判定して boolean
//    を返す、 `includes` という関数の型を定義してください。
//    このとき、配列の要素の型は `value` の型と同じであることを型で表現してください。
// ヒント: Generics を使うと実現できます。

// 以下の行を書き換えて型を与えてください。
const includes = <T>(array: T[], value: T): boolean => {
  // 変更箇所はこの上の行まで
  for (const v of array) {
    if (v === value) {
      return true;
    }
  }
  return false;
};

const includesOk1 = includes([1, 2, 3], 4);
const includesOk2: boolean = includes(["a", "b"], "c");
// @ts-expect-error "message" doesn't match with the type of array (Array<number>).
const includesTypeError1: boolean = includes([1, 2, 3], "message");

// Q: パスワードが条件を満たしているか判定し、条件を満たしているときは "ok", 満たしていないときには
//    "missingNumber", "missingSmallLetter", "missingCapitalLetter" を返す関数
//    `checkPasswordRequirement` の型を定義してください。
//    引数はパスワードが入った文字列に加え、設定のオブジェクトを受け取ることもできます。
//    このとき、設定のオブジェクトの型は `PasswordRequirementOption` で定義されています。
type PasswordRequirementOption = {
  requireNumbers: boolean;
  requireSmallLetters: boolean;
  requireCapitalLetters: boolean;
};
type PasswordRequirementResult =
  | "ok"
  | "missingNumber"
  | "missingSmallLetter"
  | "missingCapitalLetter";

const checkPasswordRequirement = (
  password: string,
  option?: PasswordRequirementOption
): PasswordRequirementResult => {
  if (option?.requireNumbers) {
    if (!/\d/.test(password)) {
      return "missingNumber";
    }
  }
  if (option?.requireSmallLetters) {
    if (!/[a-z]/.test(password)) {
      return "missingSmallLetter";
    }
  }
  if (option?.requireCapitalLetters) {
    if (!/[A-Z]/.test(password)) {
      return "missingCapitalLetter";
    }
  }
  return "ok";
};

const checkPasswordRequirementOk1 = checkPasswordRequirement("password");
const checkPasswordRequirementOk4 = checkPasswordRequirement("password123", {
  requireNumbers: true,
  requireSmallLetters: true,
  requireCapitalLetters: true,
});
const checkPasswordRequirementTypeError1: PasswordRequirementResult =
  // @ts-expect-error the first argument is not a `string`.
  checkPasswordRequirement(1);
const checkPasswordRequirementTypeError2: PasswordRequirementResult =
  // @ts-expect-error the second argument is not a `PasswordRequirementOption`.
  checkPasswordRequirement("password", 1);
const checkPasswordRequirementTypeError3: PasswordRequirementResult =
  // @ts-expect-error the second argument does not have some properties.
  checkPasswordRequirement("password", { requireNumbers: 1 });
const checkPasswordRequirementTypeError4: PasswordRequirementResult =
  // @ts-expect-error the second argument has a unknown property.
  checkPasswordRequirement("password", { unknownOptions: false });
```

## Promise と async/await の記法について理解しよう

`src/answer_console_log_order.js`

```js
exports.default = {
  // conosle_log_order_promise.ts を実行しましょう。
  // 表示された順に1~6の番号を記入してください。
  consoleLogOrderPromise: [1, 3, 6, 2, 4, 5],

  // conosle_log_order_async.ts を実行しましょう。
  // 表示された順に1~6の番号を記入してください。
  consoleLogOrderAsync: [1, 3, 6, 2, 4, 5],
}
```

## npm scripts を使えるようにしよう

`package.json`

```json
{
  "scripts": {
    "build": "tsc",
    "format:fix": "prettier --write 'src/**/*.ts'"
  },
  ...
}
```

## HTTP サーバーを実装してみよう

`src/server.ts`

```ts
import http from "node:http";
import fs from "node:fs/promises";
import path from "node:path";
const server = http.createServer();

server.on("request", async (req, res) => {
  console.log("request url: ", req.url);
  try {
    if (req.url === undefined) throw new Error("req.url is undefined");
    const filePath = req.url === "/" ? "/index.html" : req.url;
    const file = await fs.readFile(
      path.join(path.resolve(), "public", filePath)
    );

    const mimeTypes: { [key: string]: string } = {
      ".html": "text/html",
      ".json": "text/json",
      ".jpg": "image/jpeg",
      ".ico": "image/x-icon",
    };
    const extname = String(path.extname(req.url)).toLowerCase();
    const contentType: string =
      mimeTypes[extname] || "application/octet-stream";

    res.writeHead(200, { "content-type": contentType });
    res.end(file, "utf-8");
    return;
  } catch (err) {
    console.error("error: ", err);
    const error = err as NodeJS.ErrnoException;
    if (error.code === "ENOENT") {
      res.writeHead(404, { "content-type": "text/plain" });
      return res.end("404 Not Found");
    } else {
      res.writeHead(500, { "content-type": "text/plain" });
      return res.end("500 Internal Server Error");
    }
  }
});

server.on("listening", () => {
  console.log("start listening!");
});

const port = process.env.PORT ?? 12345;
server.listen(port, () => {
  console.log(`listening on http://localhost:${port}/`);
});
console.log("run server.js");
```
