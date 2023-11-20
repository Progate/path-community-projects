import {isImageFile} from "./is_image_file";

describe("isImageFile", () => {
  it("should return true if the filename end with a extension for image", () => {
    expect(isImageFile("test.png")).toBe(true);
    expect(isImageFile("test.jpeg")).toBe(true);
    expect(isImageFile("test.jpg")).toBe(true);
  });

  it("should return false if the filename doesn't end with a extension for image", () => {
    expect(isImageFile("test.html")).toBe(false);
    expect(isImageFile("test.css")).toBe(false);
    expect(isImageFile("test.js")).toBe(false);
  });

  it("should return false if the filename doesn't contain a dot", () => {
    expect(isImageFile("test")).toBe(false);
  });
});
