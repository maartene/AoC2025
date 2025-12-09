import Testing
@testable import Day09

let exampleInput =
"""
7,1
11,1
11,7
9,7
9,5
2,5
2,3
7,3
"""

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

@Suite struct `to get the first star on day 09` {
    @Test func `the largest rectangle area for the example input should be 50`() {
        #expect(largestRectangleArea(in: exampleInput) == 50)
    }
}
