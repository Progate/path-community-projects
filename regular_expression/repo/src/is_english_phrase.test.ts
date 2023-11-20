import {isEnglishPhrase} from "./is_english_phrase";

describe("isEnglishPhrase", () => {
  it("should return true for valid english phrase", () => {
    expect(isEnglishPhrase("Hello World.")).toBe(true);
    expect(isEnglishPhrase("This is Progate Path's task!")).toBe(true);
    expect(isEnglishPhrase("Can you resolve me?")).toBe(true);
  });

  it("should return false for invalid english phrase", () => {
    expect(isEnglishPhrase("Hello World")).toBe(false);
    expect(isEnglishPhrase("This is Progate Path's task#")).toBe(false);
    expect(isEnglishPhrase("Can you resolve me&")).toBe(false);
  });

  it("should return false for invalid english phrase", () => {
    expect(isEnglishPhrase("こんにちは。")).toBe(false);
    expect(isEnglishPhrase("これはプロゲートのタスクです!")).toBe(false);
    expect(isEnglishPhrase("この問題が解けるかな?")).toBe(false);
  });
});
