// ---------- 型の定義 ----------

// Q1: 変数 a の定義のしかたを修正して型エラーを直してください
// ヒント: const の使い方を調べてみましょう

// ここを変更する
//#if ANSWER
let a: number = 1;
//#else
const a: number = 1;
//#endif

// ここがエラーにならないようにする
a++;

// Q2: 変数 c の定義を修正して型エラーを直してください
const b: number = 2;

// ここの型を修正する
//#if ANSWER
const c: number = b;
//#else
const c: string = b;
//#endif

// Q3: 変数 d の定義を修正して型エラーを直してください

// ここの型を修正する
//#if ANSWER
const d: "hello" = "hello";
//#else
const d: string = "hello";
//#endif

// ここがエラーにならないようにする
const e: "hello" = d;

// ---------- 型推論 (Type Inference) ----------

// Q4: 変数 g の定義を修正して型エラーを直してください
const f = 1;

//#if ANSWER
const g: number = f;
//#else
const g: /* ここに型を書く */ = f;
//#endif
