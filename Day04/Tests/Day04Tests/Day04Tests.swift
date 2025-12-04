import Testing
@testable import Day04

let exampleInput =
"""
..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.
"""

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
}

@Suite struct `to get the first star on day 04` {
    @Test func `the number of rolls that can be accessed in the example input should be 13`() {
        #expect(numberOfAccessibleRolls(in: exampleInput) == 13)
    }
}
