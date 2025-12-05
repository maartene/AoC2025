import Foundation
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
    
    @Test func `the number of fresh ingredients in the actual input should be 617`() {
        #expect(numberOfFreshIngredients(in: input) == 617)
    }
}

@Suite struct `to get the second star on day 05` {
    @Test func `the number of fresh ingredient IDs in the example input should be 14`() {
        #expect(numberOfFreshIngredientIDs(in: exampleInput) == 14)
    }
    
    @Test(arguments: [
        (3...5, 10...14, Set([3...5, 10...14])),
        (10...14, 3...5, Set([3...5, 10...14])),
        (1...6, 3...5, Set([1...6])),
        (3...5, 1...6, Set([1...6])),
        (1...5, 3...7, Set([1...7])),
        (3...7, 1...5, Set([1...7])),
    ]) func `combining ranges should provide the correct result`(testcase: (range1: ClosedRange<Int>, range2: ClosedRange<Int>, expectedRanges: Set<ClosedRange<Int>>)) {
        #expect(combineRanges(range1: testcase.range1, range2: testcase.range2) == testcase.expectedRanges)
    }
    
    @Test func `combining multiple ranges`() {
        let ranges:Set = [
            3...5,
            10...14,
            16...20,
            12...18,
        ]
        
        let expectedRanges: Set = [
            3...5, 10...20
        ]
        
        #expect(combineRanges(ranges) == expectedRanges)
    }
}
