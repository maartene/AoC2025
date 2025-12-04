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

@Suite struct `to get the first star on day 04` {
    @Test func `the number of rolls that can be accessed in the example input should be 13`() {
        #expect(numberOfAccessibleRolls(in: exampleInput) == 13)
    }
    
    @Test func `the number of rolls that can be accessed in the actual input should be 1502`() {
        #expect(numberOfAccessibleRolls(in: input) == 1502)
    }
}
