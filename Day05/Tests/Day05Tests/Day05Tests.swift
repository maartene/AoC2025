import Testing
@testable import Day05

let exampleInput =
"""
3-5
10-14
16-20
12-18

1
5
8
11
17
32
"""

@Suite struct `to get the first star on day 05` {
    @Test func `the number of fresh ingredients in the example input should be 3`() {
        #expect(numberOfFreshIngredients(in: exampleInput) == 3)
    }
}
