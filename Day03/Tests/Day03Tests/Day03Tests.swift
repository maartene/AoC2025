import Testing
@testable import Day03

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
    ]) func `the maximum joltage from banks for two digits`(testcase: (bank: String, expected: Int)) {
        #expect(cachedmaximumJoltageFromBank( stringToIntArray(testcase.bank), maxDigits: 2) == testcase.expected)
    }
    
    @Test func `the maximum joltage from the actual input should be 17330`() {
        #expect(maximumJoltageFrom(input) == 17330)
    }
}

@Suite struct `to get the second star on day 03` {
    @Test(arguments: [
        ("987654321111111", 987654321111),
        ("811111111111119", 811111111119),
        ("234234234234278", 434234234278),
        ("818181911112111", 888911112111),
    ]) func `the maximum joltage from banks from 12 digits`(testcase: (bank: String, expected: Int)) {
        #expect(cachedmaximumJoltageFromBank(stringToIntArray(testcase.bank), maxDigits: 12) == testcase.expected)
    }
    
    @Test func `the maximum joltage from the example input should be 3121910778619`() {
        #expect(maximumJoltageFrom(exampleInput, maxDigits: 12) == 3121910778619)
    }
    
    @Test(arguments: [
        ("2343453422641331233623444434443422422234243434644344344333436434324443344243444547343426444313413747", 764443413747),
    ]) func `the maximum joltage from a large bank`(testcase: (bank: String, expected: Int)) {
        #expect(cachedmaximumJoltageFromBank( stringToIntArray(testcase.bank), maxDigits: 12) == testcase.expected)
    }
    
    @Test func `the maximum joltage from the actual input should be 171518260283767`() {
        #expect(maximumJoltageFrom(input, maxDigits: 12) == 171518260283767)
    }
}
