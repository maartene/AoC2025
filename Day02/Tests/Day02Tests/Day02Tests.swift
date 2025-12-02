import Testing
@testable import Day02

let exampleInput =
    "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

@Suite struct `To get the first star on day 02` {
    @Test func `the sum of all invalid IDs in the example input should be 1227775554`() {
        #expect(part1(exampleInput) == 1227775554)
    }
    
    @Test(arguments: [
        (11...22, [11,22]),
        (95...105, [99]),
        (998...1012, [1010]),
        (1698522...1698528, []),
        (1188511880...1188511890, [1188511885]),
    ]) func `the invalid ID in the range should be the expected result`(testcase: (range: ClosedRange<Int>, expectedResult: [Int])) {
        #expect(invalidIDsInOneRepeatOnly(testcase.range) == testcase.expectedResult)
    }
    
    @Test func `the sum of all invalid IDs in the actual input should be 23560874270`() {
        #expect(part1(input) == 23560874270)
    }
}

@Suite struct `To get the second star on day 02` {
    @Test func `the sum of all invalid IDs in the example input should be 4174379265`() {
        #expect(part2(exampleInput) == 4174379265)
    }
    
    @Test(arguments: [
        (11...22, [11,22]),
        (95...115, [99,111]),
        (998...1012, [999,1010]),
        (1698522...1698528, []),
        (1188511880...1188511890, [1188511885]),
        (222220...222224, [222222]),
        (446443...446449, [446446]),
        (38593856...38593862, [38593859]),
        (565653...565659, [565656]),
        (824824821...824824827, [824824824]),
        (2121212118...2121212124, [2121212121])
    ]) func `the invalid ID in the range should be the expected result`(testcase: (range: ClosedRange<Int>, expectedResult: [Int])) {
        #expect(invalidIDsAllowingMultipleRepeats(testcase.range) == testcase.expectedResult)
    }
    
    @Test func `the sum of all invalid IDs in the actual input should be 44143124633`() {
        #expect(part2(input) == 44143124633)
    }
}
