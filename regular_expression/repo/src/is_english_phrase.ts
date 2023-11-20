export const isEnglishPhrase = (phrase: string): boolean => {
  //#if SITUATION == REGULAR_EXPRESSION_PRACTICE && ANSWER
  const regex = /^([A-Z|a-z|0-9|']+\s)*[A-Z|a-z|0-9|']+[.|!|?]$/;
  //#else
  const regex = /* ここにコードを書いてください */;
  //#endif
  return regex.test(phrase);
};
