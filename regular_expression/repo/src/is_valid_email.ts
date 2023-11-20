export const isValidEmail = (email: string): boolean => {
  //#if SITUATION == REGULAR_EXPRESSION_PRACTICE && ANSWER
  const regex = /^[a-zA-Z0-9._+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
  //#else
  const regex = /* ここにコードを書いてください */;
  //#endif
  return regex.test(email);
};
