import { initMap } from "./map";

describe("initMap", () => {
  test("should return a map object", () => {
    const map = initMap();
    expect(map).toBeInstanceOf(Object);
  });
})





