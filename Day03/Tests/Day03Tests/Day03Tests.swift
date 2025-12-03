import Testing
@testable import Day03

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

let exampleInput =
"""
987654321111111
811111111111119
234234234234278
818181911112111
"""

@Suite struct `to get the first star on day 03` {
    @Test func `the maximum joltage from the example input should be 357`() {
        #expect(maximumJoltageFrom(exampleInput) == 357)
    }
}
