import Testing
@testable import Day02

let exampleInput =
    "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

@Suite struct `To get the first star on day 02` {
    @Test func `the sum of all invalid IDs in the example input should be 1227775554`() {
        #expect(sumOfInvalidIdsIn(exampleInput) == 1227775554)
    }
    
    @Test(arguments: [
        (11, 22, [11,22]),
        (95, 105, [99]),
        (998, 1012, [1010]),
        (1698522, 1698528, []),
        (1188511880, 1188511890, [1188511885]),
    ]) func `the invalid ID in the range should be the expected result`(testcase: (lowerBound: Int, upperBound: Int, expectedResult: [Int])) {
        #expect(invalidIDsIn(lowerBound: testcase.lowerBound, upperBound: testcase.upperBound) == testcase.expectedResult)
    }
}
