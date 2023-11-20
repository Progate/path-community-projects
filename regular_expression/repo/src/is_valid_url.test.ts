import {isValidUrl} from "./is_valid_url";

describe("isValidUrl", () => {
  it("should return true for valid URLs", () => {
    expect(isValidUrl("https://example.com")).toBe(true);
    expect(isValidUrl("http://example.com/path?query=value#hash")).toBe(true);
  });

  it("should return false for invalid URLs", () => {
    expect(isValidUrl("https:/example.com")).toBe(false); // Invalid protocol format
    expect(isValidUrl("example.com")).toBe(false); // Missing protocol
    expect(isValidUrl("https://")).toBe(false); // Missing domain
  });

  it("should return false for non-URL strings", () => {
    expect(isValidUrl("Just a regular string")).toBe(false);
    expect(isValidUrl("123456")).toBe(false);
    expect(isValidUrl("")).toBe(false); // Empty string
  });
});
