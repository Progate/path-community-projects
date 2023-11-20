import {isValidEmail} from "./is_valid_email";

describe("isValidEmail", () => {
  it("should return true for valid email addresses", () => {
    expect(isValidEmail("test@example.com")).toBe(true);
    expect(isValidEmail("user.name+tag@example.co.jp")).toBe(true);
  });

  it('should return false if "@" is missing', () => {
    expect(isValidEmail("testexample.com")).toBe(false);
  });

  it("should return false if domain is missing", () => {
    expect(isValidEmail("test@")).toBe(false);
  });

  it("should return false if TLD is only one character", () => {
    expect(isValidEmail("test@example.c")).toBe(false);
  });

  it("should return false if TLD is four or more characters", () => {
    expect(isValidEmail("test@example.communi")).toBe(false);
  });

  it("should return false for email addresses with invalid characters", () => {
    expect(isValidEmail("test@exa*mple.com")).toBe(false);
    expect(isValidEmail("test@exa!mple.com")).toBe(false);
  });
});
