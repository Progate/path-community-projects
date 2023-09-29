// Q: FuncType という型を定義して、エラーを解消してください。
//#if ANSWER
type FuncType = (x: number) => number;
//#else
type FuncType = /* ここに定義を書く */;
//#endif

// ここのエラーを解消する
const addOne: FuncType = (x: number): number => x + 1;

// Q: SumFunc という型を定義して、エラーを解消してください。
//#if ANSWER
type SumFunc = (numbers: number[]) => number;
//#else
type SumFunc = /* ここに定義を書く */;
//#endif
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
//#if ANSWER
type Array1 = number[];
// This is also good:
// type Array1 = Array<number>;
//#else
type Array1 = /* 定義を書く */;
//#endif
const array1_1: Array1 = [1];
const array1_2: Array1 = [1, 2, 3, 4, 5];
// @ts-expect-error string is not allowed for the `Array1`.
const array1_3: Array1 = ["string", "is", "not", "allowed"];

// Q: number か string が入る配列、Array2 を定義してください
//#if ANSWER
type Array2 = Array<number | string>;
// This is also good, but not allowed by current eslint rules.
// type Array2 = (number | string)[];
//#else
type Array2 = /* 定義を書く */;
//#endif
const array2_1: Array2 = [1, "string", 2, "is", 3, "allowed"];
// @ts-expect-error boolean is not allowed for the `Array2`.
const array2_2: Array2 = [true, false, true, false];

// Q: number と string のちょうど 2 要素だけが入るタプル、Tuple1 を定義してください
//#if ANSWER
type Tuple1 = [number, string];
//#else
type Tuple1 = /* 定義を書く */;
//#endif
const tuple1_1: Tuple1 = [1, "string is here"];
// @ts-expect-error too many elements.
const tuple1_2: Tuple1 = [1, "this is bad", 3, 4, 5];
// @ts-expect-error types are not matched.
const tuple1_3: Tuple1 = ["string", 1];
