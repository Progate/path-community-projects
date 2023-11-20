export const isValidUrl = (url: string): boolean => {
  //#if SITUATION == REGULAR_EXPRESSION_PRACTICE && ANSWER
  const regex = /^(https?):\/\/[^\s/$.?#].[^\s]*$/;
  //#else
  const regex = /* ここにコードを書いてください */;
  //#endif
  return regex.test(url);
};
