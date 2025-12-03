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
    
    @Test(arguments: [
        ("987654321111111", 98),
        ("811111111111119", 89),
        ("711111111111118", 78),
        ("234234234234278", 78),
        ("818181911112111", 92),
    ]) func `the maximum joltage from bank 1 should be 98`(testcase: (bank: String, expected: Int)) {
        #expect(maximumJoltageFromBank(stringToIntArray(testcase.bank)) == testcase.expected)
    }
    
    @Test func `the maximum joltage from the actual input should be 17330`() {
        #expect(maximumJoltageFrom(input) == 17330)
    }
}
