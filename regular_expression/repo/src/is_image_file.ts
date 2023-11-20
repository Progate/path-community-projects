export const isImageFile = (fileName: string): boolean => {
  //#if SITUATION == REGULAR_EXPRESSION_PRACTICE && ANSWER
  const regex = /^.+\.(png|jpeg|jpg)$/;
  //#else
  const regex = /* ここにコードを書いてください */;
  //#endif
  return regex.test(fileName);
};
  